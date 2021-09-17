package webSocket.chatting.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Component;

import webSocket.chatting.chatroom.Chatroom;
import webSocket.chatting.message.MessageModel;

@Component
public interface ChatDao {

	void joinMemberToChatroom(@Param("joiner")int joiner, @Param("channelId")String channelId);

	ArrayList<String> getChatroomMembersByRoomId(String channelId);

	void insertChat(MessageModel message);

	ArrayList<MessageModel> getChattingByRoomId(String roomId);

	int isInChatroom(String roomId, String loginId);

	Integer getMaxRoomNum();

	void makeChatroom(String roomId, String roomName);

    void insertMemberToChatroom(String receiver, String body);

	ArrayList<Chatroom> getChatrooms(String senderId);

	void outChatroom(String sender, String receiver);

	int numInChatroom(String receiver);

	void deleteChatroom(String receiver);

	void deleteChatting(String receiver);
}
