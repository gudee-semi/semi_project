package com.hy.mapper.mypage;

import java.util.List;

import com.hy.dto.Member;
import com.hy.dto.login.ProfileAttach;
import com.hy.dto.qna.Qna;
import com.hy.dto.qna.QnaReply;

public interface MypageMapper {
	 ProfileAttach selectProfileAttach(int memberNo);
	 int updateMemberPw(Member param);
	 int updateMemberAddress(Member param);
	 int updateMemberSchool(Member param);
	 int updateMemberGrade(Member param);
	 int updateProfileAttach(ProfileAttach param);
	 Member selectMember(int memberNo);
	 int deleteMember(int memberNo);
	 int deleteMemberAvatar(int memberNo);
	 int selectMyQnaCount(Qna qna);
	 List<Qna> selectMyQnaList(Qna qna);
	 List<QnaReply> selectMyQnaReplyList(int memberNo);
	 int updateReplyCheck(int qnaId);
	 int updateMemberPhone(Member param);
}
