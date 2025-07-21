package com.hy.controller.qna;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;

import org.json.simple.JSONObject;

import com.hy.dto.qna.Attach;
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
@WebServlet("/qna/update")
public class QnaUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private QnaService qnaService = new QnaService();
       
    public QnaUpdateServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 화면단에서 전달받은 정보 가져오기
		int qnaId = Integer.parseInt(request.getParameter("no"));
		
		Qna qna = qnaService.selectQnaOne(qnaId);
		Attach attach = qnaService.selectAttachByQnaNo(qnaId);
		
		request.setAttribute("qna", qna);
		request.setAttribute("attach", attach);
		
		request.getRequestDispatcher("/views/qna/update.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 1. 인코딩처리(utf-8)
		request.setCharacterEncoding("utf-8");

		// 2. 정보 가져오기(번호,이름,나이)
		int qnaId = Integer.parseInt(request.getParameter("no"));

		String category = request.getParameter("qnaCategory");
		int visibility = Integer.parseInt(request.getParameter("qnaVisibility"));
		String title = request.getParameter("qnaTitle");
		String content = request.getParameter("qnaContent");

		int check =  Integer.parseInt(request.getParameter("check"));

		
		Qna qna = new Qna();
		qna.setQnaId(qnaId);
		qna.setCategory(category);
		qna.setVisibility(visibility);
		qna.setTitle(title);
		qna.setContent(content);
		
		File uploadDir = AttachService.getUploadDirectory();
		Attach attach = AttachService.handleUploadFile(request, uploadDir);
		
		int result = 0;
		
		if (attach != null) {
			attach.setQnaId(qnaId);
			if (check == 2) {
				// 공지사항이 없는 게시물에 새롭게 첨부파일이 들어온 경우
				result = qnaService.updateQnaNewAttach(qna, attach);
			} else {
				// 공지사항 수정과 더불어 첨부파일이 새롭게 업데이트 된 경우
				result = qnaService.updateQnaWithAttach(qna, attach);				
			}
		} else {
			if (check == 1) {
				// 공지사항 수정과 더불어 첨부파일을 삭제한 경우
				result = qnaService.updateQnaDeleteAttach(qna);
			} else if (check == 0 || check == 2) {
				// 공지사항 수정과 더불어 첨부파일을 유지하는 경우, 또는 첨부파일이 없는 게시물인 경우
				result = qnaService.updateQnaSameAttach(qna);
			}
		}
		
		JSONObject obj = new JSONObject();

		
		if (result > 0) {
			obj.put("res_msg", "성공적으로 수정되었습니다.");
			obj.put("res_code", "200");
		} else {
			obj.put("res_msg", "게시글 수정 중 오류가 발생했습니다.");
			obj.put("res_code", "500");			
		}
		
		response.setContentType("application/json; charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.print(obj);
		
	}

}
