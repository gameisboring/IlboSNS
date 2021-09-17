package webSocket.chatting.apis;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

import com.google.gson.Gson;

import webSocket.chatting.dao.NotiDao;
import webSocket.chatting.message.MessageModel;
import webSocket.chatting.user.UserManager;
import webSocket.chatting.user.UserStatus;

@RestController
public class UserApis {
	
	UserManager userManager;
	NotiDao notiDao;
    Gson gson;

    @Autowired
    UserApis(UserManager userManager, NotiDao notiDao) {
        this.userManager = userManager;
        this.notiDao = notiDao;
        gson = new Gson();
    }
    
    @GetMapping("/user/follow/{id}") //자신이 팔로우 하는 사람 목록
    public ArrayList<UserStatus> getOnlineFollow(@PathVariable int id) {
    	ArrayList<String> follows = userManager.getFollows(id);
    	ArrayList<UserStatus> people = new ArrayList<UserStatus>();
    	
    	userManager.printAll();
    	
    	for(String follow : follows) {
    		UserStatus user = new UserStatus();
    		
    		user.setUserId(Integer.parseInt(follow));
    		if(userManager.isOnline(Integer.parseInt(follow)))
    			user.setUserStatus("online");
    		else
    			user.setUserStatus("offline");
    		
    		people.add(user);
    	}
    	
    	return people;
    }
    
    @GetMapping("/user/follower/{id}") //자신을 팔로우 하는 사람 목록
    public ArrayList<UserStatus> getOnlineFollower(@PathVariable int id) {
    	ArrayList<String> followers = userManager.getFollowers(id);
    	ArrayList<UserStatus> people = new ArrayList<UserStatus>();
    	
    	userManager.printAll();
    	
    	for(String follower : followers) {
    		UserStatus user = new UserStatus();
    		
    		user.setUserId(Integer.parseInt(follower));
    		if(userManager.isOnline(Integer.parseInt(follower)))
    			user.setUserStatus("online");
    		else
    			user.setUserStatus("offline");
    		
    		people.add(user);
    	}
    	
    	return people;
    }
    
    @GetMapping("/user/noti/{id}") // id의 알림 목록
    public ArrayList<MessageModel> getNotifications(@PathVariable int id){
    	System.out.println(id + " 님의 알림 조회");
    	ArrayList<MessageModel> notifications = notiDao.getNotifications(id);
    	
    	
    	return notifications;
    }
}
