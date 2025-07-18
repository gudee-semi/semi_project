package com.hy.dao.login;

import org.apache.ibatis.session.SqlSession;

import com.hy.common.sql.SqlSessionTemplate;
import com.hy.dto.Member;
import com.hy.dto.login.ProfileAttach;
import com.hy.dto.login.User;

public class SignUpDao {

	public Member checkId(String memberId) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		Member member = session.selectOne("com.hy.mapper.login.SignUpMapper.checkId",memberId);
		session.close();
		return member;
	}

	public Member checkRrn(String memberRrn) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		Member member = session.selectOne("com.hy.mapper.login.SignUpMapper.checkRrn",memberRrn);
		session.close();
		return member;
	}
	public int insertMember(SqlSession session, Member param) {
		int result = session.insert("com.hy.mapper.login.SignUpMapper.insertMember",param);
		return result;
	}

	public int insertProfileAttach(SqlSession session, ProfileAttach attach) {
		int result = session.insert("com.hy.mapper.login.SignUpMapper.insertMemberAvatar",attach);
		return result;
	}

	public User checkUserRrn(String userRrn) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		User user = session.selectOne("com.hy.mapper.login.SignUpMapper.checkUserRrn",userRrn);
		session.close();
		return user;

	}

}
