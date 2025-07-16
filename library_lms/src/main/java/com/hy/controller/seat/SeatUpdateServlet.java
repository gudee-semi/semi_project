package com.hy.controller.seat;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;

import java.io.IOException;
import java.util.*;

import org.apache.ibatis.session.SqlSession;

import com.hy.controller.tablet.MyBatisUtil;
import com.hy.mapper.seat.FixedSeatMapper;

@WebServlet("/admin/fixed-seat-update")
public class SeatUpdateServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 회원번호 목록 가져오기
        Enumeration<String> paramNames = request.getParameterNames();

        try (SqlSession session = MyBatisUtil.getSqlSession(true)) {
            FixedSeatMapper mapper = session.getMapper(FixedSeatMapper.class);

            while (paramNames.hasMoreElements()) {
                String param = paramNames.nextElement();

                if (param.startsWith("seat_")) {
                    int memberNo = Integer.parseInt(param.substring(5));
                    String seatValue = request.getParameter(param);

                    if (seatValue == null || seatValue.isBlank()) {
                        // 좌석 미지정 처리 (NULL로)
                        mapper.updateFixedSeat(memberNo, null);
                    } else {
                        int seatNo = Integer.parseInt(seatValue);
                        mapper.updateFixedSeat(memberNo, seatNo);
                    }
                }
            }

            session.commit();
        }

        response.sendRedirect("fixed-seat"); // 변경 후 목록으로 리다이렉트
    }
}
