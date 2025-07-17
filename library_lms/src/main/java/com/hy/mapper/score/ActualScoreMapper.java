package com.hy.mapper.score;

import java.util.List;
import java.util.Map;

import com.hy.dto.score.ActualScore;
import com.hy.dto.score.ScoreCompare;

public interface ActualScoreMapper {
	
	 // 개별 실제 점수 저장
    int insertActualScore(ActualScore dto);

    // memberNo + examTypeId 중복 여부 확인
    int countActualScoreByMemberAndExamType(Map<String, Integer> param);

    // 시험별 저장 점수 조회 (memberNo + examTypeId)
    // 실제 점수 조회
    List<ActualScore> selectActualScoresByMemberAndExam(Map<String, Integer> param);

    // 실제 성적이 존재하는 시험 ID 목록 조회 (memberNo)
    List<Integer> selectAvailableExamTypeIds(int memberNo);

    // 기존 실제 성적 삭제 (memberNo + examTypeId)
    int deleteActualScoresByMemberAndExam(Map<String, Integer> param);

    // examTypeId 매핑 (examMonth + memberGrade → exam_type_id)
    int getExamTypeId(Map<String, Integer> param);
    
    // 성적 분석을 위한 차트에서 점수 비교
    List<ScoreCompare> selectGoalAndActualScores(Map<String, Integer> param);


}
