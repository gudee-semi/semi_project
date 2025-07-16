package com.hy.mapper.score;

import java.util.List;
import java.util.Map;

public interface SubjectMapper {
	
	 // 과목명으로 subject_id 조회
    Integer selectSubjectIdByName(String subjectName);
    
    List<String> selectSubjectNamesByMemberAndExam(Map<String, Integer> param);
}
