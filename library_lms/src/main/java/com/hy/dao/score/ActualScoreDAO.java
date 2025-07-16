package com.hy.dao.score;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.hy.dto.score.ActualScore;
import com.hy.dto.score.ExamType;

public class ActualScoreDAO {
	// 1. INSERT - 실제 성적 저장
	 public int insertActualScore(SqlSession session, ActualScore dto) {
	        return session.insert("com.hy.mapper.score.ScoreMapper.insertActualScore", dto);
	 }
	 
	 
	 public int insertActualScores(SqlSession session, List<ActualScore> list) {
	        int cnt = 0;
	        for (ActualScore dto : list) {
	            cnt += insertActualScore(session, dto);
	        }
	        return cnt;
	    }
	
	 
	 public List<ExamType> selectExamTypesByGrade(SqlSession session, int grade) {
		    return session.selectList("com.hy.mapper.score.ExamTypeMapper.selectExamTypesByGrade", grade);
		}


}
