package com.hy.controller.score;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.BufferedReader;
import java.io.IOException;
import java.util.stream.Collectors;

import com.google.gson.Gson;
import com.hy.dto.score.GoalScore;
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
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 // 1. 인코딩 및 응답 설정
	        request.setCharacterEncoding("UTF-8");
	        response.setContentType("application/json; charset=UTF-8");

	        boolean allSuccess = true;

	        try {
	            // 2. JSON 데이터 읽기
	            BufferedReader reader = request.getReader();
	            String json = reader.lines().collect(Collectors.joining());

	            // 3. JSON → GoalScore[]로 변환
	            Gson gson = new Gson();
	            GoalScore[] scoreList = gson.fromJson(json, GoalScore[].class);

	            // 4. Service 호출
	            GoalScoreService service = new GoalScoreService();

	            for (GoalScore dto : scoreList) {
	                boolean inserted = service.insertGoalScore(dto);
	                if (!inserted) {
	                    allSuccess = false;
	                    break;
	                }
	            }

	        } catch (Exception e) {
	            e.printStackTrace();
	            allSuccess = false;
	        }

	        // 5. JSON 응답 반환
	        response.getWriter().write("{\"success\": " + allSuccess + "}");
	    }
	
}
