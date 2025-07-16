package com.hy.dao.score;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.hy.dto.score.ActualScore;
import com.hy.dto.score.ExamType;

public class ActualScoreDAO {
	
	// 1. INSERT - 실제 성적 저장
	 public int insertActualScore(SqlSession session, ActualScore dto) {
	        return session.insert("com.hy.mapper.score.ActualScoreMapper.insertActualScore", dto);
	 }
	 
	 // 여러 과목에 대한 실제 성적을 DB에 저장
	 // 내부적으로 insertActualScore() 메서드를 반복 호출하여 저장
	 // 총 성공한 입력 건수를 반환
	 public int insertActualScores(SqlSession session, List<ActualScore> list) {
	        int cnt = 0;
	        for (ActualScore dto : list) {
	            cnt += insertActualScore(session, dto);
	        }
	        return cnt;
	    }
	
	 // 학년별 시험 분류 조회
	 public List<ExamType> selectExamTypesByGrade(SqlSession session, int grade) {
		    return session.selectList("com.hy.mapper.score.ActualScoreMapper.selectExamTypesByGrade", grade);
		}

	 // 사용자 + 시험분류 기준 실제 성적 조회
	 public List<ActualScore> selectActualScoresByMemberAndExam(SqlSession session, int memberNo, int examTypeId) {
	        // mapper에서 parameterType="map"이므로 Map 사용
	        Map<String, Integer> param = Map.of("memberNo", memberNo, "examTypeId", examTypeId);
	        return session.selectList("com.hy.mapper.score.ActualScoreMapper.selectActualScoresByMemberAndExam", param);
	    }
	 
	 public List<Integer> selectAvailableExamTypeIds(SqlSession session, int memberNo) {
			return session.selectList("com.hy.mapper.score.ActualScoreMapper.selectAvailableExamTypeIds", memberNo);
		}

	 
	 // 사용자 + 시험 분류 기준 실제 성적 삭제
	 public int deleteActualScoresByMemberAndExam(SqlSession session, Map<String, Integer> param) {
	        return session.delete("com.hy.mapper.score.ActualScoreMapper.deleteActualScoresByMemberAndExam", param);
	    }

}
