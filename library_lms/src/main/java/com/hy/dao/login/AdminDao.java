package com.hy.dao.login;

import org.apache.ibatis.session.SqlSession;

import com.hy.common.sql.SqlSessionTemplate;
import com.hy.dto.login.User;

public class AdminDao {

	public User userSearch(User param) {
		SqlSession session =  SqlSessionTemplate.getSqlSession(true);
		User user = session.selectOne("com.hy.mapper.login.SignUpMapper.searchUser", param);
		session.close();
		return user;
	}

	public int insertUser(User param) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		int result =session.insert("com.hy.mapper.login.SignUpMapper.insertUser", param);
		session.close();
		return result;
		
	
	}

	
}
