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
import com.hy.dto.score.ActualScore;
import com.hy.dto.score.GoalScore;
import com.hy.service.score.ActualScoreService;

@WebServlet("/actual_score/select")
public class ActualScoreSelectServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	// service 생성
	private ActualScoreService service = new ActualScoreService();
       
    public ActualScoreSelectServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 response.setContentType("application/json; charset=UTF-8");
	        Gson gson = new Gson();

	        // 세션에서 로그인 정보 가져오기
	        HttpSession session = request.getSession();
	        Member loginMember = (Member) session.getAttribute("loginMember");

	        if (loginMember == null) {
	            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
	            response.getWriter().write("[]");
	            return;
	        }

	        int memberNo = loginMember.getMemberNo();
	        String examTypeIdParam = request.getParameter("examTypeId");
	        

	        try {
				if (examTypeIdParam == null || examTypeIdParam.isEmpty()) {
					// [1] 시험 목록 조회 (입력된 성적 기준)
					List<Integer> availableExamTypes = service.selectAvailableExamTypeIds(memberNo); // 🔧 이 메서드 ActualScoreService에 있어야 함
					String json = gson.toJson(availableExamTypes);
					response.getWriter().write(json);
				} else {
					// [2] 특정 시험 성적 조회
					int examTypeId = Integer.parseInt(examTypeIdParam);
					List<ActualScore> scoreList = service.selectActualScoresByMemberAndExam(memberNo, examTypeId);

					// JSP로 포워딩하여 성적 테이블 렌더링
					request.setAttribute("scores", scoreList);
					request.getRequestDispatcher("/views/score/actual_score_table.jsp").forward(request, response);
				}
			} catch (Exception e) {
				e.printStackTrace();
				response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
				response.getWriter().write("[]");
			}
		}
	
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
