package com.hy.dao.qna;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.hy.common.sql.SqlSessionTemplate;
import com.hy.dto.qna.Attach;
import com.hy.dto.qna.Qna;

public class QnaDao {
	public List<Qna> selectQnaList(Qna param){
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		List<Qna> list = session.selectList("com.hy.mapper.QnaMapper.selectQnaList", param);
		session.close();
		return list;
	}
	
	public int selectQnaCount(Qna param) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		int count = session.selectOne("com.hy.mapper.QnaMapper.selectQnaCount", param);
		session.close();
		return count;
	}
	
	public Qna selectQnaOne(int qnaNo) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		Qna qna = session.selectOne("com.hy.mapper.QnaMapper.selectQnaOne", qnaNo);
		session.close();
		return qna;
	}
	
	public Attach selectAttachByQnaNo(int qnaNo) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		Attach attach = session.selectOne("com.hy.mapper.QnaMapper.selectAttachByQnaNo", qnaNo);
		session.close();
		return attach;
	}
	
	public Attach selectAttachByAttachNo(int attachNo) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		Attach attach = session.selectOne("com.hy.mapper.QnaMapper.selectAttachByAttachNo", attachNo);
		session.close();
		return attach;
	}
	
	public int insertQna(SqlSession session, Qna qna) {
		int result = session.insert("com.hy.mapper.QnaMapper.insertQna", qna);
		return result;
	}
	
	public int insertAttach(SqlSession session, Attach attach) {
		int result = session.insert("com.hy.mapper.QnaMapper.insertAttach", attach);
		return result;
	}
}
