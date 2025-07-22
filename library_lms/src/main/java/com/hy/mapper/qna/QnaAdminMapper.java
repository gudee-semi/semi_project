package com.hy.mapper.qna;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.hy.dto.qna.QnaReply;

public interface QnaAdminMapper {
	
	// 테이블 전체 조회
	List<QnaReply> selectAll();

    // 답글 조회
    List<QnaReply> selectReplyList(int qnaNo);
    
    // 단일 답글 조회
    QnaReply selectReplyOne(@Param("qnaId") int qnaId);
	
    // 답글 등록
	void insertReply(QnaReply admin);
	


}
