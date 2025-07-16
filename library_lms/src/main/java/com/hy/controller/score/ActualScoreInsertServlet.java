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

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json; charset=UTF-8");

        boolean allSuccess = true;
        String reason = "";
        JsonObject resultJson = new JsonObject();

        SqlSession session = SqlSessionTemplate.getSqlSession(false);

        try {
            HttpSession httpSession = request.getSession();
            Member student = (Member) httpSession.getAttribute("loginMember");
            if (student == null) {
                response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                resultJson.addProperty("success", false);
                resultJson.addProperty("reason", "unauthorized");
                response.getWriter().write(resultJson.toString());
                return;
            }

            int memberNo = student.getMemberNo();
            int grade = student.getMemberGrade();

            // JSON 파싱
            BufferedReader reader = request.getReader();
            String json = reader.lines().collect(Collectors.joining());
            ActualScoreRequest reqDto = new Gson().fromJson(json, ActualScoreRequest.class);

            // 과목명 매핑
            SubjectMapper subjectMapper = session.getMapper(SubjectMapper.class);
            List<ActualScore> scoreList = new ArrayList<>();
            for (ActualScore dto : reqDto.getSubjectScores()) {
                String subjectName = dto.getSubjectName() != null ? dto.getSubjectName().trim() : "";
                Integer subjectId = subjectMapper.selectSubjectIdByName(subjectName);
                if (subjectId == null) {
                    allSuccess = false;
                    reason = "subject_not_found";
                    break;
                }
                dto.setSubjectId(subjectId);
                dto.setMemberNo(memberNo);
                dto.setGrade(grade);
                dto.setExamTypeId(reqDto.getExamTypeId());
                scoreList.add(dto);
            }

            // 실제 insert 서비스 호출 (여기서 service 변수 확인)
            if (allSuccess) {
                // 중복 검사 등은 service에서 처리
                allSuccess = service.insertActualScores(scoreList); // ★★★ 이 부분 반드시 실제 서비스로!
            }

            if (allSuccess) {
                session.commit();
                resultJson.addProperty("success", true);
            } else {
                session.rollback();
                resultJson.addProperty("success", false);
                resultJson.addProperty("reason", reason.isEmpty() ? "insert_fail" : reason);
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

