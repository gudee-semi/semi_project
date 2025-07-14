package com.hy.dao.score;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.hy.dto.score.GoalScore;

public class GoalScoreDAO {
	 // 1. INSERT - 목표 성적 저장
    public int insertGoalScore(SqlSession session, GoalScore dto) {
        return session.insert("goalScoreMapper.insertGoalScore", dto); 
        // → 실제 goalScoreMapper.xml에 <insert id="insertGoalScore">가 있어야 함
    }

    // 2. SELECT - 로그인된 회원의 모든 목표 성적 불러오기
    public List<GoalScore> selectGoalScoresByMember(SqlSession session, int memberNo) {
        return session.selectList("goalScoreMapper.selectGoalScoresByMember", memberNo);
        // → 실제 goalScoreMapper.xml에 <select id="selectGoalScoresByMember">가 있어야 함
    }

}
