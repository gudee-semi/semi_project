package com.hy.controller.seat;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.hy.controller.tablet.MyBatisUtil;
import com.hy.dto.seat.FixedSeatMemberView;
import com.hy.mapper.seat.FixedSeatMapper;


@WebServlet("/admin/fixed-seat")
public class AdminFixedSeatServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
    public AdminFixedSeatServlet() {
        super();
       
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		
		try(SqlSession session = MyBatisUtil.getSqlSession(true)){
			FixedSeatMapper mapper = session.getMapper(FixedSeatMapper.class);
			List<FixedSeatMemberView> list = mapper.selectAllFixedSeatMembers();
			
			for (FixedSeatMemberView m : list) {
			    if (m == null) continue; // null 방어
			    
			}

			 System.out.println("조회된 고정좌석 회원 수: " + (list != null ? list.size() : "null"));
			 for (FixedSeatMemberView m : list) {
				    
				}
			request.setAttribute("list", list);
			request.getRequestDispatcher("/views/admin/fixed_seat_member_list.jsp").forward(request, response);
		}
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doGet(request, response);
	}

}
