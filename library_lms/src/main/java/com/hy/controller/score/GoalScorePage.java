package com.hy.controller.score;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import com.hy.dto.Member;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


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
		
		
		 // ✅ 1. 세션에서 로그인된 사용자 학년 가져오기
        HttpSession session = request.getSession();
        Member student = (Member)session.getAttribute("loginMember");
        int studentGrade =student.getMemberGrade();

        // ✅ 2. 학년에 따라 시험 옵션 결정
        List<Integer> examOptions = new ArrayList<>(Arrays.asList(3, 6, 9));
        if (studentGrade == 3) {
            examOptions.add(11); // 수능은 3학년만
        }

        // ✅ 3. 탐구 과목 리스트
        List<String> socialSubjects = Arrays.asList("경제", "사회문화", "법과정치", "윤리와 사상", "세계지리", "한국지리", "세계사", "동아시아사", "생활과 윤리");
        List<String> science1Subjects = Arrays.asList("물리1", "화학1", "생명과학1", "지구과학1");
        List<String> science2Subjects = Arrays.asList("물리2", "화학2", "생명과학2", "지구과학2"); // 3학년 전용
        List<String> lang2Subjects = Arrays.asList("독일어", "프랑스어", "스페인어", "중국어", "일본어", "러시아어", "아랍어", "베트남어", "한문");

        // ✅ 4. 현재 날짜로 가장 가까운 시험 자동 선택
        int nowMonth = java.time.LocalDate.now().getMonthValue();
        int autoExamMonth = examOptions.stream()
            .filter(m -> m > nowMonth)
            .findFirst()
            .orElse(examOptions.get(0)); // 올해 남은 시험 없으면 첫 번째(내년용)

        // ✅ 5. JSP에서 사용할 값 넘기기
        request.setAttribute("examOptions", examOptions);
        request.setAttribute("autoExamMonth", autoExamMonth);
        request.setAttribute("socialSubjects", socialSubjects);
        request.setAttribute("science1Subjects", science1Subjects);
        request.setAttribute("science2Subjects", science2Subjects);
        request.setAttribute("lang2Subjects", lang2Subjects);

        // ✅ 6. 포워딩
        request.getRequestDispatcher("/views/score/goal_scorePage.jsp").forward(request, response);
    }


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
