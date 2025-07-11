package com.hy.dto.score;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor

public class GoalScore {
	private int memberNo;
	private int examTypeId;
	private int subjectId;
	private int targetScore;
	private int targetLevel;

}
