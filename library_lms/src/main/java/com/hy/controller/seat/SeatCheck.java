package com.hy.controller.seat;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

import com.hy.dto.Member;
import com.hy.dto.seat.Seat;
import com.hy.service.seat.SeatService;


@WebServlet("/seat/view")
public class SeatCheck extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private SeatService service = new SeatService();   
   
    public SeatCheck() {
        super();
        
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// 1. 사용자 정보 가져오기
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
		request.setAttribute("memberNo", memberNo);
		
		
		// 2. DB 조회해서 전체 좌석목록 가져오기
		// 1. dto 작성(완) -> 2. service 작성 -> 3. dao 작성 -> 4. mapper 인터페이스 작성 -> 5. mapper xml 작성
		
		List<Seat> list = service.selectAllSeat();
		Seat currentSeat = service.getSeatByMember(memberNo);
		
		request.setAttribute("list", list);
		request.setAttribute("currentUsedSeatNo", currentSeat != null ? currentSeat.getSeatId() : null);
		
		request.getRequestDispatcher("/views/seat/seatPage.jsp").forward(request, response);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doGet(request, response);
	}

}
