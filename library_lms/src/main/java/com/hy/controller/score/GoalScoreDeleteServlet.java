package com.hy.controller.score;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.net.URLEncoder;

import com.hy.service.score.GoalScoreService;

@WebServlet("/goal_score/delete")
public class GoalScoreDeleteServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private GoalScoreService service = new GoalScoreService();

    public GoalScoreDeleteServlet() {
        super();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	request.setCharacterEncoding("UTF-8");
    	
    	int memberNo = 0;
        int examTypeId = 0;
        int result = 0;
        
        
        try {
            memberNo = Integer.parseInt(request.getParameter("memberNo"));
            examTypeId = Integer.parseInt(request.getParameter("examTypeId"));
            result = service.deleteScoresByMemberAndExam(memberNo, examTypeId);
        } catch (NumberFormatException e) {
            String msg = URLEncoder.encode("잘못된 요청입니다", "UTF-8");
            // 삭제 실패도 동일하게 모달 띄우는 방식 적용(아래와 동일 구조)
            response.sendRedirect("/goal_score_view/view?delete=fail&msg=" + msg);
            return;
        }

        
        
        if (result > 0) {
            // 삭제 성공: 성공 플래그 포함해서 페이지 이동
            response.sendRedirect("/goal_score_view/view?delete=success");
        } else {
            // 삭제 실패: 실패 플래그 포함해서 페이지 이동
            String msg = URLEncoder.encode("삭제하지 못했습니다", "UTF-8");
            response.sendRedirect("/goal_score_view/view?delete=fail&msg=" + msg);
        }
    }
}
