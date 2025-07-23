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

        // 수동 커밋 모드로 세션 오픈
        try (SqlSession session = MyBatisUtil.getSqlSession(false)) {
            FixedSeatMapper mapper = session.getMapper(FixedSeatMapper.class);

            while (paramNames.hasMoreElements()) {
                String param = paramNames.nextElement();

                if (param.startsWith("seat_")) {
                    int memberNo = Integer.parseInt(param.substring(5));
                    String seatValue = request.getParameter(param);

                    Integer currentSeatNo = mapper.getSeatNoByMemberNo(memberNo);

                    if (seatValue == null || seatValue.isBlank()) {
                        // 좌석 해제
                        if (currentSeatNo != null) {
                            mapper.updateFixedSeat(memberNo, null);
                            seatService.updateSeat(currentSeatNo, null, 1);

                            SeatLog log = new SeatLog();
                            log.setMemberNo(memberNo);
                            log.setSeatNo(null);
                            log.setNowTime(LocalDateTime.now());
                            log.setState(0);
                            seatService.insertSeatLog(log);
                        }
                    } else {
                        int seatNo = Integer.parseInt(seatValue);

                        if (currentSeatNo == null) {
                            // 기존 좌석 없을 때: 단순 할당
                            // 중복 검사
                            boolean isUsed = mapper.isSeatNoUsedByOthers(seatNo, memberNo);
                            if (!isUsed) {
                                mapper.updateFixedSeat(memberNo, seatNo);
                                seatService.updateSeat(seatNo, memberNo, 0);

                                SeatLog log = new SeatLog();
                                log.setMemberNo(memberNo);
                                log.setSeatNo(seatNo);
                                log.setNowTime(LocalDateTime.now());
                                log.setState(1);
                                seatService.insertSeatLog(log);
                            } else {
                                duplicateSeatWarnings.add("회원번호 " + memberNo + " → 좌석 " + seatNo + " (중복)");
                            }
                        } else if (currentSeatNo != seatNo) {
                            // 좌석 변경 시 기존 좌석 비우기 및 고정좌석 테이블도 null 처리
                            boolean isUsed = mapper.isSeatNoUsedByOthers(seatNo, memberNo);
                            if (!isUsed) {
                                mapper.updateFixedSeat(memberNo, null);
                                seatService.updateSeat(currentSeatNo, null, 1);

                                SeatLog logOut = new SeatLog();
                                logOut.setMemberNo(memberNo);
                                logOut.setSeatNo(currentSeatNo);
                                logOut.setNowTime(LocalDateTime.now());
                                logOut.setState(1);
                                seatService.insertSeatLog(logOut);

                                // 새 좌석 할당
                                mapper.updateFixedSeat(memberNo, seatNo);
                                seatService.updateSeat(seatNo, memberNo, 0);

                                SeatLog logIn = new SeatLog();
                                logIn.setMemberNo(memberNo);
                                logIn.setSeatNo(seatNo);
                                logIn.setNowTime(LocalDateTime.now());
                                logIn.setState(0);
                                seatService.insertSeatLog(logIn);
                            } else {
                                duplicateSeatWarnings.add("회원번호 " + memberNo + " → 좌석 " + seatNo + " (중복)");
                            }
                        }
                    }
                }
            }

            if (duplicateSeatWarnings.isEmpty()) {
                session.commit();
            } else {
                session.rollback();
            }
        } catch (Exception e) {
            e.printStackTrace();
            // 필요하면 세션 롤백 추가
        }

        HttpSession httpSession = request.getSession();

        if (!duplicateSeatWarnings.isEmpty()) {
            httpSession.setAttribute("seatUpdateWarnings", duplicateSeatWarnings);
        } else {
            httpSession.setAttribute("seatUpdateSuccess", true);
        }

        response.sendRedirect("fixed-seat");
    }
}
