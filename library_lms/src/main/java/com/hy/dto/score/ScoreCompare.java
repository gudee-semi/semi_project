package com.hy.dto.score;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter

// 조회 결과를 담음
// 차트 생성을 위함
public class ScoreCompare {
	private String subjectName;
	private int goalScore;
	private int actualScore;

}
