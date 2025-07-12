package com.hy.controller.score;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Arrays;
import java.util.List;


@WebServlet("/goal_score/view")
public class GoalScorePage extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public GoalScorePage() {
        super();
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		/*
		 * 시험 분류
		 * examOptions → [3, 6, 9]
		 * (학년에 따라 3학년이면 11도 포함하면 됨!)
		 * 사회탐구, 과학탐구 리스트
		 * socialSubjects
		 * science1Subjects
		 * (필요하면 과학탐구2, 제2외국어 리스트도 추가해서 setAttribute로 넘기면 됨)
		 */
		
		
		// 1. 예시로 2학년(3,6,9월 모의고사)라고 가정
        List<Integer> examOptions = Arrays.asList(3, 6, 9,11);
        List<String> socialSubjects = Arrays.asList("경제", "사회문화", "법과정치", "윤리와 사상", "세계지리", "한국지리", "세계사", "동아시아사", "생활과 윤리");
        List<String> science1Subjects = Arrays.asList("물리1", "화학1", "생명과학1", "지구과학1");
        // 필요하면 과학탐구2, 제2외국어도
     // 추가! 3학년 전용
        List<String> science2Subjects = Arrays.asList("물리2", "화학2", "생명과학2", "지구과학2");
        List<String> lang2Subjects = Arrays.asList("독일어", "프랑스어", "스페인어", "중국어", "일본어", "러시아어", "아랍어", "베트남어", "한문");

        // 2. 현재 날짜로 가장 가까운 월 찾기 (아래는 간단 예시)
        int nowMonth = java.time.LocalDate.now().getMonthValue();
        int autoExamMonth = examOptions.stream()
            .filter(m -> m > nowMonth)
            .findFirst()
            .orElse(examOptions.get(0)); // 없으면 첫번째(내년)
        
       

        // 3. JSP에서 사용할 값 넘기기!
        request.setAttribute("socialSubjects", socialSubjects);
        request.setAttribute("science1Subjects", science1Subjects);
        request.setAttribute("science2Subjects", science2Subjects);
        request.setAttribute("lang2Subjects", lang2Subjects);
        request.setAttribute("examOptions", examOptions);
        request.setAttribute("autoExamMonth", autoExamMonth);

        // 4. JSP로 forward
        request.getRequestDispatcher("/views/score/goal_scorePage.jsp").forward(request, response);
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
