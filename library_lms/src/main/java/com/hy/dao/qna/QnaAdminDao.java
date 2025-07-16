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
	public List<Qna> selectQnaList(Qna param) {
		
		// MyBatis의 SqlSession을 생성(true: autoCommit 설정)
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		
		// Mapper의 selectAll 쿼리를 실행하여 결과를 List<QnaAdmin>로 받음
		List<Qna> list = session.selectList("com.hy.mapper.qna.QnaAdminMapper.selectQnaList");
	
		// SqlSession을 반드시 닫아줌 (DB 연결 해제)
		session.close();
		
		// 조회 결과(태블릿 목록) 반환
		return list;
	}
	
	// 답글 목록 조회
    public List<QnaAdmin> selectReplyList(int qnaId) {
        try (SqlSession session = MyBatisUtil.getSqlSession(false)) {
            return session.selectList("com.hy.mapper.qna.QnaAdminMapper.selectReplyList", qnaId);
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