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
	    SqlSession session = MybatisUtil.getSqlSession(); // ⭐ 트랜잭션 유지

	    try {
	        BufferedReader reader = request.getReader();
	        String json = reader.lines().collect(Collectors.joining());
	        GoalScoreRequest reqDto = new Gson().fromJson(json, GoalScoreRequest.class);

	        SubjectMapper subjectMapper = session.getMapper(SubjectMapper.class);
	        ScoreMapper scoreMapper = session.getMapper(ScoreMapper.class);

	        for (GoalScore dto : reqDto.getSubjectScores()) {

	            // 🔽 과목명 전처리 및 로깅
	            String subjectName = dto.getSubjectName() != null ? dto.getSubjectName().trim() : "";
	            System.out.println("과목명 (전처리 후): " + subjectName);

	            Integer subjectId = subjectMapper.selectSubjectIdByName(subjectName);
	            System.out.println("매핑된 subject_id: " + subjectId);
	            
	            System.out.println("target score :"+dto.getTargetScore());
	            
	            System.out.println("과목명: " + subjectName);
	            System.out.println("subjectId: " + subjectId);
	            System.out.println("memberNo: " + reqDto.getMemberNo());
	            System.out.println("examTypeId: " + reqDto.getExamTypeId());
	            System.out.println("targetScore: " + dto.getTargetScore());

	            

	            if (subjectId == null) {
	                allSuccess = false;
	                break;
	            }

	            dto.setSubjectId(subjectId);
	            dto.setMemberNo(reqDto.getMemberNo());
	            dto.setExamTypeId(reqDto.getExamTypeId());
	            
	            int grade = 3;
	            dto.setGrade(grade);
	            
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

	           
	            int result = scoreMapper.insertGoalScore(dto);
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
	        e.printStackTrace();
	        allSuccess = false;
	        session.rollback();
	    } finally {
	        session.close();
	    }

	    response.getWriter().write("{\"success\": " + allSuccess + "}");
	}
}



	