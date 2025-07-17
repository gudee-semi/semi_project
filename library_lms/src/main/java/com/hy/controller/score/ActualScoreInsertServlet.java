package com.hy.controller.score;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.BufferedReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

import org.apache.ibatis.session.SqlSession;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.hy.common.sql.SqlSessionTemplate;
import com.hy.dto.Member;
import com.hy.dto.score.ActualScore;
import com.hy.dto.score.ActualScoreRequest;
import com.hy.dto.score.GoalScore;
import com.hy.dto.score.GoalScoreRequest;
import com.hy.mapper.score.SubjectMapper;
import com.hy.service.score.ActualScoreService;
import com.hy.service.score.GoalScoreService;

@WebServlet("/actual_score/insert")
public class ActualScoreInsertServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private ActualScoreService service = new ActualScoreService();
       
    public ActualScoreInsertServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		       
        
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json; charset=UTF-8");

        boolean allSuccess = true;
        String reason = "";
        JsonObject resultJson = new JsonObject();

        SqlSession session = SqlSessionTemplate.getSqlSession(false); // 수동 커밋 모드

        try {
            // [1] 세션에서 로그인된 사용자 정보 가져오기
            HttpSession httpSession = request.getSession();
            Member student = (Member) httpSession.getAttribute("loginMember");

            // 로그인 안 된 경우
            if (student == null) {
                response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                resultJson.addProperty("success", false);
                resultJson.addProperty("reason", "unauthorized");
                response.getWriter().write(resultJson.toString());
                return;
            }

            int memberNo = student.getMemberNo();
            int grade = student.getMemberGrade();

            // [2] 클라이언트에서 전송된 JSON 데이터 파싱
            BufferedReader reader = request.getReader();
            String json = reader.lines().collect(Collectors.joining());
            ActualScoreRequest reqDto = new Gson().fromJson(json, ActualScoreRequest.class);

            int examType = reqDto.getExamTypeId();
            ActualScoreService service = new ActualScoreService();
            int examTypeId = service.getExamTypeId(examType, grade);

            // 3. 과목명 → subjectId 변환
            SubjectMapper subjectMapper = session.getMapper(SubjectMapper.class);
            List<ActualScore> scoreList = new ArrayList<>();

            for (ActualScore dto : reqDto.getSubjectScores()) {
                String subjectName = dto.getSubjectName() != null ? dto.getSubjectName().trim() : "";
                Integer subjectId = subjectMapper.selectSubjectIdByName(subjectName);

                if (subjectId == null) {
                    allSuccess = false;
                    resultJson.addProperty("success", false);
                    resultJson.addProperty("reason", "invalid_subject");
                    session.rollback();
                    response.getWriter().write(resultJson.toString());
                    return;
                }

                dto.setSubjectId(subjectId);
                dto.setMemberNo(memberNo);
                dto.setGrade(grade);
                dto.setExamTypeId(examTypeId);
                scoreList.add(dto);
            }

            // 4. 중복 여부 검사 (memberNo + examTypeId 조합)
            int existingCount = service.countByMemberAndExamType(session, memberNo, examTypeId);

            if (existingCount > 0) {
                resultJson.addProperty("success", false);
                resultJson.addProperty("reason", "duplicate");
                session.rollback();
                response.getWriter().write(resultJson.toString());
                return;
            }

            // 5. insert 실행
            allSuccess = service.insertActualScores(scoreList);

            if (allSuccess) {
                session.commit();
                resultJson.addProperty("success", true);
            } else {
                session.rollback();
                resultJson.addProperty("success", false);
                resultJson.addProperty("reason", "insert_failed");
            }

        } catch (Exception e) {
            if (session != null) session.rollback();
            e.printStackTrace();
            resultJson.addProperty("success", false);
            resultJson.addProperty("reason", "server_error");
        } finally {
            if (session != null) session.close();
        }

        response.getWriter().write(resultJson.toString());
    }
}
