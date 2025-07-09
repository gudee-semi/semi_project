package com.hy.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.hy.common.sql.SqlSessionTemplate;
import com.hy.dto.Attach;
import com.hy.dto.Qna;

public class QnaDao {
	public List<Qna> selectQnaList(Qna param){
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		List<Qna> list = session.selectList("com.gn.mapper.QnaMapper.selectQnaList", param);
		session.close();
		return list;
	}
	
	public Qna selectQnaOne(int qnaNo) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		Qna qna = session.selectOne("com.gn.mapper.QnaMapper.selectQnaOne", qnaNo);
		session.close();
		return qna;
	}
	
	public Attach selectAttachByQnaNo(int qnaNo) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		Attach attach = session.selectOne("com.gn.mapper.QnaMapper.selectAttachByQnaNo", qnaNo);
		session.close();
		return attach;
	}
	
	public Attach selectAttachByAttachNo(int attachNo) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		Attach attach = session.selectOne("com.gn.mapper.QnaMapper.selectAttachByAttachNo", attachNo);
		session.close();
		return attach;
	}
	
	public int selectQnaCount(Qna param) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		int count = session.selectOne("com.gn.mapper.QnaMapper.selectQnaCount", param);
		session.close();
		return count;
	}
	
	public int insertQna(SqlSession session, Qna qna) {
		int result = session.insert("com.gn.mapper.QnaMapper.insertQna", qna);
		return result;
	}
	
	public int insertAttach(SqlSession session, Attach attach) {
		int result = session.insert("com.gn.mapper.QnaMapper.insertAttach", attach);
		return result;
	}
}
