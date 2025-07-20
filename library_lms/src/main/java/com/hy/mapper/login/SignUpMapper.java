package com.hy.mapper.login;

import java.util.List;

import com.hy.dto.Member;
import com.hy.dto.login.ProfileAttach;
import com.hy.dto.login.User;

public interface SignUpMapper {
	Member checkId(String memberId);
	Member checkRrn(String memberRrn);
	Member checkPhone(String memberPhone);
	User searchUser(User param);
	int insertMember(Member param);
	int insertMemberAvatar(ProfileAttach param);
	User checkUserRrn(String userRrn);
	int insertUser(User param);
	List<User>userList(User param);
	int selectUserCount(User param);
	int deleteUser(int userNo);
	int selectMember(int userNo);
	int selectMemberCount(Member member);
	List<Member> memberList(Member member);
	
}
