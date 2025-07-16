package com.hy.service.mypage;


import java.io.File;

import com.hy.dao.mypage.MyPageDao;
import com.hy.dto.Member;
import com.hy.dto.login.ProfileAttach;

public class MyPageService {
		private MyPageDao dao = new MyPageDao();
	public ProfileAttach selectProfileAttach(int memberNo) {
		ProfileAttach attach = dao.selectProfileAttach(memberNo);
		return attach;
	}
	
	public int updateMember(Member member, ProfileAttach attach) {
		boolean success = true;
			if(member.getMemberPw()!=null) {
				success &= dao.updateMemberPw(member)>0;
			}
			if(member.getMemberAddress()!=null) {
				success &= dao.updateMemberAddress(member)>0;
				}
			if(member.getMemberSchool()!=null) {
				success &= dao.updateMemberSchool(member)>0;
				}
			if(member.getMemberGrade()!=0) {
				success &= dao.updateMemberGrade(member)>0;
				}
			if(attach != null ) {
				boolean at=false;
				//원래 attach정보 저장
				ProfileAttach oriAttach = dao.selectProfileAttach(member.getMemberNo());
				// attach 정보 업데이트
				attach.setMemberNo(member.getMemberNo());
				at = dao.updateProfileAttach( attach)>0;
				//기존 경로로 가서 파일 제거
				if(at) {
					File file = new File(oriAttach.getPath());
					if (file.exists()) {
						file.delete();
					}
				}
				success &= at;
				
			}
		
		return success ? 1: 0;
	
	}
	public Member selectMember(int memberNo) {
		return dao.selectMember(memberNo);
	}
	
}
