package com.IlboSns.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;
import java.util.Random;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.IlboSns.dto.IlboBoardDto;
import com.IlboSns.dto.IlboBoardGpDto;
import com.IlboSns.dto.IlboBoardLikeDto;
import com.IlboSns.dto.IlboBoardReplyDto;
import com.IlboSns.dto.IlboGroupDto;
import com.IlboSns.dto.IlboMemberDto;
import com.IlboSns.service.IlboBoardService;
import com.IlboSns.service.IlboMemberService;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {

	/** 객체 정리 **/
	/** IlboMemberService => msvc **/
	/** IlboMemberDto => mdto **/
	/** **/
	@Autowired
	HttpSession session;

	@Autowired
	private JavaMailSender mailSender;

	@Autowired
	IlboMemberService msvc;

	ModelAndView mav = new ModelAndView();
	Gson gson = new Gson();
	PrintWriter out;

	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/")
	public String home(Locale locale, Model model) {
		if(session.getAttribute("loginId")!=null)
			return "redirect:/main";

		return "home";
	}

	@RequestMapping(value = "/home")
	public String home() {
		if(session.getAttribute("loginId")!=null)
			return "redirect:/main";
		return "home";
	}

	@RequestMapping(value = "/main")
	public String main() {

		return "main";
	}

	@RequestMapping(value = "/MemberId_Pw_Find")
	public String MemberId_Pw_Find() {
		return "Member/MemberId_Pw_Find";
	}

	@RequestMapping(value = "/register")
	public String register() {

		return "register";
	}

	@RequestMapping(value = "/bookmark")
	public String bookmark() {
		return "bookmark";
	}

	@RequestMapping(value = "/memberInformation")
	public String memberInformation() {

		return "Member/MemberInformation";
	}
	
	@RequestMapping(value = "/error")
	public String error() {
		return "error";
	}

	@RequestMapping(value = "/followList")
	public String followList() {
		return "Member/followList";
	}

//	회원가입 관련 (시작)
	@RequestMapping(value = "checkEmail", method = RequestMethod.GET)
	public @ResponseBody String checkEmail(String mem_email) {
		String result = msvc.checkEmail(mem_email);
		return result;
	}

	@RequestMapping(value = "processRegister")
	public ModelAndView processRegister(IlboMemberDto mdto, String verifiedPhonenum)
			throws IllegalStateException, IOException {
		mdto.setMemTel(verifiedPhonenum);
		mav = msvc.processRegister(mdto);
		return mav;
	}

//	회원가입 관련 (끝)

//	로그인 관련 (시작)

	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public ModelAndView memberLogin(String memEmail, String memPw) {
		System.out.println("로그인 요청");
		System.out.println("mem_email : " + memEmail + ", mem_pw : " + memPw);
		mav = msvc.memberLogin(memEmail, memPw);
		return mav;
	}

	@RequestMapping(value = "/logout")
	public String logout() {

		session.invalidate();

		return "home";
	}

//	로그인 관련 (끝)

//	멤버 정보보기 관련 (시작)
	
	@RequestMapping(value = "/memberInfoById")
	public ModelAndView memberInfoById(int memId) {
		
		return msvc.memberInfoById(memId);
	}
	
	@RequestMapping(value = "/updateMember", method = RequestMethod.POST)
	public @ResponseBody String updateMember(IlboMemberDto mdto) {

		return msvc.updateMember(mdto);
	}

	@RequestMapping(value = "/updateProfile", method = RequestMethod.POST)
	public @ResponseBody String updateProfile(@RequestParam("file") MultipartFile memFile) {
		System.out.println("controller-updateProfile : " + memFile.getOriginalFilename());

		return msvc.updateProfile(memFile);
	}

	@RequestMapping(value = "/myinfo", method = RequestMethod.GET, produces = "application/json; charset=utf8")
	public @ResponseBody String myinfo() {
		return msvc.getMyInfo();
	}
	
	@RequestMapping(value = "/memInfo", method = RequestMethod.GET, produces = "application/json; charset=utf8")
	public @ResponseBody String memInfo(int memId) {
		return msvc.getMemInfo(memId);
	}
	
	@RequestMapping(value = "/getBoardCount", method = RequestMethod.GET)
	public @ResponseBody int getBoardCount(int memId) {

		return bsvc.getBoardCount(memId);
	}
	

// 멤버 정보보기 관련 (끝)

// 비밀번호 찾기 관련 (시작)
	@RequestMapping(value = "/MemberFind", method = RequestMethod.POST)
	public ModelAndView MemberFind(String findEmail, String findName) {
		System.out.println("find_email : " + findEmail);
		System.out.println("find_name : " + findName);

		IlboMemberDto mdto = msvc.selectEmail(findEmail);
		System.out.println(mdto);

		// System.out.println("mDto.getMname() : " + mDto.getMname());
		if (mdto != null) {
			Random r = new Random();
			int num = r.nextInt(999999); // 랜덤난수설정
			System.out.println("num : " + num);
			if (mdto.getMemName().equals(findName)) {
				System.out.println("");
				session.setAttribute("email", mdto.getMemEmail());
				String setfrom = "assoo426@naver.com"; // gmail
				String tomail = findEmail; // 받는사람
				String title = "[일보SNS] 비밀번호변경 인증 이메일 입니다";
				String content = System.getProperty("line.separator") + "<h3>안녕하세요 " + mdto.getMemName() + " 님</h3>"
						+ System.getProperty("line.separator") + "일보SNS 비밀번호찾기(변경) 인증번호는 <strong>" + num
						+ "</strong> 입니다." + System.getProperty("line.separator"); //
				try {
					MimeMessage message = mailSender.createMimeMessage();
					MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "utf-8");

					messageHelper.setFrom(setfrom);
					messageHelper.setTo(tomail);
					messageHelper.setSubject(title);
					messageHelper.setText(content, true);

					mailSender.send(message);
				} catch (Exception e) {
					System.out.println(e.getMessage());
				}

				mav.addObject("num", num);
				mav.setViewName("Member/MemberEmailAuth");

			} else {
				System.out.println("이름실패");
				mav.setViewName("Member/MemberId_Pw_Find");
			}

		} else {
			System.out.println("이메일실패");
			mav.setViewName("Member/MemberId_Pw_Find");

		}
		return mav;
	}

	@RequestMapping("/MemberAuth")
	public ModelAndView MemberAuth(String num, String emailCheck) {
		System.out.println("인증번호 : " + num);
		System.out.println("사용자가 쓴 인증번호 : " + emailCheck);
		if (num.equals(emailCheck)) {
			mav.setViewName("/Member/MemberNewPw");
			return mav;
		} else {
			mav.setViewName("/Member/MemberEmailAuth");
			return mav;
		}
	}

	@RequestMapping("/MemberNewPw")
	public ModelAndView MemberNewPw(String Id_NewPw, String memail) {
		System.out.println("변경할 비밀번호 : " + Id_NewPw);
		System.out.println("넘어온 이메일 : " + memail);
		mav = msvc.MemberNewPw(Id_NewPw, memail);
		return mav;
	}
	// 비밀번호 찾기 관련 (끝)

	// 글목록 관련

	@Autowired
	IlboBoardService bsvc;

	@RequestMapping("/getBoard")
	public @ResponseBody String getBoard(int num) {
		return bsvc.getBoard(num);
	}

	@RequestMapping(value= "/getBoardByBoNum", produces="application/json; charset=utf-8")
	public @ResponseBody String getBoardByBoNum(int boNum) {
		return bsvc.getBoardByBoNum(boNum);
	}

	@RequestMapping("/getBoardById")
	public @ResponseBody String getBoardById(int num, int id) {
		return bsvc.getBoardById(num,id);
	}

	@RequestMapping(value = "/getGroupByBoGroupNum", produces = "application/json; charset=utf-8")
	public @ResponseBody String getGroupByBoGroupNum(int boGroupNum) {
		return bsvc.getGroupByBoGroupNum(boGroupNum);
	}

	// 글작성
	@RequestMapping(value = "/boardWrite", method = RequestMethod.POST)
	public ModelAndView boardWrite(IlboBoardDto bdto) throws IllegalStateException, IOException {
		System.out.println(bdto);
		mav = bsvc.boardWrite(bdto);

		return mav;
	}

	@DeleteMapping(value = "/board/{bNum}")
	public @ResponseBody String boardDelete(@PathVariable int bNum) {
		System.out.println("bnum : " + bNum);

		return bsvc.boardDelete(bNum);
	}

	// 공유 기능 관련
	// 공유 중복 확인
	@RequestMapping("/checkShareDuplicate")
	public @ResponseBody String checkShareDuplicate(int boNum, int loginId) {
		return bsvc.checkShareDuplicate(boNum, loginId);
	}

	// 공유하기
	@RequestMapping(value = "/boardShare", method = RequestMethod.POST)
	public ModelAndView boardShare(IlboBoardDto bdto) throws IllegalStateException, IOException {
		System.out.println(bdto);
		mav = bsvc.boardShare(bdto);

		return mav;
	}

	// 댓글 기능
	@RequestMapping(value = "/getReply")
	public @ResponseBody String getReply(int boardNum) {
		return bsvc.getReply(boardNum);
	}

	// 댓글작성
	@RequestMapping(value = "/replyWrite")
	public @ResponseBody String replyWrite(IlboBoardReplyDto rdto) throws IllegalStateException, IOException {
		String insertResult = bsvc.replyWrite(rdto);
		if(insertResult!=null) {
			System.out.println("댓글 입력 성공 : "+insertResult);
		}
		return insertResult;
	}
	
	// 댓글삭제
	@RequestMapping(value = "/replyDelete")
	public @ResponseBody String replyDelete(@RequestParam("reSeq") int reSeq, @RequestParam("reGroup") int reGroup, @RequestParam("boNum") int boNum) {
		return bsvc.replyDelete(boNum,reGroup,reSeq);
	}

	@RequestMapping(value = "/boardLike")
	public @ResponseBody int boardLike(@RequestParam("memId") String memId, @RequestParam("boNum") int boNum) {
		System.out.println("좋아요 / 취소 요청 : " + memId + " : " + boNum);
		int result = bsvc.boardLike(memId, boNum);
		return result;
	}

	@RequestMapping(value = "/isLike")
	public @ResponseBody String isLike(@RequestParam("memId") String memId, @RequestParam("boNum") int boNum) {
		String result = bsvc.isLike(memId, boNum);
		return result;
	}

	@RequestMapping(value = "/likeCount")
	public @ResponseBody int likeCount(int boNum) {
		int result = bsvc.likeCount(boNum);
		return result;
	}

	// SMS 인증
	@RequestMapping("/sendSMS")
	public @ResponseBody String sendSMS(String phoneNumber) {
		System.out.println("pn: " + phoneNumber);
		phoneNumber = "+" + phoneNumber;
		return msvc.sendSMS(phoneNumber);
	}

	// 팔로우 기능
	@RequestMapping(value = "/follow", method = RequestMethod.POST)
	public @ResponseBody String follow(int sendId, int receiveId) {

		return msvc.follow(sendId, receiveId);
	}

	// 팔로우 했는지 확인
	@RequestMapping(value = "/isFollow", method = RequestMethod.GET)
	public @ResponseBody boolean isFollow(int sendId, int receiveId) {

		return msvc.isFollow(sendId, receiveId);
	}

	// 팔로우 취소
	@RequestMapping(value = "/unfollow", method = RequestMethod.POST)
	public @ResponseBody String unfollow(int sendId, int receiveId) {

		return msvc.unfollow(sendId, receiveId);
	}

	// 팔로워들확인
	@RequestMapping(value = "/getFollowers", method = RequestMethod.GET)
	public @ResponseBody String getFollowers(int memId) {
		System.out.println("getFollowers : " + memId);

		return msvc.getFollowers(memId);
	}

	// 팔로우 한 사람들 확인
	@RequestMapping(value = "/getFollows", method = RequestMethod.GET)
	public @ResponseBody String getFollows(int memId) {
		System.out.println("getFollows : " + memId);

		return msvc.getFollows(memId);
	}

	// 팔로우 , 팔로워 숫자
		@RequestMapping(value = "/getFollowsCount")
		public @ResponseBody String getFollowsCount(int memId) {
			System.out.println("getFollowsCount : " + memId);

			return msvc.getFollowsCount(memId);
		}
	// 검색 관련 (시작)
	// 검색
	@RequestMapping(value = "/searchTop", method = RequestMethod.GET)
	public ModelAndView searchTop(String q) {
		System.out.println("검색어 : " + q);
		mav = bsvc.searchTop(q);

		return mav;
	}

	@RequestMapping(value = "/searchPeople", method = RequestMethod.GET)
	public ModelAndView searchPeople(String q) {
		System.out.println("검색어 : " + q);
		mav = bsvc.searchPeople(q);

		return mav;
	}

	@RequestMapping(value = "/searchPosts", method = RequestMethod.GET)
	public ModelAndView searchPosts(String q) {
		System.out.println("검색어 : " + q);
		mav = bsvc.searchPosts(q);

		return mav;
	}
	
	@RequestMapping(value = "/searchGroup", method = RequestMethod.GET)
	public ModelAndView searchGroup(String q)  {
		System.out.println("검색어 : "+q);
		mav = bsvc.searchGroup(q);

		return mav;
	}

	@RequestMapping("/getSearchBoard")
	public @ResponseBody String getSearchBoard(int num, String q) {
		System.out.println("q1 ==" + q);
		System.out.println("아이잭스 게시판 동작");
		return bsvc.getSearchBoard(num, q);
	}
	
	@RequestMapping(value="searchPhotos")
	public ModelAndView searchPhotos(String q) {
		System.out.println("검색어 : "+q);
		mav = bsvc.searchPhotos(q);
		return mav;
	}
	
	@RequestMapping("/getSearchPhotos")
	public @ResponseBody String getSearchPhotos(String q) {
		
		return bsvc.getSearchPhotos(q);
	}

	@RequestMapping("/getSearchMember")
	public @ResponseBody String getSearchMember(String q) {
		System.out.println("q : " + q);
		System.out.println("아이잭스 멤버 동작");
		return msvc.getSearchMember(q);
	}

	// 해쉬태그
	@RequestMapping(value = "/hashTagSelect", method = RequestMethod.GET)
	public ModelAndView hashTagSelect(String hashTag) {
		System.out.println("해시태그 : " + hashTag);
		mav = bsvc.hashTagSelect(hashTag);

		return mav;
	}

	@RequestMapping(value = "/getSearchHashTag", method = RequestMethod.GET)
	public @ResponseBody String getSearchHashTag(int num, String q) {
		return bsvc.getSearchHashTag(num, q);
	}
	// 검색 관련 (끝)

	// 인기글 관련
	@RequestMapping(value = "/getShareRanking", method = RequestMethod.GET)
	public @ResponseBody String getShareRanking() {
		return bsvc.getShareRanking();
	}

	@RequestMapping(value = "/getLikeRanking", method = RequestMethod.GET)
	public @ResponseBody String getLikeRanking() {
		return bsvc.getLikeRanking();
	}

	@RequestMapping(value = "/getReplyRanking", method = RequestMethod.GET)
	public @ResponseBody String getReplyRanking() {
		return bsvc.getReplyRanking();
	}

	// 멤버 목록 관련
	@RequestMapping(value = "/getMemberList")
	public ModelAndView getMemberList() {

		return msvc.getAllMemberList();
	}

	// 게시글 수정관련
		@PostMapping(value = "/uploadAttachFile", produces = "application/json; charset=utf-8")
		public @ResponseBody String uploadAttachFile(@ModelAttribute IlboBoardDto bdto) {

			System.out.println(bdto);

			return bsvc.uploadAttach(bdto);
		}

		@PostMapping(value = "/boardModify")
		public String boardModify(IlboBoardDto bdto) {
			System.out.println(bdto);
			bsvc.updateBoard(bdto);

			return "redirect:/main";
		}
		
		@GetMapping("/modifyStandby/{memId}")
		public @ResponseBody String modifyStanby(@PathVariable int memId) {
			return bsvc.modifyStandby(memId);
		}
		
		@DeleteMapping("/boardModify/{boNum}")
		public @ResponseBody String attachDelete(@PathVariable int boNum) {
			return bsvc.attachDelete(boNum);
		}
		
		@GetMapping("modifyCancel/{loginId}")
		public void modifyCancel(@PathVariable int loginId) {
			bsvc.modifyCancel(loginId);
		}
		
		@GetMapping(value= "/chatroomMember/{roomId}", produces="application/json; charset=utf-8")
		public @ResponseBody String chatroomMember(@PathVariable String roomId) {
			return msvc.getChatroomMember(roomId);
		}
		
		// 팔로우또는, 팔로워 목록
		@RequestMapping(value = "/getFollowsWithoutJoiner", method = RequestMethod.GET, produces = "application/json; charset=utf-8")
		public @ResponseBody String getFollowsWithoutJoiner(int senderId, String roomId) {

			return msvc.getFollowsWithoutJoiner(senderId, roomId);
		}
		
		@GetMapping(value = "/memberRecommend", produces="application/json; charset=utf-8")
		public @ResponseBody String memberRecommend() {
			
			return msvc.getRecommendMemberList();
		}

	// web.xml을 통해 에러페이지가 매핑됨
	@RequestMapping(value = "/errors", method = RequestMethod.GET)
	public ModelAndView renderErrorPage(HttpServletRequest httpRequest) {

		ModelAndView errorPage = new ModelAndView("error");
		String errorMsg = "";
		int httpErrorCode = (Integer) httpRequest.getAttribute("javax.servlet.error.status_code");

		switch (httpErrorCode) {
		case 400: {
			errorMsg = "400<br>Bad<br>Request";
			break;
		}
		case 401: {
			errorMsg = "401<br>Unauthorized";
			break;
		}
		case 404: {
			errorMsg = "404<br>Page<br>not found";
			break;
		}
		case 500: {
			errorMsg = "500<br>Internal Server<br>Error";
			break;
		}
		}
		errorPage.addObject("errorMsg", errorMsg);
		return errorPage;
	}
	@GetMapping("/mod/{memId}")
	public @ResponseBody String aaa(@PathVariable int memId) {
		return bsvc.aaa(memId);
	}
	
	//그룹 관련
			@RequestMapping(value = "/GroupPage")
			public String GroupPage() {
				
				return "/Group/GroupMain";
			}
			@RequestMapping(value = "/groupCreate", method = RequestMethod.POST)
			public ModelAndView groupCreate(IlboGroupDto gpDto)  {
				
				mav = bsvc.groupCreate(gpDto);

				return mav;
			}
			@RequestMapping(value="/getGroup",method=RequestMethod.GET)
			public @ResponseBody String getGroup(int num) {
				return bsvc.getGroup(num);
			}
			@RequestMapping("/getSearchGroup")
			public @ResponseBody String getSearchGroup(int num,String q) {
				System.out.println("q ==" + q);
				System.out.println("num == " + num);
				return bsvc.getSearchGroup(num,q);
			}
			@RequestMapping(value="/groupInfo",method = RequestMethod.GET)
			public ModelAndView groupInfo(int gpNum) {
				System.out.println("gpNumInfo =="+gpNum);
				mav = bsvc.groupInfo(gpNum);
				return mav;
			}
			
			@RequestMapping("/getGroupInfo")
			public @ResponseBody String getGroupInfo(int gpNum) {
				
				System.out.println("gpNum == " + gpNum);
				return bsvc.getGroupInfo(gpNum);
				
			}
			
			@RequestMapping("/updateGpImg")
			public @ResponseBody String updateGpImg(@RequestParam("file")MultipartFile updateGpImg,@RequestParam("gpnum")String gpNum) throws IllegalStateException, IOException {
				System.out.println("updateGpImg == " + updateGpImg.getOriginalFilename());
				System.out.println("gpNum == "+gpNum);
				
				return bsvc.updateGpImg(updateGpImg,gpNum);
				
			}
			@RequestMapping("/getGroupMember")
			public @ResponseBody String getGroupMember(int gpNum)  {
				System.out.println("getGroupMember getNum : "+gpNum);
				
				return msvc.getGroupMember(gpNum);
				
			}
			
			@RequestMapping("/getGroupRequest")
			public @ResponseBody String getGroupRequest(int memId,int gpNum)  {
				System.out.println("memId == "+memId +"  gpNum == "+gpNum);
				String ddd = bsvc.getGroupRequest(memId,gpNum);
				return ddd;
			}	
			
			@RequestMapping("/selGroupRequest")
			public @ResponseBody String selGroupRequest(int memId,int gpNum)  {
				System.out.println("memId == "+memId +"  gpNum == "+gpNum);
				String ddd = bsvc.selGroupRequest(memId,gpNum);
				return ddd;
			}	
			
			@RequestMapping("/getRequestGroupMembers")
			public @ResponseBody String getRequestGroupMembers(int gpNum)  {
				System.out.println("요청멤버 숫자 : "+ gpNum);
				return bsvc.getRequestGroupMembers(gpNum);
			}	
			@RequestMapping("/joinGpMem")
			public @ResponseBody String joinGpMem(int memId,int gpNum)  {
				System.out.println("수락한 멤버 == "+memId +"  수락한 그룹 번호 == "+gpNum);
				return bsvc.joinGpMem(memId,gpNum);
			}	
			@RequestMapping(value="/registeredMember",method=RequestMethod.POST)
			public @ResponseBody String registeredMember(int memId,int gpNum)  {
				System.out.println("들어온 멤버번호 == "+memId +"  들어온 그룹번호 == "+gpNum);
				return bsvc.registeredMember(memId,gpNum);
			}
			
			@RequestMapping(value="/cancelRqMem",method=RequestMethod.POST)
			public @ResponseBody String cancelRqMem(int memId,int gpNum)  {
				System.out.println("거절할 멤버번호 == "+memId +"  거절할 그룹번호 == "+gpNum);
				return bsvc.cancelRqMem(memId,gpNum);
			}
			// 그룹 글작성
			@RequestMapping(value = "/groupBoardWrite", method = RequestMethod.POST)
			public ModelAndView groupBoardWrite(IlboBoardGpDto bGpdto) throws IllegalStateException, IOException {
				System.out.println("gpNum ::: "+bGpdto.getGpNum());
				mav = bsvc.groupBoardWrite(bGpdto);

				return mav;
			}
			
			@RequestMapping("/getGpBoard")
			public @ResponseBody String getGpBoard(int gpNum) {
				return bsvc.getGpBoard(gpNum);
			}
			
			@RequestMapping("/delSelMember")
			public @ResponseBody String delSelMember(int memId,int gpNum) {
				return bsvc.delSelMember(memId,gpNum);
			}
			@RequestMapping("/gpSelMember")
			public @ResponseBody String exileSelMember(int memId,int gpNum) {
				return bsvc.gpSelMember(memId,gpNum);
			}
			
			@RequestMapping(value = "/updateRank", method = RequestMethod.POST)
			public ModelAndView updateRank(int memId,int gpNum,String gpManager) throws IllegalStateException, IOException {
				System.out.println("memId ::: "+memId);
				System.out.println("gpNum ::: "+gpNum);
				System.out.println("gpManager ::: "+gpManager);
				
				mav = bsvc.updateRank(memId,gpNum,gpManager);

				return mav;
			}
			@RequestMapping(value = "/deleteGroup", method = RequestMethod.POST)
			public ModelAndView deleteGroup(int memId,int gpNum,String gpManager) throws IllegalStateException, IOException {
				System.out.println("memId ::: "+memId);
				System.out.println("gpNum ::: "+gpNum);
				System.out.println("gpManager ::: "+gpManager);
				
				mav = bsvc.deleteGroup(memId,gpNum,gpManager);

				return mav;
			}

}
