package com.hy.controller.seat;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;

import org.json.simple.JSONObject;

import com.hy.dto.Member;
import com.hy.service.seat.SeatService;


@WebServlet("/seat/cancel")
public class SeatCancel extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private SeatService service = new SeatService();   
    
    public SeatCancel() {
        super();
       
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("UTF-8");
		
		// 좌석 번호
		int seatNo = Integer.parseInt(request.getParameter("seatNo"));
		
		// 현재 사용자
		HttpSession session = request.getSession(false);
		
		
		if (session == null || session.getAttribute("loginMember") == null) {
			response.sendRedirect(request.getContentType() + "/");
			return;
		} 
		
		
		Member member = (Member)session.getAttribute("loginMember");
		int memberNo = member.getMemberNo();
		
		
		
		int result = service.cancelSeat(seatNo, memberNo);
		
		JSONObject obj = new JSONObject();
		
		if (result > 0) {
			obj.put("res_code", "200");
			obj.put("res_msg", "좌석 취소 성공");
		} else {
			obj.put("res_code", "500");
			obj.put("res_msg", "좌석 취소 실패");	
		}
		
		response.setContentType("application/json; charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.print(obj);
	}

}
