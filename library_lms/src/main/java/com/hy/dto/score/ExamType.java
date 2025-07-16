package com.hy.dto.score;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

// 시험 분류(ExamType) DTO
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor

public class ExamType {
    private int examTypeId;   // exam_type_id (시험 분류 고유 ID)
    private int memberGrade;  // member_grade (대상 학년)
    private int examType;     // exam_type (시험 월: 3,6,9,11)
}
