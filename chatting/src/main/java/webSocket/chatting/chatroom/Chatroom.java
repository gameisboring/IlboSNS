package webSocket.chatting.chatroom;

import lombok.Data;

@Data
public class Chatroom {
	private String roomId;
	private String roomName;
	private int roomPeople;
	private String roomLastChat;
}
