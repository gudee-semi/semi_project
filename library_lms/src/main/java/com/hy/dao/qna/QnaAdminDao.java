package com.hy.dao.qna;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.hy.common.sql.SqlSessionTemplate;
import com.hy.controller.tablet.MyBatisUtil;
import com.hy.dto.qna.Qna;
import com.hy.dto.qna.QnaAdmin;

public class QnaAdminDao {
	
	// 전체 목록 조회
	public List<QnaAdmin> selectQnaList() {
		
		SqlSession session = SqlSessionTemplate.getSqlSession(false);
		List<QnaAdmin> list = session.selectList("com.hy.mapper.qna.QnaAdminMapper.selectQnaList");
		session.close();		
		return list;
	}
	
	// 답글 한개 조회
	public QnaAdmin selectReplyOne(int qnaId) {
    try (SqlSession session = MyBatisUtil.getSqlSession(false)) {
        return session.selectOne(
            "com.hy.mapper.qna.QnaAdminMapper.selectReplyOne",qnaId);
    }
    }
    
    public void insertReply(int qnaId, String content) {
        try (SqlSession session = MyBatisUtil.getSqlSession(false)) {
            session.insert("com.hy.mapper.qna.QnaAdminMapper.insertReply",
                Map.of("qnaId", qnaId, "content", content));
            session.commit();
        }
    }
}