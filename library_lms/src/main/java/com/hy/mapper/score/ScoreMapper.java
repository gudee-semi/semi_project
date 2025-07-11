package com.hy.mapper.score;

import java.util.List;

import com.hy.dto.score.GoalScore;

public interface ScoreMapper {

	 // 목표 성적 삽입
    int insertGoalScore(GoalScore dto);

    // 특정 회원의 목표 성적 목록 조회
    List<GoalScore> selectGoalScoresByMember(int memberNo);
}
