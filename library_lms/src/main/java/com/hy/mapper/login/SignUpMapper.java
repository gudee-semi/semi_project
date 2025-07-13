package com.hy.mapper.login;

import com.hy.dto.Member;
import com.hy.dto.login.ProfileAttach;
import com.hy.dto.login.User;

public interface SignUpMapper {
	Member checkId(String memberId);
	Member checkRrn(String memberRrn);
	User searchUser(User param);
	int insertMember(Member param);
	int insertMemberAvatar(ProfileAttach param);
	
}
