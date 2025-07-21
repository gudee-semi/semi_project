package com.hy.dao.qna;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.hy.common.sql.SqlSessionTemplate;
import com.hy.controller.tablet.MyBatisUtil;
import com.hy.dto.qna.QnaReply;

public class QnaAdminDao {

	// 전체 목록 조회
	public List<QnaReply> selectAll() {
		SqlSession session = SqlSessionTemplate.getSqlSession(false);
		List<QnaReply> list = session.selectList("com.hy.mapper.qna.QnaAdminMapper.selectAll");
		session.close();
		return list;
	}

	// 답글 목록 조회
	public List<QnaReply> selectReplyList(int qnaId) {
	    SqlSession session = SqlSessionTemplate.getSqlSession(false);
	    List<QnaReply> list = session.selectList("com.hy.mapper.qna.QnaAdminMapper.selectReplyList", qnaId);
	    session.close();
	    return list;
	}	

	// 답글 추가 + answer_status 1 변경 트랜잭션
	public void insertReplyAndUpdateStatus(QnaReply reply) {
	   
		// 1. SqlSession 생성 (autoCommit = false: 직접 커밋)
	    SqlSession session = SqlSessionTemplate.getSqlSession(false);

	        // 2. 답글 등록
	        session.insert("com.hy.mapper.qna.QnaAdminMapper.insertReply", reply);
	        
	        // 3. answerStatus = 1로 업데이트
	        session.update("com.hy.mapper.qna.QnaAdminMapper.updateAnswerStatus", reply.getQnaId());
	        
	        // 커밋
	        session.commit();

	        // 세션 닫기
	        session.close();
	    

	}
	
	// 답글 수정
    public int updateReply(QnaReply reply) {
        SqlSession session = SqlSessionTemplate.getSqlSession(true);
        int result = session.update("com.hy.mapper.qna.QnaAdminMapper.updateReply", reply);
        session.close();
        return result;
    }

    // 단일 답글 조회
    public QnaReply selectReplyOne(int qnaReplyId) {
        SqlSession session = SqlSessionTemplate.getSqlSession(true);
        QnaReply reply = session.selectOne("com.hy.mapper.qna.QnaAdminMapper.selectReplyOne", qnaReplyId);
        session.close();
        return reply;
    }
    
 // 답글 삭제 + answer_status 0 변경 트랜잭션
    public void deleteReplyAndUpdateStatus(int qnaReplyId, int qnaId) {
        
		// 1. SqlSession 생성 (autoCommit = false: 직접 커밋)
    	SqlSession session = SqlSessionTemplate.getSqlSession(false);

            // 1. 답글 삭제
            session.delete("com.hy.mapper.qna.QnaAdminMapper.deleteReply", qnaReplyId);

            // 2. answer_status를 0으로 변경
            session.update("com.hy.mapper.qna.QnaAdminMapper.updateAnswerStatusZero", qnaId);

            // 3. 커밋
            session.commit();

	        // 세션 닫기
            session.close();
    }

    
    public int updatePenalty(int memberNo) {
   	 SqlSession session = SqlSessionTemplate.getSqlSession(true);
   	 int result = session.update("com.hy.mapper.tablet.TabletMapper.updatePenalty", memberNo);
   	 session.close();
   	 return result;
    }
    
    public void incrementViewCount(int qnaNo) {
        SqlSession session = MyBatisUtil.getSqlSession(true);
        session.update("com.hy.mapper.qna.QnaAdminMapper.incrementViewCount", qnaNo);
        session.close();
    }
}