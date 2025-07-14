package com.hy.controller.score;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
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
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json; charset=UTF-8");

        int memberNo = Integer.parseInt(request.getParameter("memberNo"));
        int examTypeId = Integer.parseInt(request.getParameter("examTypeId"));

        SqlSession session = MybatisUtil.getSqlSession();

        try {
            ScoreMapper scoreMapper = session.getMapper(ScoreMapper.class);
            List<GoalScore> scores = scoreMapper.selectGoalScoresByMemberAndExam(memberNo, examTypeId);

            String json = new Gson().toJson(scores);
            response.getWriter().write(json);

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("{\"success\": false, \"message\": \"조회 중 오류 발생\"}");
        } finally {
            session.close();
        }
    }
    

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    }
}
