package com.hy.mapper.score;

import java.util.List;

import com.hy.dto.score.GoalScore;

public interface ScoreMapper {

	// 1. 과목별 목표점수 삽입
    int insertGoalScore(GoalScore dto);

    // 2. 과목별 목표점수 전체 삭제(갱신할 때)
    int deleteGoalScoresByMemberAndExam(int memberNo, int examTypeId);

    // 3. 특정 회원+시험분류별 점수 조회
    List<GoalScore> selectGoalScoresByMemberAndExam(int memberNo, int examTypeId);

   
}
