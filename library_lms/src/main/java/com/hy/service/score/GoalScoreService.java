package com.hy.service.score;

import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.hy.common.sql.SqlSessionTemplate;
import com.hy.dao.score.GoalScoreDAO;
import com.hy.dto.score.ExamType;
import com.hy.dto.score.GoalScore;

public class GoalScoreService {

    private final GoalScoreDAO dao = new GoalScoreDAO();

    // 시험 유형 매핑을 별도 메서드로 분리
    private int mapExamTypeId(int examTypeId, int grade) {
        if (grade == 1) {
            switch (examTypeId) {
                case 3: return 1;
                case 6: return 2;
                case 9: return 3;
            }
        } else if (grade == 2) {
            switch (examTypeId) {
                case 3: return 4;
                case 6: return 5;
                case 9: return 6;
            }
        } else {
            switch (examTypeId) {
                case 3: return 7;
                case 6: return 8;
                case 9: return 9;
                case 11: return 10;
            }
        }
        return examTypeId; // 매핑에 없으면 그대로 반환
    }
    
    // 시험 분류 학년별 조회 메서드
    public List<ExamType> getExamTypesByGrade(int grade) {
        SqlSession session = null;
        try {
            session = SqlSessionTemplate.getSqlSession(true);
            return dao.selectExamTypesByGrade(session, grade);
        } catch (Exception e) {
            e.printStackTrace();
            return Collections.emptyList();
        } finally {
            if (session != null) session.close();
        }
    }

    // 목표 성적 insert (여러 과목)
    public boolean insertGoalScores(List<GoalScore> dtos) {
        SqlSession session = null;
        boolean allSuccess = true;

        try {
            session = SqlSessionTemplate.getSqlSession(false); // 수동 커밋
            for (GoalScore dto : dtos) {
                int mappedExamTypeId = mapExamTypeId(dto.getExamTypeId(), dto.getGrade());
                dto.setExamTypeId(mappedExamTypeId);

                int result = dao.insertGoalScore(session, dto);
                if (result <= 0) {
                    allSuccess = false;
                    break;
                }
            }

            if (allSuccess) {
                session.commit();
            } else {
                session.rollback();
            }

        } catch (Exception e) {
            if (session != null) session.rollback();
            e.printStackTrace();
            allSuccess = false;
        } finally {
            if (session != null) session.close();
        }

        return allSuccess;
    }

    // 목표 성적 조회
    public List<GoalScore> selectGoalScoresByMemberAndExam(int memberNo, int examTypeId) {
        SqlSession session = null;
        try {
            session = SqlSessionTemplate.getSqlSession(true);
            return dao.selectGoalScoresByMemberAndExam
            		(session, memberNo, examTypeId);
        } catch (Exception e) {
            e.printStackTrace();
            return Collections.emptyList();
        } finally {
            if (session != null) session.close();
        }
    }

    // 목표 성적 입력된 시험 분류 ID 목록 조회
    public List<Integer> selectAvailableExamTypeIds(int memberNo) {
        SqlSession session = null;
        try {
            session = SqlSessionTemplate.getSqlSession(true);
            return dao.selectAvailableExamTypeIds(session, memberNo);
        } catch (Exception e) {
            e.printStackTrace();
            return Collections.emptyList();
        } finally {
            if (session != null) session.close();
        }
    }

    // 기존 점수 삭제
    public int deleteScoresByMemberAndExam(int memberNo, int examTypeId) {
    	Map<String, Integer> param = Map.of("memberNo", memberNo, "examTypeId", examTypeId);
    	return dao.deleteGoalScoresByMemberAndExam(param);
    }

    



	 
}