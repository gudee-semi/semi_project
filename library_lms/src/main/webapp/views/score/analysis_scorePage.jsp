<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.hy.dto.Member" %>
<%
  // 로그인한 사용자 정보 세션에서 가져오기
  Member loginMember = (Member) session.getAttribute("loginMember");
  int memberNo = (loginMember != null) ? loginMember.getMemberNo() : -1;
  int studentGrade = (loginMember != null) ? loginMember.getMemberGrade() : 1;
  
  // studentGrade를 request로 d-day.jsp에 넘기기
  request.setAttribute("studentGrade", studentGrade);

  // 현재 년도 계산 후 세션에 저장 (필요 시 js에서 연도 표기용으로 사용 가능)
  int currentYear = java.util.Calendar.getInstance().get(java.util.Calendar.YEAR);
  session.setAttribute("currentYear", currentYear);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>성적 조회 및 분석</title>

 	<!-- jQuery CDN -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

  <style>
    /* 기본 스타일 설정 */
    body { font-family: 'Pretendard', sans-serif; margin: 40px; background: #fff; }
    h1 { text-align: center; font-size: 22px; font-weight: bold; margin-bottom: 30px; }
    .checkbox-group {
      display: flex; flex-wrap: wrap; gap: 15px 30px; margin: 0 10%;
      align-items: center;
    }
    label { font-size: 16px; }
    .exam-type { margin: 0 10px; }
    table { margin: 0 auto; border-collapse: collapse; font-size: 16px;}
    th, td { border: 1px solid #d1d5db; padding: 10px 18px; text-align: center;}
    #exam-title { text-align: center; margin-top: 42px; font-size: 18px;}
    #selected-subjects { text-align: center; margin-bottom: 20px; font-size: 16px;}
    #score-table { margin: 30px auto 0 auto; width: 70%; min-width: 520px; border-collapse: collapse; font-size: 17px; background: #fff; }
    #score-table th, #score-table td { border: 1px solid #bbb; padding: 20px 0; text-align: center; }
    #modal { display: none; position: fixed; top: 0; left: 0; width: 100vw; height: 100vh; background: rgba(0,0,0,0.32); z-index: 999; }
    .modal-content { background: #fff; padding: 24px; margin: 22% auto 0; width: 320px; border-radius: 10px; text-align: center; box-shadow: 0 6px 30px #2222; }
    #modal-close-btn { margin-top: 18px; padding: 7px 22px; border: none; background: #3b82f6; color: #fff; border-radius: 4px; font-size: 16px;}
  </style>

</head>

<script>
  // [0] 서버-side 변수 JS로 전달
  const studentGrade = <%= studentGrade %>;
  const memberNo = <%= memberNo %>;
  const currentYear = <%= currentYear%>;
</script>


<body>
<!-- 로그인 정보 숨겨서 JS에서 참조 -->
<input type="hidden" id="studentGrade" value="<%= studentGrade %>">
<input type="hidden" id="memberNo" value="<%= memberNo %>">

<!-- D-Day 카드 표시 -->
<jsp:include page="/views/include/d-day.jsp" />

<h1>성적 조회 및 분석</h1>


<!-- 시험 분류 체크박스 동적 생성 -->
<div class="checkbox-group" id="exam-options">
  <span style="font-weight: 500;">시험 분류</span>
 <c:forEach var="exam" items="${examTypeList}">
  <label>
    <input type="checkbox" name="exam" class="exam-type" value="${exam.examTypeId}" />
    ${exam.examType}월
  </label>
 </c:forEach>
</div>

<!-- 선택된 시험 제목 표시 영역 -->
<div id="exam-title"></div>

<!-- 선택된 과목 목록 표시 영역 -->
<div id="selected-subjects"></div>

<!-- 삭제 버튼ㄴ-->
<button id="delete-submit" class="btn">삭제하기</button>

<!-- 별도 JS 파일 불러오기 -->
<script src="../../js/analysis_score.js"></script>

<!-- Chart.js CDN 추가 -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<!-- 성적 테이블을 삽입할 위치 -->
<div id="score-table-wrapper"></div>

<!-- 차트 캔버스 -->
<div id="chart-area" style="display: flex; justify-content: space-between; margin-top: 30px;">
  <!-- 막대 차트 -->
  <div style="width: 48%;">
    <canvas id="scoreComparisonChart" style="width: 100%; height: 300px;"></canvas>
  </div>

  <!-- 레이더 차트 -->
  <div style="width: 48%;">
    <canvas id="scoreRadarChart" style="width: 100%; height: 300px;"></canvas>
  </div>
</div>

</body>
</html>