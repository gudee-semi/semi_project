package com.hy.dto.score;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor

public class ActualScore {
	
	private int actualScoreId;           // PK
    private int memberNo;                // 회원번호
    private int examTypeId;              // 시험분류(3,6,9,11 등)
    private int subjectId;               // 과목 ID
    private Integer grade;               // 학년

    private Integer actualScore;         // 실제 원점수
    private Integer actualLevel;         // 등급(1~9)
    private Double actualPercentage;     // 백분위(0~100), null 허용
    private String actualRank;           // 석차 ("1/250" 등), null 허용

    // 표시용 필드(조회시만 사용)
    private String subjectName;          // 과목명(조회시)
    private String examTypeName;         // 시험명(조회시)

}
