package com.hy.dto.score;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor

//한 학생, 한 시험에 대한 세부목표 한 줄 저장 및 조회용

public class MemberGoalDetail {
	private int memberGoalDetailId; // (PK, AUTO_INCREMENT, 보통 INSERT 때는 생략 가능)
    private int memberNo;           // 회원번호
    private int examTypeId;         // 시험 분류(3월, 6월, 9월, 11월 등)
    private String goalDetail;      // 세부목표(50자 이상)

}
