package com.hy.controller.mypage;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;

import org.json.simple.JSONObject;

import com.hy.dto.login.ProfileAttach;
import com.hy.service.mypage.MyPageService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Servlet implementation class fileDealWith
 */
@WebServlet("/file/DealWith")
public class fileDealWith extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private MyPageService service = new MyPageService(); 
    /**
     * @see HttpServlet#HttpServlet()
     */
    public fileDealWith() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		int memberNo = Integer.parseInt(request.getParameter("memberNo"));
		ProfileAttach attach = service.selectProfileAttach(memberNo);
		JSONObject obj = new JSONObject();
		if(attach!=null) {
			String path = attach.getPath();
			String oriname= attach.getOriName();
			obj.put("path",path );
			obj.put("oriname", oriname);
		}
		response.setContentType("application/json; charset=utf-8");
		response.getWriter().print(obj);
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
