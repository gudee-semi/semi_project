package com.hy.dao.mypage;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.hy.common.sql.SqlSessionTemplate;
import com.hy.dto.Member;
import com.hy.dto.login.ProfileAttach;
import com.hy.dto.qna.Qna;
import com.hy.dto.qna.QnaReply;

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
	public int updateMemberPhone(Member param) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		int result = session.update("com.hy.mapper.mypage.MypageMapper.updateMemberPhone", param);
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

	public int selectMyQnaCount(Qna qna) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		int result = session.selectOne("com.hy.mapper.mypage.MypageMapper.selectMyQnaCount", qna);
		session.close();
		return result;
	}

	public List<Qna> selectMyQnaList(Qna qna) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		List<Qna> list = session.selectList("com.hy.mapper.mypage.MypageMapper.selectMyQnaList", qna);
		session.close();
		return list;
	}

	public List<QnaReply> selectMyQnaReplyList(int memberNo) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		List<QnaReply> list =session.selectList("com.hy.mapper.mypage.MypageMapper.selectMyQnaReplyList", memberNo);
		session.close();
		return list;
	}

	public int updateReplyCheck(int qnaId) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		int result = session.update("com.hy.mapper.mypage.MypageMapper.updateReplyCheck", qnaId);
		session.close();
		return result;
	}

	

}
