package com.hy.dao.qna;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.hy.common.sql.SqlSessionTemplate;
import com.hy.dto.qna.QnaAdmin;

public class QnaAdminDao {
	
	// 전체 목록 조회
	public List<QnaAdmin> selectAll() {
		
		// MyBatis의 SqlSession을 생성(true: autoCommit 설정)
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		
		// Mapper의 selectAll 쿼리를 실행하여 결과를 List<QnaAdmin>로 받음
		List<QnaAdmin> list = session.selectList("com.hy.mapper.qna.QnaAdminMapper.selectAll");
	
		// SqlSession을 반드시 닫아줌 (DB 연결 해제)
		session.close();
		
		// 조회 결과(태블릿 목록) 반환
		return list;
	}

}
