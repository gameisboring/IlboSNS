package com.IlboSns.service;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.Random;
import java.util.Set;
import java.util.UUID;
import java.util.regex.Pattern;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.IlboSns.dao.IlboMemberDao;
import com.IlboSns.dto.IlboFollowDto;
import com.IlboSns.dto.IlboMemberDto;
import com.IlboSns.dto.IlboMemberRecommendationDto;
import com.google.gson.Gson;
import com.twilio.Twilio;
import com.twilio.rest.api.v2010.account.Message;
import com.twilio.type.PhoneNumber;

@Service
public class IlboMemberService {
	
	@Autowired
	IlboMemberDao idao;
	
	ModelAndView mav = new ModelAndView();
	
	@Autowired
	HttpSession session;
	
	String savePath = "D:\\spring\\IlboSns01\\src\\main\\webapp\\resources\\assets\\img\\profile";
	
	public static final String ACCOUNT_SID = "AC4735f7b15703814548e040a3984d4044";
	public static final String AUTH_TOKEN = "eb2f9b429b2a056d1d180c97653c61c4";
	
// 회원 가입 관련 (시작)
	public String checkEmail(String memEmail) {
		// TODO Auto-generated method stub
		int characterLimit = 20;
		String result = null;

		if (memEmail.length() <= characterLimit) {
			boolean isValid = isValid(memEmail);
			if (isValid) {

				memEmail = idao.checkDuplicate(memEmail);
				if (memEmail == null) {
					result = "valid";
				} else {
					result = "hasDuplicate";
				}

			} else {

				result = "invalid";
			}
		} else {

			result = "overlimit";
		}

		System.out.println(result);
		return result;
	}
	
	 public static boolean isValid(String email)
	    {
	        String emailRegex = "^[a-zA-Z0-9_+&*-]+(?:\\."+
	                            "[a-zA-Z0-9_+&*-]+)*@" +
	                            "(?:[a-zA-Z0-9-]+\\.)+[a-z" +
	                            "A-Z]{2,7}$";
	                              
	        Pattern pat = Pattern.compile(emailRegex);
	        if (email == null)
	            return false;
	        return pat.matcher(email).matches();
	    }

	public ModelAndView processRegister(IlboMemberDto idto) throws IllegalStateException, IOException {
		// TODO Auto-generated method stub
		MultipartFile memProfileFile = idto.getMemProfileFile();
		
		UUID uuid = UUID.randomUUID();
		
		String memProfile = "default.jpg";
		
		if(!memProfileFile.isEmpty()) {
			memProfile = uuid + "__" + memProfileFile.getOriginalFilename();
			memProfileFile.transferTo(new File(savePath, memProfile));
		}
		
		idto.setMemProfile(memProfile);
		idto.setMemId(idao.getMaxNum());
		
		System.out.println(idto);
		
		int insResult = idao.insertMemInfo(idto);
		
		if(insResult > 0) {
			mav.addObject("result", "회원 가입에 성공했습니다<br> 로그인해주세요");
			mav.addObject("resultColor", "green");
			
		} else {
			mav.addObject("result", "회원 가입에 실패했습니다<br> 다시 시도해주세요");
			mav.addObject("resultColor", "red");
		}
		
		mav.setViewName("redirect:/");
		
		return mav;
	}

//	회원 가입 관련(끝)
	
//	로그인 기능

	public ModelAndView memberLogin(String memEmail, String memPw) {
		ModelAndView mav = new ModelAndView();
		IlboMemberDto loginMember = idao.memberLogin(memEmail, memPw);
		if (loginMember != null) {
			mav.setViewName("redirect:/main");
			session.setAttribute("loginId", loginMember.getMemId());
			session.setAttribute("loginProfile", loginMember.getMemProfile());
			session.setAttribute("loginName", loginMember.getMemName());
		}else {
			mav.addObject("result", "아이디 또는 비밀번호가 일치하지 않습니다.");
			mav.addObject("resultColor", "red");
			mav.setViewName("home");
		}
		return mav;
	}
	
//	회원 정보 보기 관련(시작)
	public String getMyInfo() {
		String result;
		
		Gson gson = new Gson();
		
		int id = (int)session.getAttribute("loginId");
		
		System.out.println(id);
		
		IlboMemberDto memList = idao.getMemberById(id);
		
		System.out.println(memList);
		
		if(memList == null){
			result = gson.toJson(new String[] {"error" , ""});
		} else {
			result = gson.toJson(memList);
			System.out.println(result);
		}
		
		return result;
	}
	
	public String getMemInfo(int memId) {
		String result;
		
		Gson gson = new Gson();
		
		int id = memId;
		
		System.out.println(id);
		
		IlboMemberDto memList = idao.getMemberById(id);
		
		System.out.println(memList);
		
		if(memList == null){
			result = gson.toJson(new String[] {"error" , ""});
		} else {
			result = gson.toJson(memList);
			System.out.println(result);
		}
		
		return result;
	}

	public String updateMember(IlboMemberDto idto) {
		idao.updateMember(idto);
		
		return "success";
	}

	public String updateProfile(MultipartFile memFile) {
		int loginId = (int) session.getAttribute("loginId");
		String oldProfile = idao.getProfileById(loginId);
		
		UUID uuid = UUID.randomUUID();
		String fileName = uuid + "__" + memFile.getOriginalFilename();
		
		if(!memFile.isEmpty()) {
			try {
				memFile.transferTo(new File(savePath,fileName));
				
			} catch (IllegalStateException | IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} else {
			return "fail-NoFile";
		}

		try {
			idao.updateProfile(fileName,""+loginId);
			System.out.println("업로드 성공");
			if(oldProfile != null) {
				File file = new File(savePath,oldProfile);
				file.delete();
			}
			session.setAttribute("loginProfile", fileName);
			return "success";
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		File file = new File(savePath, fileName);
		file.delete();
		
		System.out.println("업로드 실패");
		return "fail-UpLoadFail";
	}
//	회원 정보 보기 관련(끝)

	public IlboMemberDto selectEmail(String findEmail) {
		IlboMemberDto dto = idao.selectEmail(findEmail);
		return dto;
	}

	public ModelAndView MemberNewPw(String id_NewPw, String memail) {
		int updateResult = idao.MemberNewPw(id_NewPw,memail);
		if(updateResult > 0) {
			mav.addObject("newPw","비밀번호가 변경되었습니다.");
			mav.addObject("result", "비밀번호가 성공적으로 변경되었습니다.<br> 변경된 비밀번호로 로그인해주세요");
			mav.addObject("resultColor", "green");
			mav.setViewName("home");
		} else {
			mav.addObject("pwfalse","비밀번호변경이 실패하였습니다.");
			mav.setViewName("/Member/MemberNewPw");
		}
		return mav;
	}
	
	public String sendSMS(String phoneNumber) {
		// TODO Auto-generated method stub
		Twilio.init(ACCOUNT_SID, AUTH_TOKEN);
		
		Random r = new Random();
		int num = r.nextInt(999999); // 랜덤난수설정
		
		
		String strNum = num + "";
		
		if(strNum.length() < 6) {
			String zeroes = "";		
			for(int i = 0; i < 6 - strNum.length(); i++) {
				zeroes += "0";
			}
			strNum = zeroes + strNum;
		}
		
		try {
			Message message = Message.creator(new PhoneNumber(phoneNumber),
			        new PhoneNumber("+16234697293"), 
			        "인증번호는 " + strNum + "입니다").create();
			System.out.println(message.getSid());
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	    
		System.out.println("strNum : " + strNum);
		return strNum;
	}
	
	//팔로우및 친구추가
		public String follow(int sendId, int receiveId) {
			
			if(sendId == receiveId) {
				return "fail";
			}
			
			if(isFollow(sendId, receiveId)) {
				return "fail";
			}
			
			int insResult = idao.insertFollow(sendId, receiveId);
			
			if(insResult > 0) {
				return "success";
			}
			
			return "fail";
		}

		public boolean isFollow(int sendId, int receiveId) {
			
			if(sendId == receiveId) {
				return false;
			}
			
			IlboFollowDto ifdto = idao.selectFollow(sendId, receiveId);
			
			if(ifdto != null) {
				return true;
			}
			
			return false;
		}

		public boolean isfriends(int sendId, int receiveId) {
			
			if(sendId == receiveId) {
				return false;
			}
			
			if(isFollow(sendId, receiveId)) {
				if(isFollow(receiveId, sendId))
					return true;
			}
			
			return false;
		}

		public String unfollow(int sendId, int receiveId) {
			if(sendId == receiveId) {
				return "fail";
			}
			
			int insResult = idao.deleteFollow(sendId, receiveId);
			
			if(insResult > 0) {
				return "success";
			}
			
			return "fail";
		}

		public String getFollowers(int memId) {
			
			ArrayList<String> followers = idao.getFollowers(memId);
			
			Gson gson = new Gson();
			String json = gson.toJson(followers);
			
			System.out.println(json);
			
			return json;
		}

		public String getFollows(int memId) {
			ArrayList<String> follows = idao.getFollows(memId);
			
			Gson gson = new Gson();
			String json = gson.toJson(follows);
			
			System.out.println(json);

			return json;
		}
		
		public String getSearchMember(String q) {
			System.out.println("q2 : "+q);
			ArrayList<IlboMemberDto> mList = idao.getSearchMember(q);
			
			System.out.println("mList == "+mList);
			
			Gson gson = new Gson();
			
			String json = gson.toJson(mList);
				
			System.out.println(json);
			
			return json;
		}
		

		public ModelAndView getAllMemberList() {
			
			ModelAndView mav = new ModelAndView();
			ArrayList<IlboMemberDto> membrList = idao.getAllMemberList();
			
			if(!membrList.isEmpty()) {
				mav.addObject("memberList", membrList);
				mav.setViewName("people");
			}
			
			System.out.println(mav);
			return mav;
		}

		public String getFollowsCount(int memId) {
			ArrayList<String> countList = idao.getFollowsCount(memId);
			System.out.println("12312312312 : "+countList);
			Gson gson = new Gson();
			
			String json = gson.toJson(countList);
				
			System.out.println(json);
			
			return json;
		}
		
		public String getFollowsWithoutJoiner(int sendId, String roomId) {
			ArrayList<IlboMemberDto> followersList = idao.getFollowersAsMemberDto(sendId);
			ArrayList<IlboMemberDto> followsList = idao.getFollowsAsMemberDto(sendId);
			ArrayList<IlboMemberDto> joinerList = idao.getChatroomMemberByRoomId(roomId);
			
			Set<IlboMemberDto> memberSet = new HashSet<IlboMemberDto>();
			
			memberSet.addAll(followersList);
			memberSet.addAll(followsList);
			memberSet.removeAll(joinerList);
			
			Gson gson = new Gson();
			String json = gson.toJson(memberSet);
			
			return json;
		}

		public String getChatroomMember(String roomId) {
			ArrayList<IlboMemberDto> memList = idao.getChatroomMemberByRoomId(roomId);
			
			Gson gson = new Gson();
			String json = gson.toJson(memList);
			
			
			return json;
		}
		
		public String getGroupMember(int gpNum) {
			ArrayList<IlboMemberDto> GpMemList = idao.getGroupMember(gpNum);
			
			Gson gson = new Gson();
			String json = gson.toJson(GpMemList);
			
			System.out.println("mem@@@"+json);
			return json;
		}
	
		public String getRecommendMemberList() {
			int memId = (int)session.getAttribute("loginId");
			IlboMemberDto mdto = idao.getMemberById(memId);
			
			IlboMemberRecommendationDto memberRecommend = new IlboMemberRecommendationDto();
			ArrayList<IlboMemberDto> follows = idao.getFollowsAsMemberDto(memId);
			
			/*팔로우 관련*/
			ArrayList<IlboMemberDto> followers = idao.getFollowersAsMemberDto(memId);
			followers.removeAll(follows);
			memberRecommend.setRelationFollow(followers);
			
			/*학교 관련*/
			if(mdto.getMemSchool() != null) {
				ArrayList<IlboMemberDto> sameSchools = idao.getSameSchool(mdto.getMemSchool(), memId);
				sameSchools.removeAll(follows);
				memberRecommend.setRelationSchool(sameSchools);
			}
			
			/*회사 관련*/
			if(mdto.getMemCompany() != null) {
				ArrayList<IlboMemberDto> sameCompanys = idao.getSameCompany(mdto.getMemCompany(), memId);
				sameCompanys.removeAll(follows);
				memberRecommend.setRelationCompany(sameCompanys);
			}
		
			/*거주지 관련*/
			if(mdto.getMemAddr() != null) {
				ArrayList<IlboMemberDto> sameAddrs = idao.getSameAddr(mdto.getMemAddr(), memId);
				sameAddrs.removeAll(follows);
				memberRecommend.setRelationAddr(sameAddrs);
			}
			
			Gson gson = new Gson();
			String json = gson.toJson(memberRecommend);
			
			return json;
		}

		public ModelAndView memberInfoById(int memId) {
			
			ModelAndView mav = new ModelAndView();
			
			IlboMemberDto mdto = idao.getMemberById(memId);
			if(mdto!=null) {
				mav.addObject("mdto", mdto);
				mav.setViewName("memberInformation");
			}
			return mav;
		}

		
}
