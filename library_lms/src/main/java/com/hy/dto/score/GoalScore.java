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
	private int subjectId;  // 과목 ID (DB 저장용)
	private String subjectName; // 과목명 (프론트에서 보내는 값 → 서버에서 매핑)
	private Integer targetScore;   // null 허용 (입력 안 할 수도 있으니까)
	private Integer targetLevel;   // null 허용 (입력 안 할 수도 있음)
	
	private int grade;  // 학년
	private int examType; 
	

}
