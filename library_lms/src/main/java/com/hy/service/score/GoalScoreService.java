package com.hy.service.score;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.hy.common.sql.SqlSessionTemplate;
import com.hy.dao.score.GoalScoreDAO;
import com.hy.dto.score.GoalScore;

public class GoalScoreService {

    private GoalScoreDAO dao = new GoalScoreDAO();

    // 목표 성적 insert
    public boolean insertGoalScore(GoalScore dto) {
        boolean result = false;

        try (SqlSession session = SqlSessionTemplate.getSqlSession(true)) {
            int row = dao.insertGoalScore(session, dto);
            if (row > 0) result = true;
        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }

    // 특정 회원의 목표 성적 조회
    public List<GoalScore> getGoalScoresByMember(int memberNo) {
        List<GoalScore> result = null;
        try (SqlSession session = SqlSessionTemplate.getSqlSession(true)) {
            result = dao.selectGoalScoresByMember(session, memberNo);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }
}
