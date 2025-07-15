<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
  // [1] 로그인 대신 예시 세션 설정 (실서비스에서는 로그인에서 세팅)
  session.setAttribute("memberNo", 2);           // 로그인된 회원번호
  session.setAttribute("studentGrade", 1);       // 🔁 1학년으로 변경

  int studentGrade = (session.getAttribute("studentGrade") != null) 
                      ? (Integer) session.getAttribute("studentGrade") : 1;

  Integer memberNo = (Integer) session.getAttribute("memberNo");
  if (memberNo == null) memberNo = -1;

  int currentYear = java.util.Calendar.getInstance().get(java.util.Calendar.YEAR);
  session.setAttribute("currentYear", currentYear); // 현재 연도 세션 저장
%>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>목표 성적 설정</title>
  <%-- <script src="<c:url value='/resources/jquery-3.7.1.js'/>"></script> --%>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
  <style>
    body { font-family: 'Pretendard', sans-serif; margin: 40px; background: #fff; }
    h1 { text-align: center; font-size: 22px; font-weight: bold; margin-bottom: 30px; }
    h2, h3 { text-align: left; font-size: 18px; font-weight: bold; margin: 24px 0 8px 10%; }
    .section { margin-bottom: 24px; }
    .checkbox-group {
      display: flex; flex-wrap: wrap; gap: 15px 30px; margin: 0 10%;
      align-items: center;
    }
    label { font-size: 16px; }
    .btn {
      display: block; margin: 35px auto 0; padding: 10px 24px;
      border: 1.5px solid #3b82f6; background: white;
      color: #3b82f6; border-radius: 6px; font-weight: 500;
      font-size: 16px; cursor: pointer; transition: .2s;
    }
    .btn:hover { background: #3b82f6; color: white; }
    table { margin: 0 auto; border-collapse: collapse; font-size: 16px;}
    th, td { border: 1px solid #d1d5db; padding: 10px 18px; text-align: center;}
    #exam-title { text-align: center; margin-top: 42px; font-size: 18px;}
    #selected-subjects { text-align: center; margin-bottom: 20px; font-size: 16px;}
    #score-table {  margin: 30px auto 0 auto;  width: 70%;  min-width: 520px;  border-collapse: collapse;  font-size: 17px; background: #fff; }
	#score-table th, #score-table td {  border: 1px solid #bbb;  padding: 20px 0;  text-align: center; }
	.input-center {  width: 110px;  height: 34px;  font-size: 17px;  text-align: center;  border: 1.5px solid #bbb;  border-radius: 6px;  margin: 0 auto;  display: block;  background: #fafcff;  transition: border 0.18s; }
	.input-center:focus {  outline: none;  border: 1.5px solid #3b82f6; }
    #modal { display: none; position: fixed; top: 0; left: 0; width: 100vw; height: 100vh; background: rgba(0,0,0,0.32); z-index: 999; }
    .modal-content { background: #fff; padding: 24px; margin: 22% auto 0;  width: 320px; border-radius: 10px; text-align: center;  box-shadow: 0 6px 30px #2222;  }
    #modal-close-btn { margin-top: 18px; padding: 7px 22px; border: none; background: #3b82f6; color: #fff; border-radius: 4px; font-size: 16px;}
  </style>
</head>
<body>

<script>
  // [0] 서버-side 변수 JS로 전달
  const studentGrade = <%= studentGrade %>;
  const memberNo = <%= memberNo %>;
  const currentYear = <%= currentYear %>;

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


<h1>목표 성적 설정</h1>

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

<button id="confirm-subjects" class="btn" style="margin-bottom:24px;">선택완료</button>

<!-- 선택 과목/점수 입력 영역 -->
<h2 id="exam-title" style="display:block;"></h2>
<div id="selected-subjects"></div>
<table id="score-table" style="display:none;">
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

<script src="../../js/goal_score.js"></script>

<!-- 입력 완료 버튼은 점수 테이블 아래에 위치 -->
<div style="width:70%;margin:28px auto 0;text-align:center;">
  <button id="final-submit" class="btn" style="display:none;">설정완료</button>
</div>

</body>
</html>
