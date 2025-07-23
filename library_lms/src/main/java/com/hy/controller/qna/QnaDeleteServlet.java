package com.hy.controller.qna;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

import org.json.simple.JSONObject;

import com.hy.service.qna.QnaService;

@WebServlet("/qna/delete")
public class QnaDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private QnaService qnaService = new QnaService();
       
    public QnaDeleteServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		int qnaId = Integer.parseInt(request.getParameter("no"));
		
		int result = qnaService.deleteQna(qnaId);
		
		JSONObject obj = new JSONObject();
		
		if (result > 0) {
			obj.put("res_code", "200");
		} else {
			obj.put("res_code", "500");			
		}
		
		response.setContentType("application/json; charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.print(obj);
		
	}

}
