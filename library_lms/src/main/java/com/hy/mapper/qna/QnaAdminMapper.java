package com.hy.mapper.qna;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.hy.dto.qna.QnaAdmin;

public interface QnaAdminMapper {
	
	// 테이블 전체 조회
	List<QnaAdmin> selectAll();

	QnaAdmin selectReplyOne(@Param("qnaId") int qnaId);

	void insertReply(int qnaId, String content);

}
