package com.IlboSns.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.IlboSns.dto.IlboBoardDto;
import com.IlboSns.dto.IlboBoardGpDto;
import com.IlboSns.dto.IlboBoardLikeDto;
import com.IlboSns.dto.IlboBoardReplyDto;
import com.IlboSns.dto.IlboBoardViewDto;
import com.IlboSns.dto.IlboGroupDto;
import com.IlboSns.dto.IlboGroupMemberDto;
import com.IlboSns.dto.IlboGroupRequestDto;
import com.IlboSns.dto.IlboRankingDto;

public interface IlboBoardDao {

	ArrayList<IlboBoardViewDto> getBoard(@Param("start")int start, @Param("end")int end, @Param("loginId")int loginId);

	int selectBoardNum();

	int insertBoWrite(IlboBoardDto bdto);

	int boardDelete(int bnum);

	String selectbFile(int bnum);

	IlboBoardViewDto getBoardByBoNum(int boNum);

	ArrayList<IlboBoardViewDto> getFilesByGroupNum(int boGroupNum);

	IlboBoardDto checkShareDuplicate(@Param("boFile")String boFile, @Param("loginId")int loginId);

	ArrayList<IlboBoardReplyDto> getReply(int boardNum);

	int getMaxGroupNum(int boNum);

	int insertReply(IlboBoardReplyDto rdto);

	ArrayList<IlboBoardViewDto> getSearchHashTag(@Param("start")int start, @Param("end")int end,@Param("q") String q);

	ArrayList<IlboBoardViewDto> getSearchBoard(@Param("start")int start, @Param("end")int end,@Param("q") String q);

	@Select("SELECT LI_ID FROM ILBO_LIKE WHERE LI_BO_NUM = #{boNum} and LI_ID = #{memId}")
	String checkBoardLike(@Param("boNum") int boNum, @Param("memId") String memId);
	
	@Insert("INSERT INTO ILBO_LIKE(LI_BO_NUM, LI_ID) VALUES(#{boNum}, #{memId})") 
	void registBoardLike(@Param("boNum") int boNum, @Param("memId") String memId);
	
	@Delete("DELETE FROM ILBO_LIKE WHERE LI_BO_NUM = #{boNum} AND LI_ID = #{memId}")
	void cancelBoardLike(@Param("boNum") int boNum, @Param("memId") String memId);
	
	@Delete("DELETE FROM ILBO_LIKE WHERE LI_BO_NUM = #{boNum}")
	void cancelBoardLikeAll(@Param("boNum") int boNum);
	
	@Delete("DELETE FROM ILBO_REPLY WHERE RE_BONUM = #{boNum}")
	void deleteReplyAll(int boNum);
	
	@Select("SELECT COUNT(*) FROM ILBO_LIKE WHERE LI_BO_NUM = #{boNum}")
	int countBoardLike(int boNum);

	@Select("SELECT LI_ID FROM ILBO_LIKE WHERE LI_ID = #{memId} AND LI_BO_NUM = #{boNum}")
	String checkIsLike(@Param("memId") String memId,@Param("boNum") int boNum);

	@Select("SELECT COUNT(*) FROM ILBO_LIKE WHERE LI_BO_NUM = #{boNum}")
	int likeCount(int boNum);

	IlboRankingDto getRanking(int i);

	int getNumOfReplies(int boNum);

	int getNumOfShare(String boFile);

	int getNumOfLikes(int boNum);

	ArrayList<IlboBoardViewDto> getLikeRanking();

	ArrayList<IlboBoardViewDto> getReplyRanking();
	
	ArrayList<IlboBoardViewDto> getShareRanking();

	ArrayList<IlboBoardViewDto> getBoardById(@Param("start") int start,@Param("end") int end,@Param("loginId") int loginId);
	
	int groupCreate(IlboGroupDto gpDto);

	int getMaxGpNum();

	ArrayList<IlboGroupDto> getGroup(@Param("start")int start, @Param("end")int end);

	void updateBoard(IlboBoardDto bdto);

	int getBoardGroupCountByBoNum(int boNum);

	int replyDelete (@Param("boNum") int boNum, @Param("reGroup") int reGroup, @Param("reSeq") int reSeq);

	int replyDeleteByReGroup(@Param("boNum") int boNum, @Param("reGroup") int reGroup);
	
	ArrayList<IlboGroupDto> getSearchGroup(@Param("start")int start, @Param("end")int end, @Param("q")String q);

	IlboGroupDto getGroupInfo(int gpNum);

	int updateGpImg(@Param("updateGpImgFile")String updateGpImgFile,@Param("gpnum")int gpnum);

	String getOldFile(int gpnum);

	int groupRequest(int memId);

	String getGroupRequest(@Param("memId")int memId, @Param("gpNum")int gpNum);
	
	int insertRQ(@Param("memId")int memId, @Param("gpNum")int gpNum);

	int CancelRQ(@Param("memId")int memId, @Param("gpNum")int gpNum);

	ArrayList<IlboGroupRequestDto> getRequestGroupMembers(int gpNum);

	String discriminationGpMem(@Param("memId")int memId, @Param("gpNum")int gpNum);

	String discriminationGpMem2(@Param("memId")int memId, @Param("gpNum")int gpNum);
	
	int deleteRqTable(@Param("memId")int memId, @Param("gpNum")int gpNum);

	int updateMemCount(int gpNum);

	int joinGroup(@Param("memId")int memId, @Param("gpNum")int gpNum,@Param("maxGpNum")int maxGpNum);

	int insertGroupBoWrite(IlboBoardGpDto bGpdto);

	ArrayList<IlboBoardViewDto> getGpBoard(@Param("start")int start,@Param("end")int end,@Param("loginId")int loginId,@Param("gpNum")int gpNum);

	int selectPostTagNum();

	int insertBoardTag(@Param("bNum")int bNum, @Param("selectPostTagNum") int selectPostTagNum);

	int insertTag(@Param("selectPostTagNum") int selectPostTagNum,@Param("hashTag") String hashTag);

	String discriminationGpMem3(@Param("memId") int memId,@Param("gpNum") int gpNum);
	
	IlboGroupMemberDto gpKing(@Param("memId")int memId, @Param("gpNum")int gpNum);

	int updateRank(@Param("memId")int memId, @Param("gpNum")int gpNum,@Param("gpManager")String gpManager);

	int deleteBoList(int gpNum);

	int deleteGroupAll(int gpNum);

	int deleteGroupMem(@Param("memId")int memId, @Param("gpNum")int gpNum);

	int deleteGroupRq(int gpNum);
	
	void updateGroupMemCount(int gpNum);

	int getBoardCount(int memId);
	
	String getDisclosure(int gpNum);

	int myGroupMember(@Param("gpNum")int gpNum,@Param("sessionId")int sessionId);

	ArrayList<IlboBoardViewDto> getSearchPhotos(String q);
}
