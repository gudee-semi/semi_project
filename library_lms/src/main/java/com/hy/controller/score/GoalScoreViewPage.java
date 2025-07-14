package com.hy.controller.score;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Arrays;
import java.util.List;


@WebServlet("/goal_score_view/view")
public class GoalScoreViewPage extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public GoalScoreViewPage() {
        super();
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// ✅ 시험 선택 옵션 전달
		List<Integer> examOptions = Arrays.asList(3, 6, 9, 11);
		
		// 자동으로 체크할 시험 (예: 현재 날짜 기준 6월)
		int nowMonth = java.util.Calendar.getInstance().get(java.util.Calendar.MONTH) + 1;
		int autoExamMonth = -1;
		for (int month : examOptions) {
			if (month >= nowMonth) {
				autoExamMonth = month;
				break;
			}
		}
		if (autoExamMonth == -1) autoExamMonth = 11; // 예외처리: 기본값

		// ✅ JSP에서 사용할 데이터 설정
		request.setAttribute("examOptions", examOptions);
		request.setAttribute("autoExamMonth", autoExamMonth);

		// ✅ JSP 포워딩
		request.getRequestDispatcher("/views/score/goal_score_viewPage.jsp").forward(request, response);
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
