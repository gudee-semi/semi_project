package com.hy.service.score;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.hy.common.sql.SqlSessionTemplate;
import com.hy.controller.tablet.MybatisUtil;
import com.hy.dao.score.GoalScoreDAO;
import com.hy.dto.score.GoalScore;
import com.hy.mapper.score.ScoreMapper;

public class GoalScoreService {

    private GoalScoreDAO dao = new GoalScoreDAO();

    // 목표 성적 insert
    public boolean insertGoalScore(GoalScore dto) {
        try {
            ScoreMapper mapper = MybatisUtil.getSqlSession().getMapper(ScoreMapper.class);
            int temp = dto.getExamTypeId();
            if (dto.getGrade() == 1) {
            	if(temp == 3) dto.setExamTypeId(1);
            	else if(temp == 6) dto.setExamTypeId(2);
            	else if(temp == 9) dto.setExamTypeId(3);
            } else if (dto.getGrade() == 2) {
            	if(temp == 3) dto.setExamTypeId(4);
            	else if(temp == 6) dto.setExamTypeId(5);
            	else if(temp == 9) dto.setExamTypeId(6);
            } else {
            	if(temp == 3) dto.setExamTypeId(7);
            	else if(temp == 6) dto.setExamTypeId(8);
            	else if(temp == 9) dto.setExamTypeId(9);
            	else if(temp == 11) dto.setExamTypeId(10);
            }
            int result = mapper.insertGoalScore(dto);
            return result > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

 // 기존 점수 삭제 (선택적 갱신 시 사용 가능)
    public boolean deleteScoresByMemberAndExam(int memberNo, int examTypeId) {
        try {
            ScoreMapper mapper = MybatisUtil.getSqlSession().getMapper(ScoreMapper.class);
            int result = mapper.deleteGoalScoresByMemberAndExam(memberNo, examTypeId);
            return result >= 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
