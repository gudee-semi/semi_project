package com.hy.controller.qna;

import java.io.File;
import java.io.IOException;

import org.json.simple.JSONObject;

import com.hy.dto.Attach;
import com.hy.dto.qna.Qna;
import com.hy.service.qna.AttachService;
import com.hy.service.qna.QnaService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,
        maxFileSize = 1024 * 1024 * 5,
        maxRequestSize = 1024 * 1024 * 20
)
@WebServlet("/qna/write")
public class QnaWriteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private QnaService qnaService = new QnaService();
       
    public QnaWriteServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("/views/qna/write.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		int visibility = Integer.parseInt(request.getParameter("qnaVisibility"));
//		String memberId = ;
		int categoryCode = Integer.parseInt(request.getParameter("qnaCategory"));
		String title = request.getParameter("qnaTitle");
		String content = request.getParameter("qnaContent");
		
		String categoryName = "";
		switch(categoryCode) {
        case 0: categoryName = "기타"; break;
        case 1: categoryName = "시설"; break;
        case 2: categoryName = "좌석"; break;
        case 3: categoryName = "환불"; break;
        case 4: categoryName = "기타"; break;
    }
		
		Qna qna = new Qna();
		qna.setCategory(categoryName);
		qna.setTitle(title);
		qna.setContent(content);
		qna.setVisibility(visibility);
		
		// 2. 파일 정보 추출
		File uploadDir = AttachService.getUploadDirectory();
		Attach attach = AttachService.handleUploadFile(request, uploadDir);
		
		// 3. 게시글과 파일 정보 데이터베이스에 추가
		int result = qnaService.createQnaWithAttach(qna,attach);
		
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
