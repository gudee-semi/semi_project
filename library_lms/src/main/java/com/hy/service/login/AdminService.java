package com.hy.service.login;

import com.hy.dao.login.AdminDao;
import com.hy.dto.login.User;

public class AdminService {
	
	AdminDao dao = new AdminDao();
	
	public User userSearch(String userName , String userRrn) {
		
		User user = new User();
		user.setUserName(userName);
		user.setUserRrn(userRrn);
		
		return dao.userSearch(user);
	}
}
