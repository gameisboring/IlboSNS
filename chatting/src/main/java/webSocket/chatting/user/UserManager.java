package webSocket.chatting.user;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import webSocket.chatting.dao.UserDao;

@Component
public class UserManager {
	
	UserDao userDao;
	Set<Integer> onlineUsers;
	
	@Autowired
	public UserManager(UserDao userDao) {
		this.userDao = userDao;
		onlineUsers = new HashSet<>();
	}

	public String getUserNameById(String senderId) {
		return userDao.getUserNameById(senderId);
	}

	public void online(int id) {
		onlineUsers.add(id);
	}
	
	public void offline(int id) {
		onlineUsers.remove(id);
	}
	
	public boolean isOnline(int id) {
		return onlineUsers.contains(id);
	}

	public ArrayList<String> getFollowers(int id) {
		return userDao.getFollowers(id);
	}
	
	public ArrayList<String> getFollows(int id) {
		return userDao.getFollows(id);
	}
	
	public void printAll() {
		System.out.println("----현재 접속 인원-------");
		onlineUsers.forEach(user->System.out.println(user));
	}

	
}
