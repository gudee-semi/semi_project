package com.hy.controller.seat;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDateTime;

import org.json.simple.JSONObject;

import com.hy.dto.Member;
import com.hy.dto.seat.SeatLog;
import com.hy.service.seat.SeatService;


@WebServlet("/seat/change")
public class SeatChange extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private SeatService service = new SeatService();   
   
    public SeatChange() {
        super();
       
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("application/json; charset=UTF-8");
		
		int oldSeatNo = 0;
		int newSeatNo = 0;
		
		try {
			oldSeatNo = Integer.parseInt(request.getParameter("oldSeatNo"));
			newSeatNo = Integer.parseInt(request.getParameter("newSeatNo"));
			
		} catch (NumberFormatException e) {
			response.sendError(HttpServletResponse.SC_BAD_REQUEST, "잘못된 좌석 번호입니다.");
			return;
			
		}
		
		// 세션에서 사용자 확인
		HttpSession session = request.getSession(false);
		if(session == null || session.getAttribute("loginMember") == null ) {
			response.sendRedirect(request.getContextPath() + "/");
			return;
		}
		
		Member member = (Member) session.getAttribute("loginMember");
		int memberNo = member.getMemberNo();
		
		// 서비스 호출
		SeatService service = new SeatService();
		int result = service.changeSeat(oldSeatNo, newSeatNo, memberNo);
		
		JSONObject obj = new JSONObject();
	    if (result > 0) {
	        obj.put("res_code", "200");
	        obj.put("res_msg", "좌석 변경 성공");
	    } else {
	        obj.put("res_code", "500");
	        obj.put("res_msg", "좌석 변경 실패");
	    }

	    response.setContentType("application/json; charset=UTF-8");
	    try (PrintWriter out = response.getWriter()) {
	        out.print(obj.toJSONString());
	}
	 // 1. 이전 좌석 퇴실 로그
	    SeatLog oldLog = new SeatLog();
	    oldLog.setMemberNo(memberNo);
	    oldLog.setSeatNo(oldSeatNo);
	    oldLog.setNowTime(LocalDateTime.now());
	    oldLog.setState(0);  // 퇴실
	    service.insertSeatLog(oldLog);

	    // 2. 새 좌석 입실 로그
	    SeatLog newLog = new SeatLog();
	    newLog.setMemberNo(memberNo);
	    newLog.setSeatNo(newSeatNo);
	    newLog.setNowTime(LocalDateTime.now());
	    newLog.setState(1);  // 입실
	    service.insertSeatLog(newLog);

	}
}