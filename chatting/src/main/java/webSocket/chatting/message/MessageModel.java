package webSocket.chatting.message;

import lombok.Data;

@Data
public class MessageModel {
	private MessageType type;
	private String sender;
	private String senderName;
	private String receiver;
	private String body;
	private String time;
	
	public void setBody(String body) {
		this.body = body.replaceAll("<", "&lt;").replaceAll(">", "&gt;");
	}
}
