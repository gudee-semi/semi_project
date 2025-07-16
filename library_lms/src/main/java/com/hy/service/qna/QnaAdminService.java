package com.hy.service.qna;

import java.util.List;

import com.hy.dao.qna.QnaAdminDao;
import com.hy.dao.qna.QnaDao;
import com.hy.dto.qna.Qna;
import com.hy.dto.qna.QnaAdmin;

public class QnaAdminService {
	
	private QnaAdminDao qnaAdminDao = new QnaAdminDao();
	private QnaDao qnaDao = new QnaDao();
	
	// 게시글 조회
	public List<Qna> selectQnaList() {
		return qnaDao.selectQnaList(new Qna());
	}
	
    // 답글(댓글) 리스트 조회 메서드
    public List<QnaAdmin> selectReplyList(int qnaId) {
        return qnaAdminDao.selectReplyList(qnaId);
    }
    
    // 답글 작성 메소드
    public void insertReply(int qnaId, String content) {
        qnaAdminDao.insertReply(qnaId, content);
    }
    
    

}
