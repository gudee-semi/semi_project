package com.hy.service.qna;

import java.util.List;

import com.hy.common.vo.Paging;
import com.hy.dao.qna.QnaListAdminDao;
import com.hy.dto.qna.Qna;
import com.hy.dto.qna.QnaReply;

public class QnaAdminService{
	
	private QnaListAdminDao qnaListAdminDao = new QnaListAdminDao();
	private QnaService qnaService = new QnaService();
	
	// 문의글 조회
	public List<QnaReply> selectAll(String category, String keyword, String searchType) {
	    return qnaListAdminDao.selectAll(category, keyword, searchType);
	}

	// 답글 가져오는 메소드
	public List<QnaReply> selectReplyList(int qnaNo) {
	    return qnaListAdminDao.selectReplyList(qnaNo);
	}
	
    // 단일 답글 조회 서비스
    public QnaReply selectReplyOne(int qnaReplyId) {
        return qnaListAdminDao.selectReplyOne(qnaReplyId);
    }
	
	// 답글 추가
    public void insertReplyAndUpdateStatus(QnaReply reply) {
    	qnaListAdminDao.insertReplyAndUpdateStatus(reply);
    }
	
	// 답글 수정 서비스
    public int updateReply(QnaReply reply) {
        return qnaListAdminDao.updateReply(reply);
    }
    
    // 답글 삭제 (답글 ID, 질문글 ID를 모두 받아야 함)
    public void deleteReply(int qnaReplyId, int qnaId) {
    	qnaListAdminDao.deleteReplyAndUpdateStatus(qnaReplyId, qnaId);
    }
    
    // 조회수
    public void incrementViewCount(int qnaNo) {
    	qnaListAdminDao.incrementViewCount(qnaNo);
    }
    
    public int countQna(String category, String searchType, String keyword) {
        return qnaListAdminDao.countQna(category, searchType, keyword);
    }
    
    // 페이징
    public List<Qna> selectQnaListPaging(Paging paging, String category, String searchType, String keyword) {
        return qnaListAdminDao.selectQnaListPaging(paging, category, searchType, keyword);
    }
}
