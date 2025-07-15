package com.hy.controller.score;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

import com.hy.dto.Member;
import com.hy.dto.score.ExamType;
import com.hy.service.score.GoalScoreService;

@WebServlet("/goal_score_view/view")
public class GoalScoreViewPage extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final GoalScoreService service = new GoalScoreService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Member loginMember = (Member) session.getAttribute("loginMember");
        

        if (loginMember == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        int studentGrade = loginMember.getMemberGrade();
        

        // 서비스 호출로 학년별 시험 분류 리스트 조회
        List<ExamType> examTypeList = service.getExamTypesByGrade(studentGrade);

        // JSP에 리스트 전달
        request.setAttribute("examTypeList", examTypeList);

        request.getRequestDispatcher("/views/score/goal_score_viewPage.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
