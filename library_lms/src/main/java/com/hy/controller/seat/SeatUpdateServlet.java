package com.hy.controller.seat;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.*;

import org.apache.ibatis.session.SqlSession;

import com.hy.controller.tablet.MyBatisUtil;
import com.hy.dto.seat.SeatLog;
import com.hy.mapper.seat.FixedSeatMapper;
import com.hy.service.seat.SeatService;

@WebServlet("/admin/fixed-seat-update")
public class SeatUpdateServlet extends HttpServlet {
    private SeatService seatService = new SeatService();

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

                    // ✅ 기존 좌석 번호 가져오기
                    Integer currentSeatNo = mapper.getSeatNoByMemberNo(memberNo);

                    if (seatValue == null || seatValue.isBlank()) {
                        // 좌석 해제
                        if (currentSeatNo != null) {
                            mapper.updateFixedSeat(memberNo, null);
                            
                         // seat 테이블 업데이트
                            seatService.updateSeat(currentSeatNo, null, 0); // 0 = 비어있음

                            // 퇴실 로그 기록
                            SeatLog log = new SeatLog();
                            log.setMemberNo(memberNo);
                            log.setSeatNo(null);
                            log.setNowTime(LocalDateTime.now());
                            log.setState(0); // 퇴실
                            seatService.insertSeatLog(log);
                        }
                    } else {
                        int seatNo = Integer.parseInt(seatValue);

                        // ✅ 좌석 번호가 변경된 경우에만 처리
                        if (currentSeatNo == null || currentSeatNo != seatNo) {
                            // 중복 좌석 검사
                            boolean isUsed = mapper.isSeatNoUsedByOthers(seatNo, memberNo);

                            if (!isUsed) {
                                mapper.updateFixedSeat(memberNo, seatNo);
                                
                             // seat 테이블 업데이트
                                seatService.updateSeat(seatNo, memberNo, 1); // 1 = 사용중

                                // 입실 로그 기록
                                SeatLog log = new SeatLog();
                                log.setMemberNo(memberNo);
                                log.setSeatNo(seatNo);
                                log.setNowTime(LocalDateTime.now());
                                log.setState(1); // 입실
                                seatService.insertSeatLog(log);
                            } else {
                                duplicateSeatWarnings.add("회원번호 " + memberNo + " → 좌석 " + seatNo + " (중복)");
                            }
                        }
                    }
                }
            }

            session.commit();
        }

        // 결과 저장
        HttpSession httpSession = request.getSession();

        if (!duplicateSeatWarnings.isEmpty()) {
            httpSession.setAttribute("seatUpdateWarnings", duplicateSeatWarnings);
        } else {
            httpSession.setAttribute("seatUpdateSuccess", true);
        }

        response.sendRedirect("fixed-seat");
    }
}
