<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
    	.sidebars {
		width: 250px;
		height: 1000px;
	}
	
	.flex-container {
		display: flex;
		align-items: flex-start;
  		column-gap: 40px;
	}
	
	.container {
		width: 70%;
	}
	
	.calendar-icon {
		font-size: 30px;
	}
	
	/*  하...   */
	header {
		margin: 0 !important;
	}
	
	h1 {
		margin-top: 50px;
	}
	
	footer {
		margin-top: 0px !important;
	}
  
    body {
	  font-family: 'Pretendard', sans-serif;
	  margin: 40px;
	  background-color: #fff;
	  color: #333;
	}
	
	h1 {
	  font-size: 34px;
	  font-weight: bold;
	  text-align: center;
	  margin: 80px auto 50px auto;
	}
	
	.section {
	  width: 860px;
	  margin: 0 auto 28px;
	}
	
    .checkbox-group {
      display: flex;
      justify-content: center;
      flex-wrap: wrap;
      gap: 32px 40px;
      font-size: 18px;
      align-content: space-around;
      align-items: center;
    }
    
    input[type="checkbox"] {
	  width: 16px;
	  height: 16px;
	  vertical-align: middle;
	  margin-right: 4px;
	}
     
    .exam-type { 
       margin: 0 10px;
     }
     
     #exam-title {
	  margin-top: 80px;
	  font-size: 23px;
	  font-weight: 600;
	  text-align: center;
	}
	
	#selected-subjects {
	  text-align: center;
	  font-size: 18px;
	  margin-bottom: 40px;
	}
   /*   
    table { 
      margin: 60px auto;
	  border-collapse: separate;  
	  border-spacing: 0;           
	  font-size: 20px;
	  width: 720px;
	  background-color: #fff;
	  border: 1px solid #d1d5db; 
	  border-radius: 10px;    
	  overflow: hidden;
    }
     
    th, td { 
      border: 1px solid #d1d5db; 
      padding: 10px 18px; 
      height: 45px;
      font-weight: 500;
      text-align: center;
    } */
    
	#score-table {
     margin: 60px auto;
	  border-collapse: separate;  
	  border-spacing: 0;           
	  font-size: 20px;
	  width: 950px;
	  background-color: #fff;
	  border: 1px solid #d1d5db; 
	  border-radius: 10px;    
	  overflow: hidden;
     }
     
	#score-table th,
	#score-table td {
	  border: 1px solid #d1d5db; 
	  padding: 18px;
	  text-align: center;
	}
	
	.btn {
	  display: block;
	  margin: 0 auto;
	  padding: 10px 22px;
	  border: none;
	  background-color: #D8E5F4;
	  color: #808080;
	  border-radius: 10px;
	  font-size: 15px;
	  cursor: pointer;
	  transition: 0.2s;
	}
	
	.btn:hover {
	  background-color: #CCD7E3;
	}
	
	#delete-submit {
	  display: none;
	}
	
	#chart-area {
	  display: flex;
      justify-content: center;
      margin-top: 95px;
      column-gap: 190px;
      margin-bottom: 130px;
	}
	
	#scoreComparisonChart {
	  width: 500px; 
	  height: 500px; 
	  margin-top: 80px;
	}
	
	#scoreRadarChart {
	  width: 440px; 
	  height: 440px; 
	}
	
	.bar-chart-container canvas,
	.radar-chart-container canvas {
	  width: 100%;
	  height: 100%;
	  box-sizing: border-box;
	  display: block;
	}

	
   #modal {
	  display: none;
	  position: fixed;
	  top: 0; left: 0;
	  width: 100vw; height: 100vh;
	  background: rgba(0,0,0,0.4);
	  z-index: 999;
	}
	
	.modal-content {
	  background: #fff;
	  padding: 20px;
	  margin: 18% auto;
	  width: 320px;
	  border-radius: 10px;
	  text-align: center;
	  box-shadow: 0 6px 24px rgba(0,0,0,0.2);
	}
	
	#modal-close-btn {
	  margin-top: 16px;
	  padding: 6px 20px;
	  border: none;
	  background: #2563eb;
	  color: #fff;
	  border-radius: 6px;
	}
  </style>

</head>

<script>
  // [0] 서버-side 변수 JS로 전달
  const studentGrade = <%= studentGrade %>;
  const memberNo = <%= memberNo %>;
  const currentYear = <%= currentYear%>;
</script>


<body>

<%@ include file="/views/include/header.jsp" %>

<div class="flex-container">
  <div class="sidebars"><%@ include file="/views/include/sidebar.jsp" %></div>
  <div class="container">
	<!-- 로그인 정보 숨겨서 JS에서 참조 -->
	<input type="hidden" id="studentGrade" value="<%= studentGrade %>">
	<input type="hidden" id="memberNo" value="<%= memberNo %>">
	
	<!-- D-Day 카드 표시 -->
	<jsp:include page="/views/include/d-day.jsp" />
	
	<h1>성적 조회 및 분석</h1>
	
	<!-- 시험 분류 체크박스 동적 생성 -->
	<div class="section">
	  <div class="checkbox-group" id="exam-options">
	    <h3>시험 분류</h3>
	      <c:forEach var="exam" items="${examTypeList}">
	        <label>
	          <input type="checkbox" name="exam" class="exam-type" value="${exam.examTypeId}" />${exam.examType}월
	        </label>
	    </c:forEach>
	  </div>
	</div>
	
	
	<!-- 선택 과목/점수 입력 영역 -->
	<h2 id="exam-title"> </h2>
	
	<!-- 선택된 과목 목록 표시 영역 -->
	<div id="selected-subjects"></div>
	
	<!-- 성적 테이블을 삽입할 위치 -->
	<div id="score-table-wrapper"></div>
	
	<!-- 삭제하기 버튼 -->
	<div style="text-align: center;">
	  <button id="delete-submit" class="btn">삭제하기</button>
	</div>
	
	<!-- 별도 JS 파일 불러오기 -->
	<script src="../../js/analysis_score.js"></script>
	
	<!-- Chart.js CDN 추가 -->
	<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
	
	<!-- 차트 영역 -->
	<div id="chart-area">
	  <!-- 막대 차트 -->
	  <div class="bar-chart-container">
	    <canvas id="scoreComparisonChart"></canvas>
	  </div>
	
	<!-- 레이더 차트 -->
	  <div class="radar-chart-container">
	    <canvas id="scoreRadarChart"></canvas>
	  </div>
	</div>	
  </div>
</div>

<!-- footer 삽입 -->
<%@ include file="/views/include/footer.jsp" %>

</body>
</html>