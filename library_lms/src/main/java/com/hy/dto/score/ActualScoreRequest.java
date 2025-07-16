package com.hy.dto.score;

import java.util.List;

public class ActualScoreRequest {

	  private int examTypeId;
	    private List<ActualScore> subjectScores;

	    // 기본 생성자, getter, setter
	    public ActualScoreRequest() {}

	    public int getExamTypeId() { return examTypeId; }
	    public void setExamTypeId(int examTypeId) { this.examTypeId = examTypeId; }

	    public List<ActualScore> getSubjectScores() { return subjectScores; }
	    public void setSubjectScores(List<ActualScore> subjectScores) { this.subjectScores = subjectScores; }
	}