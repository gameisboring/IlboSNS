package com.IlboSns.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Component;

import com.IlboSns.dto.IlboFollowDto;
import com.IlboSns.dto.IlboMemberDto;

@Component
public interface IlboMemberDao {

	IlboMemberDto getMemberById(int id);

	void updateMember(IlboMemberDto idto);

	String getProfileById(int loginId);

	String checkDuplicate(String memEmail);

	int getMaxNum();

	int insertMemInfo(IlboMemberDto idto);

	IlboMemberDto memberLogin(@Param("memEmail")String memEmail, @Param("memPw")String memPw);

	IlboMemberDto selectEmail(String memEmail);

	int MemberNewPw(@Param("id_NewPw") String id_NewPw,@Param("memEmail") String memail);

	void updateProfile(@Param("fileName")String fileName, @Param("loginId")String loginId);
	
	int insertFollow(@Param("sendId")int sendId, @Param("receiveId")int receiveId);

	IlboFollowDto selectFollow(@Param("sendId")int sendId, @Param("receiveId")int receiveId);

	int deleteFollow(@Param("sendId")int sendId, @Param("receiveId")int receiveId);

	ArrayList<String> getFollowers(int memId);

	ArrayList<String> getFollows(int memId);

	ArrayList<IlboMemberDto> getSearchMember(String q);

	ArrayList<IlboMemberDto> getAllMemberList();

	ArrayList<String> getFollowsCount(int memId);

	ArrayList<IlboMemberDto> getFollowersAsMemberDto(int sendId);

	ArrayList<IlboMemberDto> getFollowsAsMemberDto(int sendId);

	ArrayList<IlboMemberDto> getChatroomMemberByRoomId(String roomId);

	ArrayList<IlboMemberDto> getGroupMember(int gpNum);

	ArrayList<IlboMemberDto> getSameAddr(@Param("memAddr") String memAddr, @Param("memId") int memId);

	ArrayList<IlboMemberDto> getSameCompany(@Param("memCompany") String memCompany,@Param("memId") int memId);

	ArrayList<IlboMemberDto> getSameSchool(@Param("memSchool")String memSchool,@Param("memId") int memId);

}
