package com.hy.controller.qna;

import java.io.IOException;
import java.util.List;

import com.hy.dto.qna.QnaAdmin;
import com.hy.service.qna.QnaAdminService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/qna/list/admin")
public class QnaListAdminServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private QnaAdminService qnaAdminService = new QnaAdminService();

    public QnaListAdminServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	

    List<QnaAdmin> qnaAdminList = qnaAdminService.selectAll();
    request.setAttribute("qnaAdminList", qnaAdminList);

    request.getRequestDispatcher("/views/qna/list/admin.jsp").forward(request, response);
	
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
