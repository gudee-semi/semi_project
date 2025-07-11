package com.hy.dao.score;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import org.apache.ibatis.session.SqlSession;

import com.hy.dto.score.GoalScore;

public class GoalScoreDAO {
	public int insertGoalScore(SqlSession session, GoalScore dto) {
        return session.insert("goalScoreMapper.insertGoalScore", dto); 
        // 위에 매퍼 이름과 id는 실제 XML에 맞게 수정
    }

}
