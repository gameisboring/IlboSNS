package webSocket.chatting.chatroom;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import webSocket.chatting.dao.ChatDao;
import webSocket.chatting.message.MessageModel;

import java.util.ArrayList;

@Component
public class ChatroomManager {

    ChatDao chatDao;    //DAO Interface
    Integer maxRoomNum; //현재 채팅방의 최대숫자를 저장

    @Autowired
    ChatroomManager(ChatDao chatDao){
        this.chatDao = chatDao;
        maxRoomNum = chatDao.getMaxRoomNum();
    }

    public boolean isInChatroom(String roomId, String loginId) {
        //채팅방에 있는 인원이면 true 없으면 false
    	int result = chatDao.isInChatroom(roomId,loginId);
    	System.out.println("result = " + result);
        if(result > 0)
            return true;
        else
            return false;
    }

    public ArrayList<MessageModel> getChattingByRoomId(String roomId) {
        //roomId 를 보고 채팅내역을 가져옴
        return chatDao.getChattingByRoomId(roomId);
    }


    public String makeChatroom(String roomName) {
        //roomName 을 받고, Id 를 자동으로 만들어 채팅방을 개설
        String roomId;
        roomName = roomName.replaceAll("<", "&lt;").replaceAll(">", "&gt;");

        synchronized (maxRoomNum){
            //roomNum 의 중복을 방지하기 위하여 synchronized 처리
            maxRoomNum++;
            roomId = "room" + maxRoomNum;
            chatDao.makeChatroom(roomId, roomName);
        }

        return roomId;
    }

    public void joinMemberToChatroom(int parseInt, String channelId) {
        chatDao.joinMemberToChatroom(parseInt,channelId);
    }

    public ArrayList<String> getChatroomMembersByRoomId(String channelId) {
        return chatDao.getChatroomMembersByRoomId(channelId);
    }

    public void insertChat(MessageModel message) {
        chatDao.insertChat(message);
    }

	public ArrayList<Chatroom> getChatrooms(String senderId) {
		return chatDao.getChatrooms(senderId);
	}

	public void outChatroom(String sender, String receiver) {
		chatDao.outChatroom(sender, receiver);
		
		int num = chatDao.numInChatroom(receiver);
		if(num == 0) {
			chatDao.deleteChatting(receiver);
			chatDao.deleteChatroom(receiver);
		}
	}
}
