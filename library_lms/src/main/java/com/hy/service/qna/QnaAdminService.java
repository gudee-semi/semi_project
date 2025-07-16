package com.hy.service.qna;

import java.util.List;

import com.hy.dao.qna.QnaAdminDao;
import com.hy.dao.qna.QnaDao;
import com.hy.dto.qna.QnaAdmin;

public class QnaAdminService {
	
	private QnaAdminDao qnaDao = new QnaAdminDao();
	
	// 게시글 조회
	public List<QnaAdmin> selectAll() {
		return qnaDao.selectAll();
	}

}
