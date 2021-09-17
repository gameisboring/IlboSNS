package webSocket.chatting.dao;

import java.util.ArrayList;

import org.springframework.stereotype.Component;

@Component
public interface UserDao {

	String getUserNameById(String senderId);

	ArrayList<String> getFollowers(int id);

	ArrayList<String> getFollows(int id);

}
