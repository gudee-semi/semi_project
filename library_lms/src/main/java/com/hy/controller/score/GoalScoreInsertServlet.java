package com.hy.controller.score;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.BufferedReader;
import java.io.IOException;
import java.util.stream.Collectors;

import org.apache.ibatis.session.SqlSession;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.hy.controller.tablet.MybatisUtil;
import com.hy.dto.score.GoalScore;
import com.hy.dto.score.GoalScoreRequest;
import com.hy.mapper.score.ScoreMapper;
import com.hy.mapper.score.SubjectMapper;
import com.hy.service.score.GoalScoreService;


@WebServlet("/goal_score/insert")
public class GoalScoreInsertServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public GoalScoreInsertServlet() {
        super();
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}
	
	
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
	        throws ServletException, IOException {
 
	    request.setCharacterEncoding("UTF-8");
	    response.setContentType("application/json; charset=UTF-8");

	    boolean allSuccess = true;
        JsonObject resultJson = new JsonObject(); // ✅ 응답 구조
        SqlSession session = MybatisUtil.getSqlSession(); // 트랜잭션 유지

        try {
            BufferedReader reader = request.getReader();
            String json = reader.lines().collect(Collectors.joining());
            GoalScoreRequest reqDto = new Gson().fromJson(json, GoalScoreRequest.class);

            SubjectMapper subjectMapper = session.getMapper(SubjectMapper.class);
            ScoreMapper scoreMapper = session.getMapper(ScoreMapper.class);

            int memberNo = reqDto.getMemberNo();
            int examTypeId = reqDto.getExamTypeId();

            // ✅ 1. 중복 확인: 이미 해당 memberNo + examTypeId 조합이 존재하는지
            int count = scoreMapper.countGoalScoreByMemberAndExam(memberNo, examTypeId);
            if (count > 0) {
                resultJson.addProperty("success", false);
                resultJson.addProperty("reason", "duplicate");
                response.getWriter().write(resultJson.toString());
                return;
            }

            // ✅ 2. 실제 insert 처리
            for (GoalScore dto : reqDto.getSubjectScores()) {

                String subjectName = dto.getSubjectName() != null ? dto.getSubjectName().trim() : "";
                Integer subjectId = subjectMapper.selectSubjectIdByName(subjectName);

                if (subjectId == null) {
                    allSuccess = false;
                    break;
                }

                dto.setSubjectId(subjectId);
                dto.setMemberNo(memberNo);
                dto.setExamTypeId(examTypeId);
                dto.setGrade(3); // 학년 정보 설정

                // 🔁 학년에 따라 examTypeId 다시 매핑 (1~3학년)
                int temp = examTypeId;
                if (dto.getGrade() == 1) {
                    if (temp == 3) dto.setExamTypeId(1);
                    else if (temp == 6) dto.setExamTypeId(2);
                    else if (temp == 9) dto.setExamTypeId(3);
                } else if (dto.getGrade() == 2) {
                    if (temp == 3) dto.setExamTypeId(4);
                    else if (temp == 6) dto.setExamTypeId(5);
                    else if (temp == 9) dto.setExamTypeId(6);
                } else {
                    if (temp == 3) dto.setExamTypeId(7);
                    else if (temp == 6) dto.setExamTypeId(8);
                    else if (temp == 9) dto.setExamTypeId(9);
                    else if (temp == 11) dto.setExamTypeId(10);
                }

                int result = scoreMapper.insertGoalScore(dto);
                if (result <= 0) {
                    allSuccess = false;
                    break;
                }
            }

            if (allSuccess) {
                session.commit();
                resultJson.addProperty("success", true);
            } else {
                session.rollback();
                resultJson.addProperty("success", false);
                resultJson.addProperty("reason", "insert_fail");
            }

        } catch (Exception e) {
            e.printStackTrace();
            allSuccess = false;
            session.rollback();
            resultJson.addProperty("success", false);
            resultJson.addProperty("reason", "exception");
        } finally {
            session.close();
        }

        response.getWriter().write(resultJson.toString());
    }
}


	