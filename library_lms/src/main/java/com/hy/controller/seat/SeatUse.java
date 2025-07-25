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

/**
 * Servlet implementation class SeatUse
 */
@WebServlet("/seat/use")
public class SeatUse extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private SeatService service = new SeatService();
       
    
    public SeatUse() {
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
		int memberNo = 0; // 여기는 세선에서 값을 가져오도록!!
		
		if (session == null) {
			response.sendRedirect(request.getContentType() + "/");
			return;
		} else {
			if (session.getAttribute("loginMember") == null) {
				response.sendRedirect(request.getContextPath() + "/");
				return;
			} else {
				Member member = (Member)session.getAttribute("loginMember");
				memberNo = member.getMemberNo();
			}
		}
		
		int result = service.useSeat(seatNo, memberNo);
		
		JSONObject obj = new JSONObject();
		
		if (result > 0) {
			obj.put("res_code", "200");
			obj.put("res_msg", "좌석 사용 성공");
		} else {
			obj.put("res_code", "500");
			obj.put("res_msg", "좌석 사용 실패");	
		}
		
		response.setContentType("application/json; charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.print(obj);
		
		// 좌석 사용 처리 로직 끝에 추가
		SeatLog log = new SeatLog();
		log.setMemberNo(memberNo);  // 세션에서 받아온 로그인 유저
		log.setSeatNo(Integer.parseInt(request.getParameter("seatNo")));
		log.setNowTime(LocalDateTime.now()); // java.time 사용
		log.setState(1);  // 입실

		service.insertSeatLog(log);  // MyBatis 매퍼로 INSERT

	}

}
