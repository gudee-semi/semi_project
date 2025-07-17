package com.hy.controller.score;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.google.gson.Gson;
import com.hy.dto.Member;
import com.hy.dto.score.ActualScore;
import com.hy.dto.score.GoalScore;
import com.hy.dto.score.ScoreCompare;
import com.hy.service.score.ActualScoreService;

@WebServlet("/analysis_score/select")
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
	        int studentGrade = loginMember.getMemberGrade();
	        String examTypeIdParam = request.getParameter("examTypeId");
	        
	        // 차트 전용 요청인지 확인
	        boolean isChartRequest = "true".equals(request.getParameter("chartOnly"));

	        try {
	            if (examTypeIdParam == null || examTypeIdParam.isEmpty()) {
	                // [1] 시험 목록 조회 (입력된 성적 기준)
	                List<Integer> availableExamTypes = service.selectAvailableExamTypeIds(memberNo);
	                String json = gson.toJson(availableExamTypes);
	                response.getWriter().write(json);
	            } else {
	                // [2] 특정 시험 성적 조회
	                int examTypeId = Integer.parseInt(examTypeIdParam);

	                if (isChartRequest) {
						// [2-A] 차트용 데이터 JSON 반환
						Map<String, Integer> param = new HashMap<>();
						param.put("memberNo", memberNo);
						param.put("examTypeId", examTypeId);

						List<ScoreCompare> compareList = service.selectGoalAndActualScores(param);

						List<String> subjectNames = new ArrayList<>();
						List<Integer> goalScores = new ArrayList<>();
						List<Integer> actualScores = new ArrayList<>();

						for (ScoreCompare row : compareList) {
							subjectNames.add(row.getSubjectName());
							goalScores.add(row.getGoalScore());
							actualScores.add(row.getActualScore());
						}

						Map<String, Object> result = new HashMap<>();
						result.put("subjectNames", subjectNames);
						result.put("goalScores", goalScores);
						result.put("actualScores", actualScores);
						result.put("examTitle", studentGrade + "학년 " + examTypeId + "월 모의고사");

						String json = gson.toJson(result);
						response.getWriter().write(json);

					} else {
						// [2-B] 기존 기능: 실제 성적 테이블을 JSP로 포워딩
						List<ActualScore> scoreList = service.selectActualScoresByMemberAndExam(memberNo, examTypeId);
						request.setAttribute("scores", scoreList);
						request.getRequestDispatcher("/views/score/actual_score_table.jsp").forward(request, response);
					}
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
