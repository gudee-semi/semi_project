package com.hy.dao.login;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.hy.common.sql.SqlSessionTemplate;
import com.hy.dto.Member;
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

	public List<User> userList(User param) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		List<User> list =session.selectList("com.hy.mapper.login.SignUpMapper.userList",param);
		session.close();
		return list;
	}
	public List<Member> memberList(Member member) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		List<Member> list = session.selectList("com.hy.mapper.login.SignUpMapper.memberList",member);
		session.close();
		return list; 
	}


	public int selectUserCount(User user) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		int result =session.selectOne("com.hy.mapper.login.SignUpMapper.selectUserCount",user);
		session.close();
		return result;
	}
	public int selectMemberCount(Member member) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		int result =session.selectOne("com.hy.mapper.login.SignUpMapper.selectMemberCount",member);
		session.close();
		return result;
	}

	public int deleteUser(int userNo) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		int result =session.delete("com.hy.mapper.login.SignUpMapper.deleteUser",userNo);
		session.close();
		return result;
	}

	public int selectMember(int userNo) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		Integer resultQ =session.selectOne("com.hy.mapper.login.SignUpMapper.selectMember",userNo); 
		int result = 0 ;
		if(resultQ!=null) {
			result=resultQ.intValue();
		}
		session.close();
		return result;
	}

	

	
	
}
