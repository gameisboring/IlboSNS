package webSocket.chatting.apis;

import com.google.gson.Gson;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

import webSocket.chatting.chatroom.Chatroom;
import webSocket.chatting.chatroom.ChatroomManager;
import webSocket.chatting.message.MessageModel;
import webSocket.chatting.message.MessageType;
import webSocket.chatting.user.UserManager;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;

@RestController
public class ChatApis {

    ChatroomManager chatroomManager;
    Gson gson;

    @Autowired
    ChatApis(ChatroomManager chatroomManager) {
        this.chatroomManager = chatroomManager;
        gson = new Gson();
    }

    @GetMapping("/chat/{roomId}/{senderId}")
    public ArrayList<MessageModel> getChatting(@PathVariable String roomId, @PathVariable String senderId) {
        //채팅방의 채팅을 불러옴
    	System.out.println(roomId + "의 채팅 불러오기 시작");

        if (senderId.equals("undefined")) {
            //로그인이 안되어있으면 error처리
            ArrayList<MessageModel> errorMessage = new ArrayList<>();
            MessageModel errorMsg = new MessageModel();
            errorMsg.setType(MessageType.ERROR);
            errorMsg.setBody("로그인 되어있지 않습니다");

            return errorMessage;
        }

        if (chatroomManager.isInChatroom(roomId, senderId)) {
            //채팅을 불러오는 사람이 채팅방의 인원이면 채팅을 불러옴
            ArrayList<MessageModel> chats = chatroomManager.getChattingByRoomId(roomId);

            System.out.println(roomId + "의 채팅 불러오기 끝");
            return chats;
        }

        //채팅방 인원이 아니면 error처리
        ArrayList<MessageModel> errorMessage = new ArrayList<>();
        MessageModel errorMsg = new MessageModel();
        errorMsg.setType(MessageType.ERROR);
        errorMsg.setBody("채팅방 인원이 아닙니다.");

        return errorMessage;
    }
    
    @GetMapping("/chat/{senderId}")//senderId가 속한 채팅방 목록
    public ArrayList<Chatroom> getChatroom(@PathVariable String senderId) {
    	
    	ArrayList<Chatroom> chatrooms = chatroomManager.getChatrooms(senderId);
    	return chatrooms;
    }

    @PostMapping("/chat/{roomName}/{senderId}")
    public String makeChatroom(@PathVariable String roomName, @PathVariable String senderId) {
    	System.out.println("채팅방 개설 시작");
        if (senderId.equals("undefined")) {
            //로그인이 안되어있으면 error처리
            return "fail";
        }

        String roomId = chatroomManager.makeChatroom(roomName);
        //채팅방을 만듦
        chatroomManager.joinMemberToChatroom(Integer.parseInt(senderId), roomId);

        System.out.println("채팅방 개설 끝");
        return roomId;
    }
}
