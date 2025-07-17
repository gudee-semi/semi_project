package com.hy.controller.score;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.net.URLEncoder;

import com.hy.service.score.ActualScoreService;
import com.hy.service.score.GoalScoreService;

@WebServlet("/analysis_score/delete")
public class ActualScoreDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private ActualScoreService service = new ActualScoreService();
       
    public ActualScoreDeleteServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
    	
    	int memberNo = 0;
        int examTypeId = 0;
        int result = 0;
        
        System.out.println(memberNo);
        
        try {
            memberNo = Integer.parseInt(request.getParameter("memberNo"));
            examTypeId = Integer.parseInt(request.getParameter("examTypeId"));
            result = service.deleteActualScoresByMemberAndExam(memberNo, examTypeId);
        } catch (NumberFormatException e) {
            String msg = URLEncoder.encode("잘못된 요청입니다", "UTF-8");
            // 삭제 실패도 동일하게 모달 띄우는 방식 적용(아래와 동일 구조)
            response.sendRedirect("/goal_score_view/view?delete=fail&msg=" + msg);
            return;
        }

        System.out.println(result);
        
        
        if (result > 0) {
            // 삭제 성공
            response.sendRedirect("/views/score/analysis_scorePage.jsp?delete=success");
        } else {
            // 삭제 실패
            String msg = URLEncoder.encode("삭제하지 못했습니다", "UTF-8");
            response.sendRedirect("/views/score/analysis_scorePage.jsp?delete=fail&msg=" + msg);
        }

    }
}