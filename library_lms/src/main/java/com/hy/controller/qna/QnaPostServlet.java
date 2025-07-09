package com.hy.controller.qna;

import java.io.File;
import java.io.IOException;

import org.json.simple.JSONObject;

import com.hy.dto.Attach;
import com.hy.dto.Qna;
import com.hy.service.qna.AttachService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/qnaPost")
public class QnaPostServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public QnaPostServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 1. 게시글 정보 추출
				int qnaCategory = Integer.parseInt(request.getParameter("qnaCategory"));
				int qnaWriter = Integer.parseInt(request.getParameter("qnaWriter"));
				String qnaTitle = request.getParameter("qnaTitle");
				String qnaContent = request.getParameter("qnaContent");
				int qnaVisibility = Integer.parseInt(request.getParameter("qnaVisibility"));
				
				Qna qna = new Qna();
				qna.setCategory(qnaCategory);
				qna.setMemberId(qnaWriter);
				qna.setTitle(qnaTitle);
				qna.setContent(qnaContent);
				qna.setVisibility(qnaVisibility);
				
				// 2. 파일 정보 추출
				File uploadDir = AttachService.getUploadDirectory();
				Attach attach = AttachService.handleUploadFile(request, uploadDir);
				
				// 3. 게시글과 파일 정보 데이터베이스에 추가
				int result = AttachService.createBoardWithAttach(qna,attach);
				
				JSONObject obj = new JSONObject();
				
				if(result > 0) {
					obj.put("res_code", "200");
					obj.put("res_msg", "게시글 등록이 성공적으로 진행되었습니다.");
				} else {
					obj.put("res_code", "500");
					obj.put("res_msg", "게시글 등록중 오류가 발생했습니다.");
				}
				
				response.setContentType("application/json; charset=utf-8");
				response.getWriter().print(obj);
	}

}
