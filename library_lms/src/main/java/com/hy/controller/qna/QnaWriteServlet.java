package com.hy.controller.qna;

import java.io.File;
import java.io.IOException;

import org.json.simple.JSONObject;

import com.hy.dto.Member;
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
import jakarta.servlet.http.HttpSession;

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
		
		HttpSession session = request.getSession(false); // 기존 세션만 가져오기
		Member member = null;
		
	    if (session != null) {
	        member = (Member) session.getAttribute("loginMember");
	        if (member != null) {
	        	System.out.println(member.getMemberId());
	        } else {
	        	System.out.println("로그인 정보가 없습니다.");
	        }
	    } else {
	    	System.out.println("세션이 존재하지 않습니다.");
	    }
	    
		int memberNo = member.getMemberNo();
		
	    String title = request.getParameter("qnaTitle");
		String content = request.getParameter("qnaContent");
		String category = request.getParameter("qnaCategory");
		int visibility = Integer.parseInt(request.getParameter("qnaVisibility"));
		
		Qna qna = new Qna();
		qna.setMemberNo(memberNo);
		qna.setCategory(category);
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
