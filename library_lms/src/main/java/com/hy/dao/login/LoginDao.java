package com.hy.dao.login;

import org.apache.ibatis.session.SqlSession;

import com.hy.common.sql.SqlSessionTemplate;
import com.hy.dto.Member;

public class LoginDao {
	public Member selectMember(Member param) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		Member member =session.selectOne("com.hy.mapper.login.LoginMapper.selectMember", param);
		session.close();
		return member;
	}

	public Member searchId(Member param) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		Member member =session.selectOne("com.hy.mapper.login.LoginMapper.searchId", param);
		session.close();
		return member;
	}

	public Member searchPw(Member param) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		Member member =session.selectOne("com.hy.mapper.login.LoginMapper.searchPw", param);
		session.close();
		return member;
	}

	public int updatePw(Member param) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		int result =session.update("com.hy.mapper.login.LoginMapper.updatePw", param);
		session.close();
		return result;
	}
}
