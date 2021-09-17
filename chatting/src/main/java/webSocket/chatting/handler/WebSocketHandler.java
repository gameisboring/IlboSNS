package webSocket.chatting.handler;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.DestinationVariable;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.web.bind.annotation.RestController;

import com.google.gson.Gson;

import webSocket.chatting.chatroom.ChatroomManager;
import webSocket.chatting.dao.NotiDao;
import webSocket.chatting.message.MessageModel;
import webSocket.chatting.user.UserManager;

@RestController
public class WebSocketHandler {

    private final SimpMessagingTemplate msgTemplate; // 메세지 보낼 때 쓰는 객체
    private final ChatroomManager chatroomManager;	//채팅방과 채팅을 관리
    private final SimpleDateFormat format;			//date타입의 포맷을 관리
    private final UserManager userManager;			//온라인인 유저를 관리
    private final NotiDao notiDao;
    private final Gson gson;

    @Autowired
    WebSocketHandler(ChatroomManager chatroomManager, SimpMessagingTemplate msgTemplate, UserManager userManager, NotiDao notiDao) {
        this.msgTemplate = msgTemplate;
        this.chatroomManager = chatroomManager;
        this.userManager = userManager;
        this.notiDao = notiDao;
        this.format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        this.gson = new Gson();
    }
    
    
    
    
    /* sendMessage Overloading ------------------------ */

    private void sendMessage(List<String> members, MessageModel msg, String type) {
        String sendMsg = gson.toJson(msg);
        members.forEach(member -> msgTemplate.convertAndSend(String.format("/topic/%s/%s", type, member), sendMsg));
    }
    
    private void sendMessage(List<String> members, String msg, String type) {
        members.forEach(member -> msgTemplate.convertAndSend(String.format("/topic/%s/%s", type, member), msg));
    }
    
    private void sendMessage(MessageModel msg, String type) {
		msgTemplate.convertAndSend(String.format("/topic/%s/%s", type, msg.getReceiver()), msg);
	}
    
    
    /* ------------------------------------------------------*/
    
    
    
    
    @MessageMapping("/online/{id}")//when user Online
    public void insertOnline(@DestinationVariable int id) {
    	userManager.online(id);
    	System.out.println(id + " 님이 접속했습니다.");
    	
    	Set<String> members = new HashSet<String>();
    	
    	ArrayList<String> followerList = userManager.getFollowers(id);
    	ArrayList<String> followList = userManager.getFollows(id);
    	//userManager에 추가
    	
    	members.addAll(followerList);
    	members.addAll(followList);
    	
    	sendMessage(List.copyOf(members), "" + id, "online");
    	
    }

    @MessageMapping("/join") //채팅방에 초대 받아 들어갈 때
    public void joinMessageHandler(String message) {
        System.out.println("JOIN MessageMapper Start");

        MessageModel msg = gson.fromJson(message,MessageModel.class);

        System.out.println("sender = " + msg.getSender());
        System.out.println("receiver = " + msg.getReceiver());
        System.out.println("chatroom = " + msg.getBody());
        
        msg.setTime(format.format(new Date()));
        
        String[] chatroom = msg.getBody().split(";");

        chatroomManager.joinMemberToChatroom(Integer.parseInt(msg.getReceiver()), chatroom[0]);
        //db에 채팅방와 인원을 insert

        ArrayList<String> members = chatroomManager.getChatroomMembersByRoomId(chatroom[0]);
        sendMessage(members, msg, "join");

        System.out.println("JOIN MessageMapper End");
    }

    @MessageMapping("/chat") //채팅을 할 때
    public void chatMessageHandler(String message) {
        System.out.println("CHAT MessageMapper Start");
        
        MessageModel msg = gson.fromJson(message,MessageModel.class);

        System.out.println("sender = " + msg.getSender());
        System.out.println("receiver = " + msg.getReceiver());
        System.out.println("chatbody = " + msg.getBody());
        
        ArrayList<String> members = chatroomManager.getChatroomMembersByRoomId(msg.getReceiver());
        System.out.println(members);

        msg.setTime(format.format(new Date()));

        chatroomManager.insertChat(msg);
        sendMessage(members, msg, "chat");

        System.out.println("CHAT MessageMapper End");
    }
    
    @MessageMapping("/out")//채팅방에서 나갈 때
    public void outChatroom(String message) {
    	System.out.println("OUT MessageMapper Start");
    	
    	MessageModel msg = gson.fromJson(message,MessageModel.class);
    	System.out.println("sender = " + msg.getSender());
        System.out.println("receiver = " + msg.getReceiver());
    	
        chatroomManager.outChatroom(msg.getSender(), msg.getReceiver());
    	
    	System.out.println("OUT MessageMapper End");
    }
    
    @MessageMapping("/noti")// 알림을 보낼 때
    public void notification(String message) {
    	System.out.println("NOTI MessageMapper Start");

    	MessageModel msg = gson.fromJson(message,MessageModel.class);
    	System.out.println("sender = " + msg.getSender());
        System.out.println("receiver = " + msg.getReceiver());
        System.out.println("body = " + msg.getBody());
        
        msg.setTime(format.format(new Date()));
        
        notiDao.insertNoti(msg);
        
        sendMessage(msg, "noti");
    	
    	System.out.println("NOTI MessageMapper End");
    }

	@MessageMapping("/offline/{id}")//접속을 종료할때
    public void deleteOnline(@DestinationVariable int id) {
    	userManager.offline(id);
    	
    	System.out.println(id + " 님이 접속종료 했습니다.");
    	userManager.printAll();
    	
    	Set<String> members = new HashSet<String>();
    	
    	ArrayList<String> followerList = userManager.getFollowers(id);
    	ArrayList<String> followList = userManager.getFollows(id);
    	//userManager에 추가
    	
    	members.addAll(followerList);
    	members.addAll(followList);
    	
    	sendMessage(List.copyOf(members), "" + id, "offline");
    }
}
