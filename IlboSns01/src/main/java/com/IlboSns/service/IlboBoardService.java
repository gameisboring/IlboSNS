package com.IlboSns.service;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.IlboSns.dao.IlboBoardDao;
import com.IlboSns.dto.IlboBoardDto;
import com.IlboSns.dto.IlboBoardGpDto;
import com.IlboSns.dto.IlboBoardLikeDto;
import com.IlboSns.dto.IlboBoardModifyDto;
import com.IlboSns.dto.IlboBoardReplyDto;
import com.IlboSns.dto.IlboBoardViewDto;
import com.IlboSns.dto.IlboGroupDto;
import com.IlboSns.dto.IlboGroupMemberDto;
import com.IlboSns.dto.IlboGroupRequestDto;
import com.IlboSns.dto.IlboRankingDto;
import com.IlboSns.manager.BoardModifyManager;
import com.google.gson.Gson;

@Service
public class IlboBoardService {

	@Autowired
	IlboBoardDao ibdao;

	ModelAndView mav = new ModelAndView();
	private final SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); // date타입의 포맷을 관리

	@Autowired
	HttpSession session;

	@Autowired
	BoardModifyManager bmm;

	String savePathPicture = "D:\\spring\\IlboSns01\\src\\main\\webapp\\resources\\assets\\img\\boardFile"; // 게시판 이미지
																											// 저장하는경로
	String savePathVideo = "D:\\spring\\IlboSns01\\src\\main\\webapp\\resources\\assets\\video"; // 게시판 영상 저장하는경로

	String savePathGroupImg = "D:\\spring\\IlboSns01\\src\\main\\webapp\\resources\\assets\\img\\groupfile";

	public String getBoard(int num) {

		int loginId = (int) session.getAttribute("loginId");

		int start = num + 1;
		int end = num + 6;

		ArrayList<IlboBoardViewDto> list = new ArrayList<IlboBoardViewDto>();
		list = ibdao.getBoard(start, end, loginId);

		list.forEach(item->{
			if(item.getBoContent() != null)
				item.setBoContentWithTag(item.getBoContent().replaceAll("\r\n", "<br>"));
			});

		Gson gson = new Gson();
		String json = gson.toJson(list);

		return json;
	}

	public String getBoardByBoNum(int boNum) {

		IlboBoardViewDto ibdto = ibdao.getBoardByBoNum(boNum);

		if (ibdto != null)
			ibdto.setBoContentWithTag(ibdto.getBoContent().replaceAll("\r\n", "<br>"));

		if (ibdto == null) {
			ibdto = IlboBoardViewDto.builder().boContent("삭제된 게시글입니다.").memName("삭제된 게시글입니다.").boType("NORMAL")
					.memProfile("default.jpg").build();
		}
		
		Gson gson = new Gson();
		String json = gson.toJson(ibdto);

		System.out.println(json);
		
		return json;
	}

	public String getBoardById(int num, int id) {

		int start = num + 1;
		int end = num + 6;

		ArrayList<IlboBoardViewDto> list = new ArrayList<IlboBoardViewDto>();
		list = ibdao.getBoardById(start, end, id);

		list.forEach((e) -> {
			if (e.getBoContent() != null) {
				e.setBoContentWithTag(e.getBoContent().replaceAll("\r\n", "<br>"));
			}
		});

		Gson gson = new Gson();
		String json = gson.toJson(list);

		return json;
	}

	// 게시판 작성

	public ModelAndView boardWrite(IlboBoardDto bdto) throws IllegalStateException, IOException {
		String boFile = "";
		ArrayList<MultipartFile> files = bdto.getBoMutipleFile(); // dto에서 배열로 받아서 새로운 배열에 저장

		System.out.println("bdto.getBoMutipleFile().get(0).getOriginalFilename() = "
				+ bdto.getBoMutipleFile().get(0).getOriginalFilename());
		String file = bdto.getBoMutipleFile().get(0).getOriginalFilename(); // !files.isEmpty() 파일이없어도 실행되어서 판별식을위한 변수선

		int insertBoResult = 0;

		if (files.size() > 1) {
			// files are multiple
			int getBoardNum = ibdao.selectBoardNum(); // 게시판 번호 생성
			bdto.setBoNum(getBoardNum); // dto에 담아준다
			bdto.setBoType("MULTI");
			bdto.setBoFile("");
			insertBoResult = ibdao.insertBoWrite(bdto); // 인서트

			insertBoResult = insertMultiplePicture(files, bdto);
		} else {
			bdto.setBoType("NORMAL");
			if (file != "") { // 파일이있으면 실행
				String uuid = UUID.randomUUID().toString().substring(0, 7);
				boFile += uuid + "__" + files.get(0).getOriginalFilename();
				if (files.get(0).getContentType().startsWith("image"))
					bdto.setBoType("PICTURE");

				if (files.get(0).getContentType().startsWith("video"))
					bdto.setBoType("VIDEO");

				if (bdto.getBoType().equals("PICTURE"))
					files.get(0)
							.transferTo(new File(savePathPicture, uuid + "__" + files.get(0).getOriginalFilename()));
				else if (bdto.getBoType().equals("VIDEO"))
					files.get(0).transferTo(new File(savePathVideo, uuid + "__" + files.get(0).getOriginalFilename()));
			}
			bdto.setBoFile(boFile); // 배열에 담긴 사진이름을 dto에 저장

			int getBoardNum = ibdao.selectBoardNum(); // 게시판 번호 생성
			bdto.setBoNum(getBoardNum); // dto에 담아준다

			insertBoResult = ibdao.insertBoWrite(bdto); // 인서트

			if (insertBoResult <= 0) {

				if (bdto.getBoType().equals("PICTURE"))
					new File(savePathPicture, bdto.getBoFile()).delete();
				else if (bdto.getBoType().equals("VIDEO"))
					new File(savePathVideo, bdto.getBoFile()).delete();
			}

		}

		if (insertBoResult > 0) {

			// 해시태그 입력
			String[] splitedArray = bdto.getBoContent().split(" ");
			System.out.println("splitedArray 0 : " + splitedArray[0]);

			for (int i = 0; i < splitedArray.length; i++) {
				String hashTag = splitedArray[i];
				if (hashTag.indexOf('#') == 0) {
					int bNum = bdto.getBoNum();
					int selectPostTagNum = ibdao.selectPostTagNum() + 1; // ILBO_BOARD_TAG 테이블 태그넘버생성
					int insertBoardTag = ibdao.insertBoardTag(bNum, selectPostTagNum); // ILBO_BOARD_TAG 테이블 인서트
					int insertTag = ibdao.insertTag(selectPostTagNum, hashTag); // ILBO_TAG 테이블 인서트
				}
			}

			mav.setViewName("redirect:/main");
		}

		return mav;
	}

	int insertMultiplePicture(ArrayList<MultipartFile> files, IlboBoardDto bdto)
			throws IllegalStateException, IOException {
		int result = 1;

		System.out.println("for문실행");
		for (int i = 0; i < files.size(); i++) {

			String uuid = UUID.randomUUID().toString().substring(0, 7);
			String boFile = uuid + "__" + files.get(i).getOriginalFilename();

			if (files.get(i).getContentType().startsWith("image"))
				files.get(i).transferTo(new File(savePathPicture, boFile));

			if (files.get(i).getContentType().startsWith("video"))
				files.get(i).transferTo(new File(savePathVideo, boFile));

			IlboBoardDto ibdto = new IlboBoardDto();
			ibdto.setBoGroupNum(bdto.getBoNum());
			if (files.get(i).getContentType().startsWith("image"))
				ibdto.setBoType("PICTURE");

			if (files.get(i).getContentType().startsWith("video"))
				ibdto.setBoType("VIDEO");

			ibdto.setBoContent("");
			ibdto.setBoWriter(bdto.getBoWriter());
			ibdto.setBoVisiblity(bdto.getBoVisiblity());
			ibdto.setBoFile(boFile);
			ibdto.setBoWritersName(bdto.getBoWritersName());
			ibdto.setBoNum(ibdao.selectBoardNum());
			result *= ibdao.insertBoWrite(ibdto);

			if (result <= 0) {
				if (bdto.getBoType().equals("PICTURE"))
					new File(savePathPicture, bdto.getBoFile()).delete();
				else if (bdto.getBoType().equals("VIDEO"))
					new File(savePathVideo, bdto.getBoFile()).delete();

			}
		}

		return result;
	}

	// 그룹에있는 게시판 작성

	public ModelAndView groupBoardWrite(IlboBoardGpDto bGpdto) throws IllegalStateException, IOException {
		String boFile = "";
		ArrayList<MultipartFile> files = bGpdto.getBoMutipleFile(); // dto에서 배열로 받아서 새로운 배열에 저장

		System.out.println("bdto.getBoMutipleFile().get(0).getOriginalFilename() = "
				+ bGpdto.getBoMutipleFile().get(0).getOriginalFilename());
		String file = bGpdto.getBoMutipleFile().get(0).getOriginalFilename(); // !files.isEmpty() 파일이없어도 실행되어서 판별식을위한
																				// 변수선

		int insertBoResult = 0;

		if (files.size() > 1) {
			// files are multiple
			int getBoardNum = ibdao.selectBoardNum(); // 게시판 번호 생성
			bGpdto.setBoNum(getBoardNum); // dto에 담아준다
			bGpdto.setBoType("MULTI");
			bGpdto.setBoFile("");
			insertBoResult = ibdao.insertGroupBoWrite(bGpdto); // 인서트

			insertBoResult = insertGroupMultiplePicture(files, bGpdto);
		} else {
			bGpdto.setBoType("NORMAL");
			if (file != "") { // 파일이있으면 실행
				String uuid = UUID.randomUUID().toString().substring(0, 7);
				boFile += uuid + "__" + files.get(0).getOriginalFilename();
				if (files.get(0).getContentType().startsWith("image"))
					bGpdto.setBoType("PICTURE");

				if (files.get(0).getContentType().startsWith("video"))
					bGpdto.setBoType("VIDEO");

				if (bGpdto.getBoType().equals("PICTURE"))
					files.get(0)
							.transferTo(new File(savePathPicture, uuid + "__" + files.get(0).getOriginalFilename()));
				else if (bGpdto.getBoType().equals("VIDEO"))
					files.get(0).transferTo(new File(savePathVideo, uuid + "__" + files.get(0).getOriginalFilename()));
			}
			bGpdto.setBoFile(boFile); // 배열에 담긴 사진이름을 dto에 저장

			int getBoardNum = ibdao.selectBoardNum(); // 게시판 번호 생성
			bGpdto.setBoNum(getBoardNum); // dto에 담아준다

			insertBoResult = ibdao.insertGroupBoWrite(bGpdto); // 인서트

			if (insertBoResult <= 0) {

				if (bGpdto.getBoType().equals("PICTURE"))
					new File(savePathPicture, bGpdto.getBoFile()).delete();
				else if (bGpdto.getBoType().equals("VIDEO"))
					new File(savePathVideo, bGpdto.getBoFile()).delete();
			}

		}

		int gpNum = bGpdto.getGpNum();
		if (insertBoResult > 0) {
			
			//해시태그 입력
			String [] splitedArray = bGpdto.getBoContent().split(" ");
			System.out.println("splitedArray 0 : "+ splitedArray[0]);
			
			for(int i=0; i < splitedArray.length;i++) {
				String hashTag = splitedArray[i];
				if(hashTag.indexOf('#') == 0) {
					int bNum = bGpdto.getBoNum();
					int selectPostTagNum = ibdao.selectPostTagNum() + 1; //ILBO_BOARD_TAG 테이블 태그넘버생성
					int insertBoardTag = ibdao.insertBoardTag(bNum,selectPostTagNum); // ILBO_BOARD_TAG 테이블 인서트
					int insertTag = ibdao.insertTag(selectPostTagNum,hashTag); //ILBO_TAG 테이블 인서트
				}
			  }
			mav.setViewName("redirect:/groupInfo?gpNum=" + gpNum);
		}

		return mav;
	}

	int insertGroupMultiplePicture(ArrayList<MultipartFile> files, IlboBoardGpDto bGpdto)
			throws IllegalStateException, IOException {
		int result = 1;

		System.out.println("for문실행");
		for (int i = 0; i < files.size(); i++) {

			System.out.println("ibdao.selectBoardNum() : " + ibdao.selectBoardNum());

			String uuid = UUID.randomUUID().toString().substring(0, 7);
			String boFile = uuid + "__" + files.get(i).getOriginalFilename();

			if (files.get(i).getContentType().startsWith("image"))
				files.get(i).transferTo(new File(savePathPicture, boFile));

			if (files.get(i).getContentType().startsWith("video"))
				files.get(i).transferTo(new File(savePathVideo, boFile));

			IlboBoardGpDto ibGpdto = new IlboBoardGpDto();
			System.out.println("테스트1");
			ibGpdto.setBoGroupNum(bGpdto.getBoNum());
			if (files.get(i).getContentType().startsWith("image"))
				ibGpdto.setBoType("PICTURE");

			if (files.get(i).getContentType().startsWith("video"))
				ibGpdto.setBoType("VIDEO");
			System.out.println("테스트2");
			ibGpdto.setBoContent("");
			ibGpdto.setBoWriter(bGpdto.getBoWriter());
			ibGpdto.setBoVisiblity(bGpdto.getBoVisiblity());
			System.out.println("테스트3");
			ibGpdto.setBoFile(boFile);
			ibGpdto.setBoWritersName(bGpdto.getBoWritersName());
			ibGpdto.setBoNum(ibdao.selectBoardNum());
			ibGpdto.setGpNum(bGpdto.getGpNum());
			System.out.println("BO_GP_NUM : " + ibGpdto.getGpNum());
			result *= ibdao.insertGroupBoWrite(ibGpdto);

			if (result <= 0) {
				if (ibGpdto.getBoType().equals("PICTURE"))
					new File(savePathPicture, bGpdto.getBoFile()).delete();
				else if (ibGpdto.getBoType().equals("VIDEO"))
					new File(savePathVideo, bGpdto.getBoFile()).delete();

			}
		}

		return result;
	}

	public String boardDelete(int bnum) {
		IlboBoardViewDto delBoard = ibdao.getBoardByBoNum(bnum);
		System.out.println(delBoard.getBoType());

		// 좋아요 제거
		ibdao.cancelBoardLikeAll(bnum);
		// 댓글 제거
		ibdao.deleteReplyAll(bnum);
		// 첨부파일 제거
		if (delBoard.getBoType().equals("MULTI")) {
			ArrayList<IlboBoardViewDto> delList = ibdao.getFilesByGroupNum(bnum);

			delList.forEach(b -> {
				boardDelete(b.getBoNum());
			});
		}

		if (delBoard.getBoType().equals("PICTURE")) {
			String filename = delBoard.getBoFile();
			File file = new File(savePathPicture, filename);
			file.delete();
		}

		if (delBoard.getBoType().equals("VIDEO")) {
			String filename = delBoard.getBoFile();
			File file = new File(savePathVideo, filename);
			file.delete();
		}

		int boardDeleteResult = ibdao.boardDelete(bnum); // 받아온 게시판 넘버 지우기
		String result = "fail";

		if (boardDeleteResult > 0) {
			result = "success";
		}

		return result;
	}

	public String getGroupByBoGroupNum(int boGroupNum) {

		ArrayList<IlboBoardViewDto> groups = ibdao.getFilesByGroupNum(boGroupNum);

		groups.forEach(board -> board.setReply(ibdao.getReply(board.getBoNum())));

		Gson gson = new Gson();
		String json = gson.toJson(groups);

		return json;
	}

//		공유기능 관련

	public String checkShareDuplicate(int boNum, int loginId) {
		// TODO Auto-generated method stub
		String boFile = boNum + "";
		IlboBoardDto ibDto = ibdao.checkShareDuplicate(boFile, loginId);
		if (ibDto == null) {
			return "valid";
		} else {
			return "invalid";
		}
	}

	public ModelAndView boardShare(IlboBoardDto bdto) {
		int getBoardNum = ibdao.selectBoardNum(); // 게시판 번호 생성
		System.out.println("getBoardNum : " + getBoardNum);
		bdto.setBoNum(getBoardNum); // dto에 담아준다
		bdto.setBoType("SHARE");

		int insertBoResult = ibdao.insertBoWrite(bdto); // 인서트
		if (insertBoResult > 0) {

			mav.setViewName("redirect:/main");
		}
		return mav;
	}

	public String getReply(int boardNum) {

		ArrayList<IlboBoardReplyDto> replyList = new ArrayList<IlboBoardReplyDto>();
		replyList = ibdao.getReply(boardNum);

		replyList.forEach((e) -> {
			if (e.getReContent() != null) {
				e.setReContent(e.getReContent().replaceAll("\r\n", "<br>"));
			}
		});

		Gson gson = new Gson();
		String replyListJson = gson.toJson(replyList);

		return replyListJson;

	}

	public String replyWrite(IlboBoardReplyDto rdto) throws IllegalStateException, IOException {

		// insert 결과값을 받을 변수 선언
		int insertResult = 0;

		// 댓글 그룹번호 생성
		// 게시글에 작성된 댓글그룹 중 최댓값
		int getMaxGroupNum = ibdao.getMaxGroupNum(rdto.getReBoNum());
		// 대댓글이 아니면 새 그룹 번호 저장
		if (rdto.getReGroup() == 0) {
			rdto.setReGroup(getMaxGroupNum + 1);
		}

		System.out.println(rdto);
		insertResult = ibdao.insertReply(rdto);

		if (insertResult <= 0) {
			System.out.println("insertReply 실패");
			return "fail";
		}
		return "success";
	}

	public String replyDelete(int boNum, int reGroup, int reSeq) {

		int deleteResult = 0;
		System.out.println("BONUM : " + boNum + " REGROUP : " + reGroup + " RESEQ : " + reSeq);
		if (reSeq != 1) {
			System.out.println("ibdao.replyDelete 실행");
			deleteResult = ibdao.replyDelete(boNum, reGroup, reSeq);
		} else {
			System.out.println("ibdao.replyDeleteByReGroup 실행");

			// 대댓글이 달려있는 원댓글일 경우 대댓글까지 삭제
			deleteResult = ibdao.replyDeleteByReGroup(boNum, reGroup);
		}

		if (deleteResult <= 0) {
			System.out.println("deleteReply 실패");
			return "fail";
		}
		return "success";
	}

	public ModelAndView searchTop(String q) {
		System.out.println("searchTop");
		mav.addObject("q", q);
		mav.setViewName("/Search/searchTop");
		return mav;
	}

	public ModelAndView searchPeople(String q) {
		System.out.println("searchPeople");
		mav.addObject("q", q);
		mav.setViewName("/Search/searchPeople");
		return mav;
	}

	public ModelAndView searchPosts(String q) {
		System.out.println("searchPosts");
		mav.addObject("q", q);
		mav.setViewName("/Search/searchPost");
		return mav;
	}

	public ModelAndView searchPhotos(String q) {
		System.out.println("searchPhotos");
		mav.addObject("q", q);
		mav.setViewName("/Search/searchPhotos");
		return mav;
	}

	public ModelAndView searchGroup(String q) {
		System.out.println("searchGroup");
		mav.addObject("q", q);
		mav.setViewName("/Search/searchGroup");
		return mav;
	}

	// 서치게시글에서 게시글만 찾는
	public String getSearchBoard(int num, String q) {

		int start = num + 1;
		int end = num + 10;
		System.out.println("q2 ==" + q);
		ArrayList<IlboBoardViewDto> list2 = ibdao.getSearchBoard(start, end, q);

		System.out.println("list == " + list2);

		list2.forEach((e) -> {
			if (e.getBoContent() != null) {
				e.setBoContentWithTag(e.getBoContent().replaceAll("\r\n", "<br>"));
			}
		});

		Gson gson = new Gson();
		String json = gson.toJson(list2);

		System.out.println(json);

		return json;
	}

	// 서치 그룹
	public String getSearchGroup(int num, String q) {
		int start = num + 1;
		int end = num + 10;
		ArrayList<IlboGroupDto> searchGroupList = ibdao.getSearchGroup(start, end, q);

		Gson gson = new Gson();
		String json = gson.toJson(searchGroupList);
		System.out.println(json);

		return json;
	}

	public ModelAndView hashTagSelect(String hashTag) {
		mav.addObject("q", hashTag);
		mav.setViewName("/Search/searchHashTag");
		return mav;
	}

	public String getSearchHashTag(int num, String q) {

		int start = num + 1;
		int end = num + 20;
		System.out.println("q2 ==" + q);
		ArrayList<IlboBoardViewDto> hashlist = ibdao.getSearchHashTag(start, end, q);

		System.out.println("list == " + hashlist);

		hashlist.forEach((e) -> {
			e.setBoContentWithTag(e.getBoContent().replaceAll("\r\n", "<br>"));
		});

		Gson gson = new Gson();
		String json = gson.toJson(hashlist);

		System.out.println(json);

		return json;
	}

	public int boardLike(String memId, int boNum) {
		String boardLikeCheck = ibdao.checkBoardLike(boNum, memId);

		if (boardLikeCheck == null) {
			ibdao.registBoardLike(boNum, memId);
		} else {
			ibdao.cancelBoardLike(boNum, memId);
		}

		int likeCount = ibdao.countBoardLike(boNum);

		return likeCount;
	}

	public String isLike(String memId, int boNum) {
		String isLikeCheck = ibdao.checkIsLike(memId, boNum);
		return isLikeCheck;
	}

	public int likeCount(int boNum) {
		int likeCount = ibdao.likeCount(boNum);
		return likeCount;
	}

	// 인기글 관련

	public String getShareRanking() {
		// TODO Auto-generated method stub
		System.out.println("share ranking");

		int maxBoNum = ibdao.selectBoardNum();
		ArrayList<IlboBoardViewDto> ibrDtoList = ibdao.getShareRanking();

		int rankSize = 6; // 한번에 보여줄 공유하기 랭킹
		int size = ibrDtoList.size();
		// 지정된 순위 이하 짤라냄
		for (int i = rankSize; i < size; i++) {
			ibrDtoList.remove(rankSize);
		}

		ibrDtoList.forEach(System.out::println);
		Gson gson = new Gson();
		String json = gson.toJson(ibrDtoList);
		return json;
	}

	public String getLikeRanking() {
		System.out.println("like ranking");
		ArrayList<IlboBoardViewDto> ibrDtoList = ibdao.getLikeRanking();

		int rankSize = 6; // 한번에 보여줄 좋아요 랭킹
		int size = ibrDtoList.size();
		// 지정된 순위 이하 짤라냄
		for (int i = rankSize; i < size; i++) {
			ibrDtoList.remove(rankSize);
		}

		Gson gson = new Gson();
		String json = gson.toJson(ibrDtoList);
		return json;
	}

	public String getReplyRanking() {
		System.out.println("reply ranking");

		int maxBoNum = ibdao.selectBoardNum();
		ArrayList<IlboBoardViewDto> ibrDtoList = ibdao.getReplyRanking();

		int rankSize = 6; // 한번에 보여줄 좋아요 랭킹
		int size = ibrDtoList.size();
		// 지정된 순위 이하 짤라냄
		for (int i = rankSize; i < size; i++) {
			ibrDtoList.remove(rankSize);
		}

		Gson gson = new Gson();
		String json = gson.toJson(ibrDtoList);
		return json;
	}

	public String uploadAttach(IlboBoardDto bdto) {
		MultipartFile file = bdto.getBoFileData();

		String uuid = UUID.randomUUID().toString().substring(0, 7);
		String boFile = uuid + "__" + file.getOriginalFilename();

		if (file.getContentType().startsWith("image"))
			try {
				file.transferTo(new File(savePathPicture, boFile));
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}

		if (file.getContentType().startsWith("video"))
			try {
				file.transferTo(new File(savePathVideo, boFile));
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}

		IlboBoardDto ibdto = new IlboBoardDto();
		ibdto.setBoGroupNum(bdto.getBoGroupNum());
		if (file.getContentType().startsWith("image"))
			ibdto.setBoType("PICTURE");

		if (file.getContentType().startsWith("video"))
			ibdto.setBoType("VIDEO");

		ibdto.setBoNum(0);
		ibdto.setBoContent("");
		ibdto.setBoWriter(bdto.getBoWriter());
		ibdto.setBoVisiblity(bdto.getBoVisiblity());
		ibdto.setBoFile(boFile);
		ibdto.setBoWritersName(bdto.getBoWritersName());

		bmm.insertLog("UPLOAD", ibdto);

		Gson gson = new Gson();
		String json = gson.toJson(ibdto);

		return json;
	}

	public void updateBoard(IlboBoardDto bdto) {
		System.out.println(bdto);

		ArrayList<IlboBoardModifyDto> logs = bmm.accept(bdto.getBoWriter());

		if (logs != null) {
			logs.forEach(log -> {
				if (log.getCommend().equals("DELETE")) {
					if (log.getBoard().getBoNum() == 0) {
						String filename = log.getBoard().getBoFile();
						String filetype = log.getBoard().getBoType();

						if (filetype.equals("PICTURE")) {
							File file = new File(savePathPicture, filename);
							file.delete();
						} else if (filetype.equals("VIDEO")) {
							File file = new File(savePathVideo, filename);
							file.delete();
						}
					} else {
						boardDelete(log.getBoard().getBoNum());
					}
				} else if (log.getCommend().equals("UPLOAD")) {
					log.getBoard().setBoNum(ibdao.selectBoardNum());
					ibdao.insertBoWrite(log.getBoard());
				}
			});
		}

		if (ibdao.getBoardGroupCountByBoNum(bdto.getBoNum()) == 0) {
			bdto.setBoType("NORMAL");
		} else if (ibdao.getBoardGroupCountByBoNum(bdto.getBoNum()) >= 1) {
			bdto.setBoType("MULTI");
		}

		bdto.setBoModDate(format.format(new Date()));
		ibdao.updateBoard(bdto);
	}

	public String modifyStandby(int memId) {
		bmm.standby(memId);
		return "success";
	}

	public String attachDelete(int boNum) {
		IlboBoardDto bdto = new IlboBoardDto();

		bdto.setBoNum(boNum);
		bdto.setBoWriter((Integer) session.getAttribute("loginId"));

		bmm.insertLog("DELETE", bdto);
		return "success";
	}

	public void modifyCancel(int loginId) {
		ArrayList<IlboBoardModifyDto> logs = bmm.cancel(loginId);

		logs.forEach(log -> {
			if (log.getCommend().equals("UPLOAD")) {
				String filename = log.getBoard().getBoFile();
				String filetype = log.getBoard().getBoType();

				if (filetype.equals("PICTURE")) {
					File file = new File(savePathPicture, filename);
					file.delete();
				} else if (filetype.equals("VIDEO")) {
					File file = new File(savePathVideo, filename);
					file.delete();
				}
			}
		});
	}

	public String aaa(int memId) {
		Gson gson = new Gson();
		String json = gson.toJson(bmm.aaa(memId));
		return json;
	}

	// 그룹기능 관련

	public ModelAndView groupCreate(IlboGroupDto gpDto) {
		gpDto.setGpNum(ibdao.getMaxGpNum());
		gpDto.setGpNumCode(ibdao.getMaxGpNum());
		gpDto.setGpImg("default.jpeg");

		System.out.println("-------------");
		System.out.println(gpDto);
		System.out.println("-------------");
		int groupCreateResult = ibdao.groupCreate(gpDto);
		if (groupCreateResult > 0) {

			mav.setViewName("redirect:/GroupPage");
		}
		return mav;
	}

	public String getGroup(int num) {
		int start = num + 1;
		int end = num + 10;

		ArrayList<IlboGroupDto> groupList = ibdao.getGroup(start, end);

		System.out.println("groupList == " + groupList);
		
		Gson gson = new Gson();
		String json = gson.toJson(groupList);

		System.out.println(json);

		return json;
	}

	public ModelAndView groupInfo(int gpNum) {
		
		int sessionId = (int) session.getAttribute("loginId");
		
		String groupDisclosure = ibdao.getDisclosure(gpNum);
		int myGroupMember = ibdao.myGroupMember(gpNum,sessionId);
		
		System.out.println("groupDisclosure ::||::"+groupDisclosure);
		System.out.println("myGroupMember ::||::"+myGroupMember);
		mav.addObject("myGroupMember",myGroupMember);
		mav.addObject("gpDisclosure",groupDisclosure);
		
		mav.addObject("gpNum", gpNum);
		mav.setViewName("/Group/GroupInfo");
		return mav;
	}

	public String getGroupInfo(int gpNum) {

		IlboGroupDto getGroupInfo = ibdao.getGroupInfo(gpNum);

		Gson gson = new Gson();
		String json = gson.toJson(getGroupInfo);
		System.out.println("getGroupInfo==" + json);
		return json;
	}

	public String updateGpImg(MultipartFile updateGpImg, String gpNum) throws IllegalStateException, IOException {
		int gpnum = Integer.parseInt(gpNum);
		String uuid = UUID.randomUUID().toString().substring(0, 7);
		String updateGpImgFile = uuid + "__" + updateGpImg.getOriginalFilename(); // 받은 파일

		System.out.println("updateGpImgFile : " + updateGpImgFile);

		if (!updateGpImg.getOriginalFilename().isEmpty()) {

			String oldFile = ibdao.getOldFile(gpnum);

			if (oldFile.equals("default.jpeg")) {
				System.out.println("default 이미지 파일 예외 처리");
			} else {

				System.out.println("oldFile : " + oldFile);
				File file = new File(savePathGroupImg, oldFile);
				file.delete();
			}
		}

		int updateResult = ibdao.updateGpImg(updateGpImgFile, gpnum);
		System.out.println("newFile : " + updateGpImgFile);
		System.out.println("updateResult : " + updateResult);
		if (updateResult > 0) {
			updateGpImg.transferTo(new File(savePathGroupImg, updateGpImgFile));

			return "success";
		} else {
			return "false";
		}

	}

	public String getGroupRequest(int memId, int gpNum) {
		System.out.println("ddddd");
		String selectRq = ibdao.getGroupRequest(memId, gpNum);
		System.out.println("찾아온 값 : " + selectRq);

		int insertRQ = 0, CancelRQ = 0;

		if (selectRq == null) {
			insertRQ = ibdao.insertRQ(memId, gpNum);

		} else {
			CancelRQ = ibdao.CancelRQ(memId, gpNum);
		}

		System.out.println("insertRQ : " + insertRQ + " CancelRQ : " + CancelRQ);
		selectRq = ibdao.getGroupRequest(memId, gpNum);

		System.out.println("찾아온 값 : " + selectRq);

		return selectRq;
	}

	public String selGroupRequest(int memId, int gpNum) {
		String selRq = ibdao.getGroupRequest(memId, gpNum);
		System.out.println("찾아온값:==" + selRq);
		return selRq;
	}

	// 그룹 멤버 가입 요청
	public String getRequestGroupMembers(int gpNum) {
		ArrayList<IlboGroupRequestDto> Greq = new ArrayList<IlboGroupRequestDto>();
		Greq = ibdao.getRequestGroupMembers(gpNum);

		Gson gson = new Gson();
		String json = gson.toJson(Greq);
		System.out.println("Grrrr == " + json);
		return json;
	}

	public String joinGpMem(int memId, int gpNum) {

		int maxGpNum = ibdao.getMaxGpNum();

		int deleteRqTable = ibdao.deleteRqTable(memId, gpNum);
		System.out.println("deleteRqTable ==" + deleteRqTable);
		int updateMemCount = ibdao.updateMemCount(gpNum);
		System.out.println("updateMemCount ==" + updateMemCount);
		int joinGroup = ibdao.joinGroup(memId, gpNum, maxGpNum);
		System.out.println("joinGroup ==" + joinGroup);

		return "OK";
	}

	public String registeredMember(int memId, int gpNum) {
		String groupMember = ibdao.discriminationGpMem(memId, gpNum);
		String groupManager = ibdao.discriminationGpMem2(memId, gpNum);
		String groupLeader = ibdao.discriminationGpMem3(memId, gpNum);
		
		String gpClass = null;
		if (groupMember != null) {
			gpClass = "member";
		}
		if (groupManager != null) {
			gpClass = "manager";
		}
		if (groupLeader != null) {
			gpClass = "king";
		}
		
		System.out.println("gpClass ::: " + gpClass);

		return gpClass;
	}

	public String cancelRqMem(int memId, int gpNum) {
		int deleteRqTable = ibdao.deleteRqTable(memId, gpNum);
		String ddd = null;
		System.out.println("deleteRqTable ==" + deleteRqTable);
		if (deleteRqTable > 0) {
			ddd = "OK";
		}

		return ddd;
	}

	public String getGpBoard(int gpNum) {

		int loginId = (int) session.getAttribute("loginId");
		int num = 0;

		int start = num + 1;
		int end = num + 10;

		ArrayList<IlboBoardViewDto> list = new ArrayList<IlboBoardViewDto>();
		list = ibdao.getGpBoard(start, end, loginId, gpNum);
		System.out.println(list);
		list.forEach((e) -> {
			if(e.getBoContent() != null) {
			e.setBoContentWithTag(e.getBoContent().replaceAll("\r\n", "<br>"));
			}
		});

		Gson gson = new Gson();
		String json = gson.toJson(list);

		return json;
	}
	
	public String getSearchPhotos(String q) {
		ArrayList<IlboBoardViewDto> photosList = ibdao.getSearchPhotos(q);
		Gson gson = new Gson();
		String json = gson.toJson(photosList);
		System.out.println("photosList :: "+json);
		return json;
	}
	
	public String delSelMember(int memId, int gpNum) {
		System.out.println("내보낼 그룹멤버 : "+memId +" 그룹번호 : "+ gpNum);
		
		IlboGroupMemberDto gpKing = ibdao.gpKing(memId,gpNum);
		Gson gson = new Gson();
		String json = gson.toJson(gpKing);
		System.out.println(json);
		return json;
	}

	public String gpSelMember(int memId, int gpNum) {
		IlboGroupMemberDto gpExile = ibdao.gpKing(memId,gpNum);
		Gson gson = new Gson();
		String json = gson.toJson(gpExile);
		System.out.println(json);
		return json;
	}

	public ModelAndView updateRank(int memId, int gpNum, String gpManager) {
			int updateRank =0;
		if(gpManager.equals("그룹 멤버")) {
			gpManager = "관리자";
			updateRank = ibdao.updateRank(memId,gpNum,gpManager);
		} else if (gpManager.equals("관리자")) {
			gpManager = "그룹 멤버";
			updateRank = ibdao.updateRank(memId,gpNum,gpManager);
		}
		mav.setViewName("redirect:/groupInfo?gpNum=" + gpNum);
		
		
		
		return mav;
	}

	public ModelAndView deleteGroup(int memId, int gpNum, String gpManager) {
		int boardGpList = 0;
		int deleteGroup = 0;
		int deleteGroupRq = 0;
		if(gpManager.equals("그룹장")) {
			boardGpList = ibdao.deleteBoList(gpNum); // 해당그룹의 글 삭제
			deleteGroupRq = ibdao.deleteGroupRq(gpNum); //그룹 가입 요청 데이터 삭제
			deleteGroup = ibdao.deleteGroupAll(gpNum); //그룹 삭제
			mav.setViewName("/Group/GroupMain");
		} else {
			deleteGroup = ibdao.deleteGroupMem(memId,gpNum); 	//멤버삭제
			ibdao.updateGroupMemCount(gpNum);
			mav.setViewName("redirect:/groupInfo?gpNum=" + gpNum); 
		}
		
		return mav;
	}

	public int getBoardCount(int memId) {
		
		int result = ibdao.getBoardCount(memId);
		
		return result;
	}

}
