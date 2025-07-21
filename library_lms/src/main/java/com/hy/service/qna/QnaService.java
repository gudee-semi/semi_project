package com.hy.service.qna;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.hy.common.sql.SqlSessionTemplate;
import com.hy.dao.qna.QnaDao;
import com.hy.dto.notice.Notice;
import com.hy.dto.notice.NoticeAttach;
import com.hy.dto.qna.Attach;
import com.hy.dto.qna.Qna;

public class QnaService {
	private QnaDao qnaDao = new QnaDao();
	
	public List<Qna> selectQnaList(Qna param){
		return qnaDao.selectQnaList(param);
	}
	
	public int selectQnaCount(Qna param) {
		return qnaDao.selectQnaCount(param);
	}
	
	public int updateViewCount(int qnaId) {
		return qnaDao.updateViewCount(qnaId);
	}
	
	public Qna selectQnaOne(int qnaNo) {
		return qnaDao.selectQnaOne(qnaNo);
	}
	
	public int deleteQna(int qnaNo) {
		return qnaDao.deleteQna(qnaNo);
	}
	
	public Attach selectAttachByQnaNo(int qnaId) {
		return qnaDao.selectAttachByQnaNo(qnaId);
	}
	
	public Attach selectAttachByAttachNo(int attachNo) {
		return qnaDao.selectAttachByAttachNo(attachNo);
	}
	// 게시글 + 파일 트랜젝션 처리
	public int createQnaWithAttach(Qna qna, Attach attach) {
		SqlSession session = SqlSessionTemplate.getSqlSession(false); // 아무때나 commit 되면 안되고 지정한 순간에 되야함
		int result = 0;
		
		try {
			// 1. 게시글 등록
			result = qnaDao.insertQna(session,qna);
			
			// 2. 파일 정보 등록
			if(attach != null && result > 0) {
				attach.setQnaId(qna.getQnaId());
				attach.setPath("C:\\upload\\qna\\");
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
	public int updateQnaWithAttach(Qna qna, Attach attach) {
		SqlSession session = SqlSessionTemplate.getSqlSession(false);
		int result = 0;
		
		try {
			result = qnaDao.updateQna(session, qna);
			
			if (attach != null && result > 0) {
				result = qnaDao.updateAttach(session, attach);
			}
						
			// commit or rollback
			if (result > 0) session.commit();
			else session.rollback();
			
		} catch (Exception e) {
			e.printStackTrace();
			session.rollback();
		}  finally {
			session.close();
		}
		
		return result;
	}

	public int updateQnaDeleteAttach(Qna qna) {
		SqlSession session = SqlSessionTemplate.getSqlSession(false);
		int result = 0;
		
		try {
			result = qnaDao.updateQna(session, qna);
			
			if (result > 0) {
				result = qnaDao.deleteAttach(session, qna);
			}
						
			// commit or rollback
			if (result > 0) session.commit();
			else session.rollback();
			
		} catch (Exception e) {
			e.printStackTrace();
			session.rollback();
		}  finally {
			session.close();
		}
		
		return result;
	}
	
	public int updateQnaSameAttach(Qna qna) {
		SqlSession session = SqlSessionTemplate.getSqlSession(false);
		int result = 0;
		
		try {
			result = qnaDao.updateQna(session, qna);
						
			// commit or rollback
			if (result > 0) session.commit();
			else session.rollback();
			
		} catch (Exception e) {
			e.printStackTrace();
			session.rollback();
		}  finally {
			session.close();
		}
		
		return result;
	}
	
	public int updateQnaNewAttach(Qna qna, Attach attach) {
		SqlSession session = SqlSessionTemplate.getSqlSession(false);
		
		int result = 0;
		
		try {
			result = qnaDao.updateQna(session, qna);
			
			if (attach != null && result > 0) {
				result = qnaDao.insertAttach(session, attach);
			}
						
			// commit or rollback
			if (result > 0) session.commit();
			else session.rollback();
			
		} catch (Exception e) {
			e.printStackTrace();
			session.rollback();
		}  finally {
			session.close();
		}
		
		return result;
	}
}
