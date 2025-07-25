package com.hy.service.login;

import com.hy.dao.login.LoginDao;
import com.hy.dto.Member;

public class LoginService {
	
		LoginDao dao = new LoginDao();
	public Member selectMember(String memberId , String memberPw) {
		Member member = new Member();
		member.setMemberId(memberId);
		member.setMemberPw(memberPw);
		return dao.selectMember(member);
	}
	public Member searchId(String memberName, String memberRrn) {
		Member member = new Member();
		member.setMemberName(memberName);
		member.setMemberRrn(memberRrn);
		return dao.searchId(member);
	}
	public Member searchPw(String memberId, String memberRrn) {
		Member member = new Member();
		member.setMemberId(memberId);
		member.setMemberRrn(memberRrn);
		return dao.searchPw(member);
		
	}
	public int updatePw(String memberId, String memberPw) {
		Member member =new Member();
		member.setMemberId(memberId);
		member.setMemberPw(memberPw);
		int result = dao.updatePw(member);
		
		return result;
	}
}
