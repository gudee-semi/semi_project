package com.hy.controller.score;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Collections;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.google.gson.Gson;
import com.hy.controller.tablet.MybatisUtil;
import com.hy.dto.score.GoalScore;
import com.hy.mapper.score.ScoreMapper;
import com.hy.service.score.GoalScoreService;

@WebServlet("/goal_score_view/select")
public class GoalScoreSelectServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private GoalScoreService service = new GoalScoreService();

    public GoalScoreSelectServlet() {
        super();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json; charset=UTF-8");

        String memberNoParam = request.getParameter("memberNo");
        String examTypeIdParam = request.getParameter("examTypeId");

        Gson gson = new Gson();
        String json;

        // ✅ 파라미터 유효성 검사
        if (memberNoParam == null || memberNoParam.isEmpty()) {
            response.getWriter().write("[]");
            return;
        }

        int memberNo;
        try {
            memberNo = Integer.parseInt(memberNoParam);
        } catch (NumberFormatException e) {
            response.getWriter().write("[]");
            return;
        }

        SqlSession session = MybatisUtil.getSqlSession();
        ScoreMapper mapper = session.getMapper(ScoreMapper.class);

        try {
            if (examTypeIdParam == null || examTypeIdParam.isEmpty()) {
                // ✅ 시험 분류 체크박스 활성화용
                List<Integer> availableExamTypes = mapper.selectAvailableExamTypeIds(memberNo);
                json = gson.toJson(availableExamTypes);
            } else {
                // ✅ 특정 시험의 목표 성적 리스트 반환
                int examTypeId = Integer.parseInt(examTypeIdParam);
                List<GoalScore> scoreList = mapper.selectGoalScores(memberNo, examTypeId);
                json = gson.toJson(scoreList);
            }

            response.getWriter().write(json);

        } catch (Exception e) {
            e.printStackTrace(); // (개발 중 로그)
            response.getWriter().write(gson.toJson(Collections.emptyList()));
        } finally {
            session.close();
        }
    }



    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    }
}
