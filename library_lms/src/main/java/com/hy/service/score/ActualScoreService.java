package com.hy.service.score;

import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.hy.common.sql.SqlSessionTemplate;
import com.hy.dao.score.ActualScoreDAO;
import com.hy.dto.score.ActualScore;
import com.hy.dto.score.ExamType;

public class ActualScoreService {
	
	private final ActualScoreDAO dao = new ActualScoreDAO();
	
	//시험월과 학년을 조합하여 실제 exam_type_id로 매핑
	// (예: 3월 + 1학년 → ID 1, 6월 + 3학년 → ID 8, 11월 수능 + 3학년 → ID 10) 
    public int mapExamTypeId(int examTypeId, int grade) {
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
        return examTypeId; // 예외 처리: 매핑 실패 시 그대로 반환
    }
	
	

    // 학년에 따라 사용 가능한 시험 분류 목록 조회
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
    
    
    // 실제 성적 등록 (여러 과목에 대해 한 번에 입력)
    // @return 모두 성공 시 true, 실패 시 false
    public boolean insertActualScores(List<ActualScore> dtos) {
        SqlSession session = null;
        boolean allSuccess = true;

        try {
            session = SqlSessionTemplate.getSqlSession(false); // 수동 commit

            for (ActualScore dto : dtos) {
                // 시험 분류 ID를 학년 기준으로 매핑
                int mappedExamTypeId = mapExamTypeId(dto.getExamTypeId(), dto.getGrade());
                dto.setExamTypeId(mappedExamTypeId);

                int result = dao.insertActualScore(session, dto);
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
    

    // 실제 성적 조회 (사용자 + 시험분류 기준)
    public List<ActualScore> selectActualScoresByMemberAndExam(int memberNo, int examTypeId) {
        SqlSession session = null;
        try {
            session = SqlSessionTemplate.getSqlSession(true);
            return dao.selectActualScoresByMemberAndExam(session, memberNo, examTypeId);
        } catch (Exception e) {
            e.printStackTrace();
            return Collections.emptyList();
        } finally {
            if (session != null) session.close();
        }
    }
    
    // 입력된 실제 성적이 있는 시험 목록 조회
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

    // 실제 성적 삭제 (회원 + 시험 기준)
    public int deleteActualScoresByMemberAndExam(int memberNo, int examTypeId) {
        SqlSession session = null;
        try {
            session = SqlSessionTemplate.getSqlSession(true);
            Map<String, Integer> param = new HashMap<>();
            param.put("memberNo", memberNo);
            param.put("examTypeId", examTypeId);
            return dao.deleteActualScoresByMemberAndExam(session, param);
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        } finally {
            if (session != null) session.close();
        }
    }


}
    
    
