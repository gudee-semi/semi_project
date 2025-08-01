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
		
		Member member = (Member)session.getAttribute("loginMember");
		
	    if (session != null) {
	        if (member != null) {
	        } else {
	        	response.sendRedirect(request.getContextPath()+"/");
	        	return;
	        }
	    } else {
	    	response.sendRedirect(request.getContextPath()+"/");
	    	return;
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
		
		String ext = "pass";
		if (attach != null) {
			int loc = attach.getOriName().lastIndexOf(".");
			ext = attach.getOriName().substring(loc + 1);			
		}
		
		int result = -1;
		
		if (ext.equals("png") || ext.equals("jpg") || ext.equals("pass")) {
			if ("CODE_REJECT_BAD_WORD".equals(title) || "CODE_REJECT_BAD_WORD".equals(content)) {
				result = -2;
			} else {				
				result = qnaService.createQnaWithAttach(qna,attach);	
			}
		}
		
		JSONObject obj = new JSONObject();
		
		if (result > 0) {
			obj.put("res_code", "200");
		} else if (result == 0) {
			obj.put("res_code", "500");			
		} else if (result == -1) {
			obj.put("res_code", "999");
		} else {
			obj.put("res_code", "998");
		}
		
		response.setContentType("application/json; charset=utf-8");
		response.getWriter().print(obj);
	}

}
