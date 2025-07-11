package com.hy.dao.login;

import org.apache.ibatis.session.SqlSession;

import com.hy.common.sql.SqlSessionTemplate;
import com.hy.dto.Member;

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

}
