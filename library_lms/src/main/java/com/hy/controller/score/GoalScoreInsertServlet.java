package com.hy.controller.score;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.BufferedReader;
import java.io.IOException;
import java.util.stream.Collectors;

import org.apache.ibatis.session.SqlSession;

import com.google.gson.Gson;
import com.hy.controller.tablet.MybatisUtil;
import com.hy.dto.score.GoalScore;
import com.hy.dto.score.GoalScoreRequest;
import com.hy.mapper.score.ScoreMapper;
import com.hy.mapper.score.SubjectMapper;
import com.hy.service.score.GoalScoreService;


@WebServlet("/goal_score/insert")
public class GoalScoreInsertServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public GoalScoreInsertServlet() {
        super();
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}
	
	
	 @Override
	    protected void doPost(HttpServletRequest request, HttpServletResponse response)
	            throws ServletException, IOException {

	        request.setCharacterEncoding("UTF-8");
	        response.setContentType("application/json; charset=UTF-8");

	        boolean allSuccess = true;
	        SqlSession session = MybatisUtil.getSqlSession(); // ⭐ 트랜잭션 단위 유지

	        try {
	            BufferedReader reader = request.getReader();
	            String json = reader.lines().collect(Collectors.joining());
	            GoalScoreRequest reqDto = new Gson().fromJson(json, GoalScoreRequest.class);

	            SubjectMapper subjectMapper = session.getMapper(SubjectMapper.class);
	            ScoreMapper scoreMapper = session.getMapper(ScoreMapper.class); // Service 대신 직접 사용

	            for (GoalScore dto : reqDto.getSubjectScores()) {
	                Integer subjectId = subjectMapper.selectSubjectIdByName(dto.getSubjectName());
	                if (subjectId == null) {
	                    allSuccess = false;
	                    break;
	                }

	                dto.setSubjectId(subjectId);
	                dto.setMemberNo(reqDto.getMemberNo());
	                dto.setExamTypeId(reqDto.getExamTypeId());

	                int result = scoreMapper.insertGoalScore(dto);
	                if (result <= 0) {
	                    allSuccess = false;
	                    break;
	                }
	            }

	            if (allSuccess) session.commit();
	            else session.rollback();

	        } catch (Exception e) {
	            e.printStackTrace();
	            allSuccess = false;
	            session.rollback();
	        } finally {
	            session.close();
	        }

	        response.getWriter().write("{\"success\": " + allSuccess + "}");
	    }
	    ✅ 결론
}
}
}


	