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
  <title>목표 성적 설정</title>
  
  <%-- <script src="<c:url value='/resources/jquery-3.7.1.js'/>"></script> --%>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
  
  <style>
	body {
	  font-family: 'Pretendard', sans-serif;
	  margin: 40px;
	  background-color: #fff;
	  color: #333;
	}
	
	h1 {
	  font-size: 30px;
	  font-weight: bold;
	  text-align: center;
	  margin-bottom: 40px;
	}
	
	.section {
	  width: 860px;
	  margin: 0 auto 28px;
	}
	
	.subject-row {
	  display: flex;
	  align-items: flex-start;
	  margin-bottom: 20px;
	  padding-bottom: 10px;
	  border-bottom: 1px solid #ccc;
	}
	
	.subject-row .subject-title {
	  width: 120px;
	  font-size: 16px;
	  font-weight: 600;
	  margin-top: 4px;
	  flex-shrink: 0;
	}
	
	.checkbox-group {
	  display: flex;
	  flex-wrap: wrap;
	  gap: 30px 20px;
	  font-size: 16px;
	}
	
	input[type="checkbox"] {
	  width: 16px;
	  height: 16px;
	  vertical-align: middle;
	  margin-right: 4px;
	}
	
	.btn {
	  display: block;
	  margin: 40px auto;
	  padding: 10px 22px;
	  border: none;
	  background-color: #205DAC;
	  color: #fff;
	  border-radius: 6px;
	  font-size: 15px;
	  cursor: pointer;
	  transition: 0.2s;
	}
	
	.btn:hover {
	  background-color: #3E7AC8;
	}

	#exam-title {
	  margin-top: 60px;
	  font-size: 24px;
	  font-weight: 600;
	  text-align: center;
	}
	
	#selected-subjects {
	  text-align: center;
	  font-size: 18px;
	  margin-bottom: 16px;
	}
	
	#score-table {
	  margin: 0 auto;
	  border-collapse: collapse;
	  font-size: 18px;
	  width: 720px;
	  background-color: #fff;
	}
	
	#score-table th,
	#score-table td {
	  border: 1px solid #d1d5db;
	  padding: 12px;
	  text-align: center;
	}
	
	.input-center {
	  width: 90px;
	  height: 32px;
	  border: 1px solid #bbb;
	  border-radius: 6px;
	  text-align: center;
	  background-color: #f9fafb;
	  transition: border 0.2s;
	}
	
	.input-center:focus {
	  outline: none;
	  border-color: #2563eb;
	}
	
	#final-submit {
	  margin-top: 28px;
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
<body>


<%@ include file="/views/include/header.jsp" %>
<script>
  // [0] 서버-side 변수 JS로 전달
  const studentGrade = <%= studentGrade %>;
  const memberNo = <%= memberNo %>;
  const currentYear = <%= currentYear%>;

  // [A] 시험 분류 체크박스 활성/비활성
  document.addEventListener('DOMContentLoaded', function() {
    const examCheckboxes = document.querySelectorAll('.exam-type');
    let availableCount = 0;

    examCheckboxes.forEach(cb => {
      const examMonth = parseInt(cb.value, 10);

      // 3월, 6월, 9월은 누구나 가능
      if (examMonth === 3 || examMonth === 6 || examMonth === 9) {
        cb.disabled = false;
        availableCount++;
      }

      // 11월은 3학년만 가능
      else if (examMonth === 11) {
        if (studentGrade === 3) {
          cb.disabled = false;
          availableCount++;
        } else {
          cb.disabled = true;
          cb.checked = false;
        }
      }

      // 기타 (예외적 값) 처리
      else {
        cb.disabled = true;
        cb.checked = false;
      }
    });

    // 선택 가능한 시험이 0개면 안내 메시지 추가
    if (availableCount === 0) {
      const guide = document.createElement('div');
      guide.textContent = "선택 가능한 시험이 없습니다.";
      guide.style = "color:#dc2626; margin:10px 0 0 10%; font-size:16px; font-weight:500;";
      document.getElementById('exam-options').appendChild(guide);
    }
  });
</script>

<!-- D-Day 카드 표시 -->
<jsp:include page="/views/include/d-day.jsp" />

<div class="score-container">
  <h1>목표 성적 설정</h1>
  </div>

<!-- 시험 분류 (3월, 6월, 9월, 11월(수능)) -->
<div class="section">
  <h2>시험 분류</h2>
  <div class="checkbox-group" id="exam-options">
    <c:forEach var="month" items="${examOptions}">
      <c:choose>
        <c:when test="${month == autoExamMonth}">
          <label>
            <input type="checkbox" class="exam-type" name="exam" value="${month}" checked>
            <c:out value="${month}"/>월
            <c:if test="${month == 11}">(수능)</c:if>
          </label>
        </c:when>
        <c:otherwise>
          <label>
            <input type="checkbox" class="exam-type" name="exam" value="${month}">
            <c:out value="${month}"/>월
            <c:if test="${month == 11}">(수능)</c:if>
          </label>
        </c:otherwise>
      </c:choose>
    </c:forEach>
  </div>
</div>

<!-- 필수 과목 (항상 체크/비활성) -->
<div class="section">
  <h3>필수 과목</h3>
  <div class="checkbox-group">
    <label><input type="checkbox" checked disabled> 국어</label>
    <label><input type="checkbox" checked disabled> 수학</label>
    <label><input type="checkbox" checked disabled> 영어</label>
    <label><input type="checkbox" checked disabled> 한국사</label>
  </div>
</div>

<!-- 선택 과목: JSP에서 직접 반복문으로 체크박스와 과목명 출력 -->
<!-- 사회탐구 -->
<div class="section">
  <h3>사회탐구</h3>
  <div class="checkbox-group" id="social-subjects-group">
    <c:forEach var="subject" items="${socialSubjects}">
      <label>
        <input type="checkbox" class="explore-subject social-subject" name="socialSubject" value="${subject}">
        <c:out value="${subject}"/>
      </label>
    </c:forEach>
  </div>
</div>

<!-- 과학탐구1 -->
<div class="section">
  <h3>과학탐구1</h3>
  <div class="checkbox-group" id="science1-subjects-group">
    <c:forEach var="subject" items="${science1Subjects}">
      <label>
        <input type="checkbox" class="explore-subject science-subject" name="science1Subject" value="${subject}">
        <c:out value="${subject}"/>
      </label>
    </c:forEach>
  </div>
</div>

<!-- 과학탐구2: 3학년 + (6,9,11월)에서만 표시 -->
<div class="section" id="science2-section">
  <h3>과학탐구2</h3>
  <div class="checkbox-group">
    <c:forEach var="subject" items="${science2Subjects}">
      <label>
        <input type="checkbox" class="explore-subject science2-subject" name="science2Subject" value="${subject}">
        <c:out value="${subject}"/>
      </label>
    </c:forEach>
  </div>
</div>

<!-- 제2외국어: 3학년 + (6,9,11월)에서만 표시 -->
<div class="section" id="lang2-section">
  <h3>제2외국어</h3>
  <div class="checkbox-group">
    <c:forEach var="subject" items="${lang2Subjects}">
      <label>
        <input type="checkbox" class="lang2-subject" name="lang2Subject" value="${subject}">
        <c:out value="${subject}"/>
      </label>
    </c:forEach>
  </div>
</div>

<button id="confirm-subjects" class="btn">선택완료</button>

<!-- 선택 과목/점수 입력 영역 -->
<h2 id="exam-title"></h2>
<div id="selected-subjects"></div>

<table id="score-table">
  <thead>
    <tr><th>과목</th><th>원점수</th><th>등급</th></tr>
  </thead>
  <tbody id="score-body"></tbody>
</table>


<!-- 모달창 -->
<div id="modal">
  <div class="modal-content">
    <p id="modal-message"></p>
    <button id="modal-close-btn">확인</button>
  </div>
</div>

<!-- js 연동 -->
<script src="../../js/goal_score.js"></script>

<!-- 입력 완료 버튼은 점수 테이블 아래에 위치 -->
<div style="text-align:center;">
  <button id="final-submit" class="btn">설정완료</button>
</div>

<%@ include file="/views/include/footer.jsp" %>
</body>
</html>
