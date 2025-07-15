package com.hy.controller.score;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

import com.google.gson.Gson;
import com.hy.dto.Member;
import com.hy.dto.score.GoalScore;
import com.hy.service.score.GoalScoreService;

@WebServlet("/goal_score_view/select")
public class GoalScoreSelectServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // ⭐️ Service 생성
    private GoalScoreService service = new GoalScoreService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json; charset=UTF-8");
        Gson gson = new Gson();

        // ✅ 세션에서 로그인 정보 가져오기
        HttpSession session = request.getSession();
        Member loginMember = (Member) session.getAttribute("loginMember");

        if (loginMember == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            response.getWriter().write("[]");
            return;
        }

        int memberNo = loginMember.getMemberNo();
        String examTypeIdParam = request.getParameter("examTypeId");
        
        System.out.println("memberNo = " + memberNo + ", examTypeId = " + examTypeIdParam);

        try {
            String json;

            if (examTypeIdParam == null || examTypeIdParam.isEmpty()) {
                // 시험 체크박스 활성화용(목표성적 입력된 시험 리스트)
                List<Integer> availableExamTypes = service.selectAvailableExamTypeIds(memberNo);
                json = gson.toJson(availableExamTypes);
            } else {
                // 목표성적 상세조회
                int examTypeId = Integer.parseInt(examTypeIdParam);
                List<GoalScore> scoreList = service.selectGoalScoresByMemberAndExam(memberNo, examTypeId);
                request.setAttribute("scores",scoreList);
                request.getRequestDispatcher("/views/score/score_table.jsp").forward(request, response);
                //json = gson.toJson(scoreList);
                return;
            }
            //System.out.println("JSON "+json);
            response.getWriter().write(json);

        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("[]");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // 조회용: doGet만 사용
    }
}
