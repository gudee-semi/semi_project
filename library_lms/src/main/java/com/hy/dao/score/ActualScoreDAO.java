package com.hy.dao.score;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.hy.common.sql.SqlSessionTemplate;
import com.hy.dto.score.ActualScore;
import com.hy.dto.score.ExamType;
import com.hy.mapper.score.ActualScoreMapper;

public class ActualScoreDAO {
	
	// 1. INSERT - 실제 성적 저장
	 public int insertActualScore(SqlSession session, ActualScore dto) {
	        return session.insert("com.hy.mapper.score.ActualScoreMapper.insertActualScore", dto);
	 }
	 
	 // 시험 분류 학년별 조회
	    public List<ExamType> selectExamTypesByGrade(SqlSession session, int memberGrade) {
	        return session.selectList("com.hy.mapper.score.ActualScoreMapper.selectExamTypesByGrade", memberGrade);
	    }
	    
	    
	 // ✅ memberNo + examTypeId 중복 존재 여부 확인
	    public int countByMemberAndExamType(SqlSession session, int memberNo, int examTypeId) {
	        Map<String, Integer> param = new HashMap<>();
	        param.put("memberNo", memberNo);
	        param.put("examTypeId", examTypeId);
	        return session.getMapper(ActualScoreMapper.class)
	                      .countActualScoreByMemberAndExamType(param);
	    }
	    
	    // memberNo와 examTypeId로 목표 성적 조회
	    public List<ActualScore> selectActualScoresByMemberAndExam(SqlSession session, int memberNo, int examTypeId) {
	        return session.selectList("com.hy.mapper.score.ActualScoreMapper.selectActualScoresByMemberAndExam", 
	            Map.of("memberNo", memberNo, "examTypeId", examTypeId));
	    }

	    // 입력된 목표 성적이 있는 시험 목록 반환
	    public List<Integer> selectAvailableExamTypeIds(SqlSession session, int memberNo) {
	        return session.selectList("com.hy.mapper.score.ActualScoreMapper.selectAvailableExamTypeIds", memberNo);
	    }

	    // 기존 목표 성적 삭제
	    public int deleteActualScoresByMemberAndExam(Map<String, Integer> param) {
	        SqlSession session = SqlSessionTemplate.getSqlSession(true);
	        return session.delete("com.hy.mapper.score.ActualScoreMapper.deleteActualScoresByMemberAndExam", param);
	    }
	    
	 

}
