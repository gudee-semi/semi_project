package com.hy.mapper.score;

import java.util.List;
import com.hy.dto.score.GoalScore;

public interface ScoreMapper {

    // 개별 점수 저장
    int insertGoalScore(GoalScore dto);

    // 시험별 저장 점수 조회 (memberNo = param1, examTypeId = param2)
    List<GoalScore> selectGoalScoresByMemberAndExam(int memberNo, int examTypeId);

    // 해당 시험과 사용자에 입력된 목표 성적 개수
    int countGoalScoreByMemberAndExam(int memberNo, int examTypeId);

    // 목표 성적 조회
    List<GoalScore> selectGoalScores(int memberNo, int examTypeId);

    // 입력된 목표 성적이 있는 시험 목록 조회 (이 경우 param1 = memberNo)
    List<Integer> selectAvailableExamTypeIds(int memberNo);

    // 기존 목표 성적 삭제
    int deleteGoalScoresByMemberAndExam(int memberNo, int examTypeId);
}
