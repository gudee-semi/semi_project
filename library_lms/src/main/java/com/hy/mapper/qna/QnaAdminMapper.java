package com.hy.mapper.qna;

import java.util.List;

import com.hy.dto.qna.QnaAdmin;

public interface QnaAdminMapper {
	
	// 테이블 전체 조회
	List<QnaAdmin> selectAll();

}
