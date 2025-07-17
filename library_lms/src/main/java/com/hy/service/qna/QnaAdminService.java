package com.hy.service.qna;

import java.util.List;

import com.hy.dao.qna.QnaAdminDao;
import com.hy.dto.qna.QnaReply;

public class QnaAdminService{
	
	private QnaAdminDao qnaAdminDao = new QnaAdminDao();
	private QnaService qnaService = new QnaService();
	
	// 문의글 조회
	public List<QnaReply> selectAll() {
		return qnaAdminDao.selectAll();
	}

	// 답글 가져오는 메소드
	public List<QnaReply> selectReplyList(int qnaNo) {
	    return qnaAdminDao.selectReplyList(qnaNo);
	}

	// 답글 작성 메소드
	public void insertReply(QnaReply reply) {
	    qnaAdminDao.insertReply(reply);
	}

}
