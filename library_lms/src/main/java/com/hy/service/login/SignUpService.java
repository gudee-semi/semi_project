package com.hy.service.login;

import org.apache.ibatis.session.SqlSession;

import com.hy.common.sql.SqlSessionTemplate;
import com.hy.dao.login.SignUpDao;
import com.hy.dto.Member;
import com.hy.dto.login.ProfileAttach;
import com.hy.dto.login.User;

public class SignUpService {
	
	SignUpDao dao = new SignUpDao();
	
	//id 중복 검사
	public Member checkId(String memberId) {
		Member member =dao.checkId(memberId);
		return member;

	}
	
	//계정 등록 주민번호 중복검사
	public Member checkRrn(String memberRrn) {
			Member member =dao.checkRrn(memberRrn);
			return member;
	}
	//유저 등록 주민번호 검사
	public User checkUserRrn(String userRrn) {
		User user = dao.checkUserRrn(userRrn);
		return user;
	}

	public int insertMember(Member member, ProfileAttach attach) {
		SqlSession session = SqlSessionTemplate.getSqlSession(false);
		int result= 0;
		try {
			result = dao.insertMember(session,member);
			
			// 2. 파일 정보 등록
			if(attach != null &&result >0) {
				attach.setMemberNo(member.getMemberNo());
				result = dao.insertProfileAttach(session, attach);
			}
			
			//3. commit 또는 rollback
			if(result>0) {
				session.commit();
			}else {
				session.rollback();
			}
		}catch(Exception e){
			e.printStackTrace();
			session.rollback();
			
		}finally {
			session.close();
		}
		return result;
	
	}

	
}
