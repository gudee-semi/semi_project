package com.hy.mapper.mypage;

import com.hy.dto.Member;
import com.hy.dto.login.ProfileAttach;

public interface MypageMapper {
	 ProfileAttach selectProfileAttach(int memberNo);
	 int updateMemberPw(Member param);
	 int updateMemberAddress(Member param);
	 int updateMemberSchool(Member param);
	 int updateMemberGrade(Member param);
	 int updateProfileAttach(ProfileAttach param);
	 Member selectMember(int memberNo);
}
