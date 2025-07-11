package com.hy.service.login;

import com.hy.dao.login.SignUpDao;
import com.hy.dto.Member;

public class SignUpService {
	
	SignUpDao dao = new SignUpDao();
	
	//id 중복 검사
	public Member checkId(String memberId) {
		Member member =dao.checkId(memberId);
		return member;

	}
	
	//주민번호 중복검사
	public Member checkRrn(String memberRrn) {
			Member member =dao.checkRrn(memberRrn);
			return member;
	}
	
}
