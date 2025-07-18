package com.hy.dao.qna;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.hy.common.sql.SqlSessionTemplate;
import com.hy.dto.notice.Notice;
import com.hy.dto.notice.NoticeAttach;
import com.hy.dto.qna.Attach;
import com.hy.dto.qna.Qna;

public class QnaDao {
	public List<Qna> selectQnaList(Qna param){
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		List<Qna> list = session.selectList("com.hy.mapper.qna.QnaMapper.selectQnaList", param);
		session.close();
		return list;
	}
	
	public int selectQnaCount(Qna param) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		int count = session.selectOne("com.hy.mapper.qna.QnaMapper.selectQnaCount", param);
		session.close();
		return count;
	}
	
	public int updateViewCount(int qnaId) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		int result = session.update("com.hy.mapper.qna.QnaMapper.updateViewCount", qnaId);
		session.close();
		return result;
	}
	
	public int updateQna(SqlSession session, Qna qna) {
		return session.update("com.hy.mapper.qna.QnaMapper.updateQna", qna);
	}
	
	public int updateAttach(SqlSession session, Attach attach) {
		return session.update("com.hy.mapper.notice.QnaMapper.updateAttach", attach);
	}
	
	public int deleteAttach(SqlSession session, Qna qna) {
		return session.delete("com.hy.mapper.qna.QnaMapper.deleteAttach", qna);

	}
	
	public Qna selectQnaOne(int qnaId) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		Qna qna = session.selectOne("com.hy.mapper.qna.QnaMapper.selectQnaOne", qnaId);
		session.close();
		return qna;
	}
	

	public int deleteQna(int qnaId) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		int result = session.delete("com.hy.mapper.qna.QnaMapper.deleteQna", qnaId);
		session.close();
		return result;
	}
	
	public Attach selectAttachByQnaNo(int qnaId) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		Attach attach = session.selectOne("com.hy.mapper.qna.QnaMapper.selectAttachByQnaNo", qnaId);
		session.close();
		return attach;
	}
	
	public Attach selectAttachByAttachNo(int attachNo) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		Attach attach = session.selectOne("com.hy.mapper.qna.QnaMapper.selectAttachByAttachNo", attachNo);
		session.close();
		return attach;
	}
	
	public int insertQna(SqlSession session, Qna qna) {
		int result = session.insert("com.hy.mapper.qna.QnaMapper.insertQna", qna);
		return result;
	}
	
	public int insertAttach(SqlSession session, Attach attach) {
		int result = session.insert("com.hy.mapper.qna.QnaMapper.insertAttach", attach);
		return result;
	}
}
