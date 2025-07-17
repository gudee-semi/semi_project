package com.hy.mapper.score;

import java.util.List;
import java.util.Map;

import com.hy.dto.score.ActualScore;
import com.hy.dto.score.GoalScore;

public interface GoalScoreMapper {

	// 개별 목표 점수 저장
    int insertGoalScore(GoalScore dto);

    // memberNo + examTypeId 중복 여부 확인
    int countGoalScoreByMemberAndExamType(Map<String, Integer> param);

    // 시험별 저장 점수 조회 (memberNo + examTypeId)
    List<GoalScore> selectGoalScoresByMemberAndExam(Map<String, Integer> param);

    // 목표 성적이 존재하는 시험 ID 목록 조회 (memberNo)
    List<Integer> selectAvailableExamTypeIds(int memberNo);

    // 기존 목표 성적 삭제 (memberNo + examTypeId)
    int deleteGoalScoresByMemberAndExam(Map<String, Integer> param);

    // examTypeId 매핑 (examMonth + memberGrade → exam_type_id)
    int getExamTypeId(Map<String, Integer> param);
    
    

}
