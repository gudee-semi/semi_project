package com.hy.mapper.score;

public interface SubjectMapper {
	 // 과목명으로 subject_id 조회
    Integer selectSubjectIdByName(String subjectName);
}
