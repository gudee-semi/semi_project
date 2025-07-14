package com.hy.mapper.score;

import java.util.List;

import com.hy.dto.score.GoalScore;

public interface ScoreMapper {

	 // 개별 점수 저장
    int insertGoalScore(GoalScore dto);

    // 시험별 저장 점수 조회
    List<GoalScore> selectGoalScoresByMemberAndExam(int memberNo, int examTypeId);

    // 기존 점수 삭제 (시험별 갱신 시)
    int deleteGoalScoresByMemberAndExam(int memberNo, int examTypeId);
    
}