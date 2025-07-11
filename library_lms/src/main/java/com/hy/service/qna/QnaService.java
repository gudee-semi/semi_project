package com.hy.service.qna;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.hy.common.sql.SqlSessionTemplate;
import com.hy.dao.QnaDao;
import com.hy.dto.Attach;
import com.hy.dto.Qna;

public class QnaService {
	QnaDao qnaDao = new QnaDao();
	
	public List<Qna> selectQnaList(Qna param){
		return qnaDao.selectQnaList(param);
	}
	
	public int selectQnaCount(Qna param) {
		return qnaDao.selectQnaCount(param);
	}
	
	public Qna selectQnaOne(int qnaNo) {
		return qnaDao.selectQnaOne(qnaNo);
	}
	
	public Attach selectAttachByQnaNo(int qnaNo) {
		return qnaDao.selectAttachByQnaNo(qnaNo);
	}
	
	public Attach selectAttachByAttachNo(int attachNo) {
		return qnaDao.selectAttachByAttachNo(attachNo);
	}
	// 게시글 + 파일 트랜젝션 처리
	public int createQnaWithAttach(Qna qna, Attach attach) {
		SqlSession session = SqlSessionTemplate.getSqlSession(false); // 아무때나 commit 되면 안되고 지정한 순간에 되야함
		int result =0;
		
		try {
			// 1. 게시글 등록
			result = qnaDao.insertQna(session,qna);
			
			// 2. 파일 정보 등록
			if(attach != null && result > 0) {
				attach.setQnaId(qna.getQnaId());
				result = qnaDao.insertAttach(session,attach);
			}
			
			// 3. commit 또는 rollback 
			if(result > 0) {
				session.commit();
			} else {
				session.rollback(); // insertBoard, insertAttach 둘다
			}
		}catch(Exception e) {
			e.printStackTrace();
			session.rollback();
		}finally {
			session.close();
		}
		return result;
		
	}
}
