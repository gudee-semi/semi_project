package com.hy.dao.score;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.hy.common.sql.SqlSessionTemplate;
import com.hy.dto.score.ExamType;
import com.hy.dto.score.GoalScore;
import com.hy.mapper.score.GoalScoreMapper; // ✅ 반드시 필요한 import

public class GoalScoreDAO {
    
    // 1. INSERT - 목표 성적 저장
    public int insertGoalScore(SqlSession session, GoalScore dto) {
        return session.insert("com.hy.mapper.score.GoalScoreMapper.insertGoalScore", dto);
    }

    // 시험 분류 학년별 조회
    public List<ExamType> selectExamTypesByGrade(SqlSession session, int memberGrade) {
        return session.selectList("com.hy.mapper.score.GoalScoreMapper.selectExamTypesByGrade", memberGrade);
    }

    // ✅ memberNo + examTypeId 중복 존재 여부 확인
    public int countByMemberAndExamType(SqlSession session, int memberNo, int examTypeId) {
        Map<String, Integer> param = new HashMap<>();
        param.put("memberNo", memberNo);
        param.put("examTypeId", examTypeId);
        return session.getMapper(GoalScoreMapper.class)
                      .countGoalScoreByMemberAndExamType(param);
    }
    
//    // 시험월(examType) + 학년으로 exam_type_id 조회
//    public int getExamTypeId(SqlSession session, int examType, int memberGrade) {
//        Map<String, Integer> param = new HashMap<>();
//        param.put("examType", examType);
//        param.put("memberGrade", memberGrade);
//        return session.selectOne("com.hy.mapper.score.GoalScoreMapper.getExamTypeId", param);
//    }


    // memberNo와 examTypeId로 목표 성적 조회
    public List<GoalScore> selectGoalScoresByMemberAndExam(SqlSession session, int memberNo, int examTypeId) {
        return session.selectList("com.hy.mapper.score.GoalScoreMapper.selectGoalScoresByMemberAndExam", 
            Map.of("memberNo", memberNo, "examTypeId", examTypeId));
    }

    // 입력된 목표 성적이 있는 시험 목록 반환
    public List<Integer> selectAvailableExamTypeIds(SqlSession session, int memberNo) {
        return session.selectList("com.hy.mapper.score.GoalScoreMapper.selectAvailableExamTypeIds", memberNo);
    }

    // 기존 목표 성적 삭제
    public int deleteGoalScoresByMemberAndExam(Map<String, Integer> param) {
        SqlSession session = SqlSessionTemplate.getSqlSession(true);
        return session.delete("com.hy.mapper.score.GoalScoreMapper.deleteGoalScoresByMemberAndExam", param);
    }
}
