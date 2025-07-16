package com.hy.mapper.score;

import java.util.List;
import java.util.Map;

import com.hy.dto.score.ActualScore;

public interface ActualScoreMapper {
	
	 // 개별 실제 점수 저장
    int insertActualScore(ActualScore dto);

    // 시험별 저장 점수 조회 (param1 = memberNo, param2 = examTypeId)
    List<ActualScore> selectActualScoresByMemberAndExam(Map<String, Integer> param);

    // 입력된 실제 성적이 있는 시험 목록 조회 (param1 = memberNo)
    List<Integer> selectAvailableExamTypeIds(int memberNo);

    // 기존 실제 성적 삭제 (param1 = memberNo, param2 = examTypeId)
    int deleteActualScoresByMemberAndExam(Map<String, Integer> param);


}
