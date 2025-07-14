package com.hy.controller.score;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

import com.google.gson.Gson;
import com.hy.dto.score.GoalScore;
import com.hy.service.score.GoalScoreService;

@WebServlet("/goal_score/select")
public class GoalScoreSelectServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // ✅ service 선언
    private GoalScoreService service = new GoalScoreService();

    public GoalScoreSelectServlet() {
        super();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // GET 요청에서도 조회 가능하도록 구현
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 인코딩 설정
        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json; charset=UTF-8");

     // ✅ 세션에서 로그인 사용자 번호 꺼내기
        Integer memberNo = (Integer) request.getSession().getAttribute("memberNo");

        if (memberNo == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            response.getWriter().write("{\"error\":\"로그인이 필요합니다.\"}");
            return;
        }
        try {
            // Service 호출
            List<GoalScore> list = service.getGoalScoresByMember(memberNo);

            // JSON 변환 및 응답
            Gson gson = new Gson();
            String json = gson.toJson(list);
            response.getWriter().write(json);
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"error\":\"목표 성적 조회 중 오류가 발생했습니다.\"}");
        }
    }
}
