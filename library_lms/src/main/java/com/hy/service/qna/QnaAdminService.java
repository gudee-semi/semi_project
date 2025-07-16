package com.hy.service.qna;

import java.util.List;

import com.hy.dao.qna.QnaAdminDao;
import com.hy.dto.qna.QnaAdmin;

public class QnaAdminService {
	
	private QnaAdminDao qnaAdminDao = new QnaAdminDao();
	
	// 게시글 조회
	public List<QnaAdmin> selectQnaList() {
		return qnaAdminDao.selectQnaList();
	}

	// 답글(댓글) 한개 메서드
	public QnaAdmin selectReplyOne(int qnaId) {
		return qnaAdminDao.selectReplyOne(qnaId);
	}

	// 답글 작성 메소드
	public void insertReply(int qnaId, String content) {
		qnaAdminDao.insertReply(qnaId, content);
	}

}
