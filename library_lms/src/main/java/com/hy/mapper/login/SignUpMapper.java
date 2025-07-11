package com.hy.mapper.login;

import com.hy.dto.Member;

public interface SignUpMapper {
	Member checkId(String memberId);
	Member checkRrn(String memberRrn);
	
}
