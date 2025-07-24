package com.hy.dao.qna;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.hy.common.sql.SqlSessionTemplate;
import com.hy.common.vo.Paging;
import com.hy.controller.tablet.MyBatisUtil;
import com.hy.dto.qna.Attach;
import com.hy.dto.qna.Qna;
import com.hy.dto.qna.QnaReply;

public class QnaListAdminDao {

	SqlSession session;

	// 전체 목록 조회
	public List<QnaReply> selectAll(String category, String keyword, String searchType) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		// 2. 파라미터를 Map으로 묶어서 전달
		Map<String, Object> param = new HashMap<>();
		param.put("category", category);
		param.put("keyword", keyword);
		param.put("searchType", searchType);
		List<QnaReply> list = session.selectList("com.hy.mapper.qna.QnaAdminMapper.selectAll", param);
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

	// 답글 단일 조회
	public QnaReply selectReplyOne(int qnaReplyId) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		QnaReply reply = session.selectOne("com.hy.mapper.qna.QnaAdminMapper.selectReplyOne", qnaReplyId);
		session.close();
		return reply;
	}

	// 답글 추가 + answerStatus 1 업데이트 같이 하기
	public void insertReplyAndUpdateStatus(QnaReply reply) {
		// SqlSession 생성 (autoCommit = false: 직접 커밋)
		SqlSession session = SqlSessionTemplate.getSqlSession(false); // 트랜잭션 관리 직접
		try {
			// 답글 등록
			session.insert("com.hy.mapper.qna.QnaAdminMapper.insertReply", reply);

			// answerStatus = 1로 업데이트
			session.update("com.hy.mapper.qna.QnaAdminMapper.updateAnswerStatusOne", reply.getQnaId());

			// QnA.answer_status = 1로 업데이트
			session.update("com.hy.mapper.qna.QnaAdminMapper.updateAnswerStatusOne", reply.getQnaId());

			// 커밋
			session.commit();
		} catch (Exception e) {
			// 예외시 롤백
			session.rollback();
			throw e;
		} finally {
			// 세션 닫기
			session.close();
		}
	}

	// 답글 수정
	public int updateReply(QnaReply reply) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		int result = session.update("com.hy.mapper.qna.QnaAdminMapper.updateReply", reply);
		session.close();
		return result;
	}

	// 답글 삭제 + answer_status 0 업데이트 같이 하기
	public void deleteReplyAndUpdateStatus(int qnaReplyId, int qnaId) {
		SqlSession session = SqlSessionTemplate.getSqlSession(false); // autoCommit=false

		try {
			// 답글 삭제
			session.delete("com.hy.mapper.qna.QnaAdminMapper.deleteReply", qnaReplyId);

			// answer_status를 0으로 변경
			session.update("com.hy.mapper.qna.QnaAdminMapper.updateAnswerStatusZero", qnaId);

			// 커밋
			session.commit();
		} catch (Exception e) {
			// 예외시 롤백
			session.rollback();
			throw e;
		} finally {
			// 세션 닫기
			session.close();
		}
	}

	// 페널티 증가
	public int updatePenalty(int memberNo) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		int result = session.update("com.hy.mapper.tablet.TabletMapper.updatePenalty", memberNo);
		session.close();
		return result;
	}

	// 조회수 증가
	public void incrementViewCount(int qnaNo) {
		SqlSession session = MyBatisUtil.getSqlSession(true);
		session.update("com.hy.mapper.qna.QnaAdminMapper.incrementViewCount", qnaNo);
		session.close();
	}

	// 페이징
	public List<Qna> selectQnaListPaging(Paging paging, String category, String searchType, String keyword) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);

		Map<String, Object> param = new HashMap<>();
		param.put("limitPageNo", paging.getLimitPageNo());
		param.put("numPerPage", paging.getNumPerPage());
		param.put("category", category);
		param.put("searchType", searchType);
		param.put("keyword", keyword);

		List<Qna> list = session.selectList("com.hy.mapper.qna.QnaAdminMapper.selectQnaListPaging", param);
		session.close();
		return list;
	}

	// 전체 문의글 개수 세기
	public int countQna(String category, String searchType, String keyword) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);

		Map<String, Object> param = new HashMap<>();
		param.put("category", category);
		param.put("searchType", searchType);
		param.put("keyword", keyword);

		int cnt = session.selectOne("com.hy.mapper.qna.QnaAdminMapper.countQna", param); // 변수에 담아야 함!
		session.close();
		return cnt;
	}

	// 첨부파일
	public Attach selectAttachByQnaId(int qnaId) {
		// 1. SqlSession 열기
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		Attach attach = null;
		try {
			// 2. selectOne 실행
			attach = session.selectOne("com.hy.mapper.qna.QnaAdminMapper.selectByQnaId", qnaId);
		} finally {
			// 3. 세션 닫기 (메모리/DB 커넥션 누수 방지)
			session.close();
		}
		// 4. Attach 반환
		return attach;
	}
}