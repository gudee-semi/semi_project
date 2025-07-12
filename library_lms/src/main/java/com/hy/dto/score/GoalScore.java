package com.hy.dto.score;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor

// 여러 과목별 점수 저장 및 조회

public class GoalScore {
	private int memberNo;  // 로그인된 사용자 번호
	private int examTypeId;  // 시험 종류 ID(3월, 6월, 9월, 11월(수능))
	private int subjectId;  // 과목 ID
	private int targetScore;  // 목표 원점수
	private int targetLevel;  // 목표 등급(1~9 등급)

}
