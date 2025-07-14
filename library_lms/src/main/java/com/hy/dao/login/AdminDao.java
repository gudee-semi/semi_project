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

	
}
