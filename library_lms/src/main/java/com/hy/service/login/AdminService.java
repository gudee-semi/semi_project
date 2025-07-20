package com.hy.service.login;

import java.util.List;

import com.hy.dao.login.AdminDao;
import com.hy.dto.Member;
import com.hy.dto.login.User;

public class AdminService {
	
	AdminDao dao = new AdminDao();
	
	public User userSearch(String userName , String userRrn) {
		
		User user = new User();
		user.setUserName(userName);
		user.setUserRrn(userRrn);
		
		return dao.userSearch(user);
	}

	public int insertUser(User param) {
		return dao.insertUser(param);
		
	}
	public List<User> userList(User param){
		return dao.userList(param);
	
	}
	public List<Member> memberList(Member member) {
		return dao.memberList(member);
	}
	

	public int selectUserCount(User user) {
		return dao.selectUserCount(user);
	}
	public int selectMemberCount(Member member) {
		return dao.selectMemberCount(member);
	}

	public int deleteUser(int userNo) {
		
		return dao.deleteUser(userNo);
	}

	public int selectMember(int userNo) {
		return dao.selectMember(userNo);
	}

	


	
}
