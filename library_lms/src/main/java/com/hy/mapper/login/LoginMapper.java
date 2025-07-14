package com.hy.mapper.login;

import com.hy.dto.Member;

public interface LoginMapper {
	Member selectMember(Member param);
	Member searchId(Member param);
	Member searchPw(Member param);
	int updatePw(Member param);
}
