package com.hy.mapper.score;

import java.util.List;
import java.util.Map;

import com.hy.dto.score.GoalScore;

public interface ScoreMapper {

	 // 개별 점수 저장
    int insertGoalScore(GoalScore dto);

    // 시험별 저장 점수 조회 (param1 = memberNo, param2 = examTypeId)
    List<GoalScore> selectGoalScoresByMemberAndExam(int memberNo, int examTypeId);

    // 입력된 목표 성적이 있는 시험 목록 조회 (param1 = memberNo)
    List<Integer> selectAvailableExamTypeIds(int memberNo);

    // 기존 목표 성적 삭제 (param1 = memberNo, param2 = examTypeId)
    int deleteGoalScoresByMemberAndExam(Map<String, Integer> param);

}
