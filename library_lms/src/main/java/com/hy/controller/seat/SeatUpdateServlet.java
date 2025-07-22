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

        Enumeration<String> paramNames = request.getParameterNames();
        List<String> duplicateSeatWarnings = new ArrayList<>();

        try (SqlSession session = MyBatisUtil.getSqlSession(true)) {
            FixedSeatMapper mapper = session.getMapper(FixedSeatMapper.class);

            while (paramNames.hasMoreElements()) {
                String param = paramNames.nextElement();

                if (param.startsWith("seat_")) {
                    int memberNo = Integer.parseInt(param.substring(5));
                    String seatValue = request.getParameter(param);

                    if (seatValue == null || seatValue.isBlank()) {
                        // 좌석 해제
                        mapper.updateFixedSeat(memberNo, null);
                    } else {
                        int seatNo = Integer.parseInt(seatValue);

                        // ✅ 중복 좌석 검사
                        boolean isUsed = mapper.isSeatNoUsedByOthers(seatNo, memberNo);

                        if (!isUsed) {
                            mapper.updateFixedSeat(memberNo, seatNo);
                        } else {
                            // 중복 발생한 좌석 정보 기록
                            duplicateSeatWarnings.add("회원번호 " + memberNo + " → 좌석 " + seatNo + " (중복)");
                        }
                    }
                }
            }

            session.commit();
        }

     // ✅ 성공 또는 실패 여부 저장
        HttpSession httpSession = request.getSession();

        if (!duplicateSeatWarnings.isEmpty()) {
            httpSession.setAttribute("seatUpdateWarnings", duplicateSeatWarnings);
        } else {
            httpSession.setAttribute("seatUpdateSuccess", true); // ✅ 성공 alert용 플래그
        }

        response.sendRedirect("fixed-seat"); // 목록으로 이동
    }
}
