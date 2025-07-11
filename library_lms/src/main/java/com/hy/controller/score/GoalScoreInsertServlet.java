package com.hy.controller.score;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import com.hy.dto.score.GoalScore;
import com.hy.service.score.GoalScoreService;


@WebServlet("/goal_score/insert")
public class GoalScoreInsertServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public GoalScoreInsertServlet() {
        super();
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 인코딩 한글 깨짐 방지
		request.setCharacterEncoding("UTF-8");

        // 1. 파라미터 받기
        int memberNo = Integer.parseInt(request.getParameter("memberNo"));
        int examTypeId = Integer.parseInt(request.getParameter("examTypeId"));
        int subjectId = Integer.parseInt(request.getParameter("subjectId"));
        int targetScore = Integer.parseInt(request.getParameter("targetScore"));
        int targetGrade = Integer.parseInt(request.getParameter("targetGrade"));

        // 2. DTO 생성
        GoalScore dto = new GoalScore(memberNo, examTypeId, subjectId, targetScore, targetGrade);

        // 3. 서비스 호출
        GoalScoreService service = new GoalScoreService();
        boolean result = service.insertGoalScore(dto);

        // 4. 응답 처리 (AJAX용)
        response.setContentType("application/json; charset=UTF-8");
        response.getWriter().write("{\"success\": " + result + "}");
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
