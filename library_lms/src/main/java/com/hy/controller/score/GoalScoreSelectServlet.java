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

    private GoalScoreService service = new GoalScoreService();

    public GoalScoreSelectServlet() {
        super();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    }
}
