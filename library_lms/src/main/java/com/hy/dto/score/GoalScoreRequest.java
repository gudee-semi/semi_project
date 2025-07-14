package com.hy.dto.score;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor

//여러 과목 점수 + 세부목표를 한 번에 전달하기 위한 DTO
//실제로 프론트엔드에서 "저장" 누를 때 한 번에 POST로 넘길 때 사용

public class GoalScoreRequest {
	private int memberNo;
    private int examTypeId;
    private String goalDetail;
    private List<GoalScore> subjectScores; // 여러 과목 점수들

}
