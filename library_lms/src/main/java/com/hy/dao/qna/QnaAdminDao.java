package com.hy.dao.qna;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.hy.common.sql.SqlSessionTemplate;
import com.hy.controller.tablet.MyBatisUtil;
import com.hy.dto.qna.Qna;
import com.hy.dto.qna.QnaReply;

public class QnaAdminDao {

	// 전체 목록 조회
	public List<QnaReply> selectAll() {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		List<QnaReply> list = session.selectList("com.hy.mapper.qna.QnaAdminMapper.selectAll");
		session.close();
		return list;
	}

	// 답글 목록 조회
	public List<QnaReply> selectReplyList(int qnaId) {
	    SqlSession session = SqlSessionTemplate.getSqlSession(true);
	    List<QnaReply> list = session.selectList("com.hy.mapper.qna.QnaAdminMapper.selectReplyList", qnaId);
	    session.close();
	    return list;
	}

	// 답글 추가
	public void insertReply(QnaReply reply) {
	    SqlSession session = SqlSessionTemplate.getSqlSession(true);
	    session.insert("com.hy.mapper.qna.QnaAdminMapper.insertReply", reply);
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
    
    // 답글 삭제
    public int deleteReply(int qnaReplyId) {
        SqlSession session = SqlSessionTemplate.getSqlSession(true);
        int result = session.delete("com.hy.mapper.qna.QnaAdminMapper.deleteReply", qnaReplyId);
        session.close();
        return result;
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