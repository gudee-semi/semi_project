// GoalScoreInsertServlet.java
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

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.hy.dto.Member;
import com.hy.dto.score.GoalScore;
import com.hy.dto.score.GoalScoreRequest;
import com.hy.service.score.GoalScoreService;
import com.hy.common.sql.SqlSessionTemplate;
import org.apache.ibatis.session.SqlSession;
import com.hy.mapper.score.SubjectMapper;

@WebServlet("/goal_score/insert")
public class GoalScoreInsertServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private GoalScoreService service = new GoalScoreService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json; charset=UTF-8");

        boolean allSuccess = true;
        JsonObject resultJson = new JsonObject();

        SqlSession session = SqlSessionTemplate.getSqlSession(false);

        try {
            // 1. 세션에서 로그인된 사용자 정보
            HttpSession httpSession = request.getSession();
            Member student = (Member) httpSession.getAttribute("loginMember");
            if (student == null) {
                response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                response.getWriter().write("{\"success\": false, \"reason\": \"unauthorized\"}");
                return;
            }

            int memberNo = student.getMemberNo();
            int grade = student.getMemberGrade();

            // 2. JSON 요청 파싱
            BufferedReader reader = request.getReader();
            String json = reader.lines().collect(Collectors.joining());
            GoalScoreRequest reqDto = new Gson().fromJson(json, GoalScoreRequest.class);

            // 3. 과목명 → subjectId 매핑
            SubjectMapper subjectMapper = session.getMapper(SubjectMapper.class);
            List<GoalScore> scoreList = new ArrayList<>();
            for (GoalScore dto : reqDto.getSubjectScores()) {
                String subjectName = dto.getSubjectName() != null ? dto.getSubjectName().trim() : "";
                Integer subjectId = subjectMapper.selectSubjectIdByName(subjectName);
                if (subjectId == null) {
                    allSuccess = false;
                    break;
                }
                dto.setSubjectId(subjectId);
                dto.setMemberNo(memberNo);
                dto.setGrade(grade);
                dto.setExamTypeId(reqDto.getExamTypeId());
                scoreList.add(dto);
            }

            // 4. 실제 insert 서비스 호출(트랜잭션)
            if (allSuccess) {
                allSuccess = new GoalScoreService().insertGoalScores(scoreList);
            }

            if (allSuccess) {
                session.commit();
            } else {
                session.rollback();
            }

        } catch (Exception e) {
            if (session != null) session.rollback();
            e.printStackTrace();
            allSuccess = false;
        } finally {
            if (session != null) session.close();
        }

        response.getWriter().write("{\"success\": " + allSuccess + "}");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // doPost만 사용
    }
}
