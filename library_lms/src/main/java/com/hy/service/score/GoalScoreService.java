package com.hy.service.score;

import java.sql.Connection;

import org.apache.ibatis.session.SqlSession;

import com.hy.common.sql.SqlSessionTemplate;
import com.hy.dao.score.GoalScoreDAO;
import com.hy.dto.score.GoalScore;

public class GoalScoreService {

	 private GoalScoreDAO dao = new GoalScoreDAO();

	    public boolean insertGoalScore(GoalScore dto) {
	        boolean result = false;

	        // MyBatis 세션 가져오기
	        try (SqlSession session = SqlSessionTemplate.getSqlSession(true)) { // autoCommit = true
	            int row = dao.insertGoalScore(session, dto);
	            if (row > 0) result = true;
	        } catch (Exception e) {
	            e.printStackTrace();
	        }

	        return result;
	    }
}
