package webSocket.chatting.dao;

import java.util.ArrayList;

import org.springframework.stereotype.Component;

import webSocket.chatting.message.MessageModel;

@Component
public interface NotiDao {

	void insertNoti(MessageModel msg);

	ArrayList<MessageModel> getNotifications(int id);

}
