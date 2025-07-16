package com.hy.dao.mypage;

import org.apache.ibatis.session.SqlSession;

import com.hy.common.sql.SqlSessionTemplate;
import com.hy.dto.Member;
import com.hy.dto.login.ProfileAttach;

public class MyPageDao {

	public ProfileAttach selectProfileAttach(int memberNo) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		ProfileAttach attach = session.selectOne("com.hy.mapper.mypage.MypageMapper.selectProfileAttach", memberNo);
		session.close();
		return attach;
	}

	public int updateMemberPw(Member param) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		int result = session.update("com.hy.mapper.mypage.MypageMapper.updateMemberPw", param);
		session.close();
		return result;
	}

	public int updateMemberAddress(Member param) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		int result = session.update("com.hy.mapper.mypage.MypageMapper.updateMemberAddress", param);
		session.close();
		return result;
	}

	public int updateMemberSchool(Member param) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		int result = session.update("com.hy.mapper.mypage.MypageMapper.updateMemberSchool", param);
		session.close();
		return result;
	}

	public int updateMemberGrade(Member param) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		int result = session.update("com.hy.mapper.mypage.MypageMapper.updateMemberGrade", param);
		session.close();
		return result;
	}

	public int updateProfileAttach(ProfileAttach param) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		int result = session.update("com.hy.mapper.mypage.MypageMapper.updateProfileAttach", param);
		session.close();
		return result;
	}

	public Member selectMember(int memberNo) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		Member member = session.selectOne("com.hy.mapper.mypage.MypageMapper.selectMember", memberNo);
		session.close();
		return member;
	}

	public int deleteMember(int memberNo) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		int result = session.delete("com.hy.mapper.mypage.MypageMapper.deleteMember", memberNo);
		session.close();
		return result;
	}

	public int deleteMemberAvatar(int memberNo) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		int result = session.delete("com.hy.mapper.mypage.MypageMapper.deleteMemberAvatar", memberNo);
		session.close();
		return result;
	}

}
