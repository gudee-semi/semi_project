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
		List<QnaReply> list = session
				.selectList("com.hy.mapper.qna.QnaAdminMapper.selectAll");
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
}