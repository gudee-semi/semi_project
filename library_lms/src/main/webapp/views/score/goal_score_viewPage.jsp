<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%
  // [1] 로그인 대신 예시 세션 설정 (실서비스에서는 로그인에서 세팅)
  session.setAttribute("memberNo", 2);
  session.setAttribute("studentGrade", 3);
  int studentGrade = (session.getAttribute("studentGrade") != null) ? (Integer) session.getAttribute("studentGrade") : 1;
  Integer memberNo = (Integer) session.getAttribute("memberNo");
  if (memberNo == null) memberNo = -1;
  int currentYear = java.util.Calendar.getInstance().get(java.util.Calendar.YEAR);
  session.setAttribute("currentYear", currentYear);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>목표 성적 조회</title>
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
/*     .btn {
      display: block; margin: 35px auto 0; padding: 10px 24px;
      border: 1.5px solid #3b82f6; background: white;
      color: #3b82f6; border-radius: 6px; font-weight: 500;
      font-size: 16px; cursor: pointer; transition: .2s;
    }
    .btn:hover { background: #3b82f6; color: white; } */
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

  // [A] 시험 분류 체크박스 활성/비활성 (지나간 시험 비활성화 & 안내문구 추가) ---------
  document.addEventListener('DOMContentLoaded', function() {
    const now = new Date();
    const nowMonth = now.getMonth() + 1; // JS 0~11, 실제는 1~12
    const examCheckboxes = document.querySelectorAll('.exam-type');
    let availableCount = 0;

    examCheckboxes.forEach(cb => {
      const examMonth = parseInt(cb.value, 10);
      if (examMonth < nowMonth) {
        cb.disabled = true;
        cb.checked = false;
      } else {
        cb.disabled = false;
        availableCount++;
      }
    });

    // 3학년: 10~12월이면 11월만 선택 가능
    if (studentGrade === 3 && nowMonth >= 10 && nowMonth <= 12) {
      examCheckboxes.forEach(cb => {
        if (cb.value !== '11') {
          cb.disabled = true;
          cb.checked = false;
        } else if (cb.value === '11') {
          cb.disabled = false;
          cb.checked = true;
        }
      });
      availableCount = 1;
    } 
    // 1,2학년: 10~12월이면 전부 불가
    else if ((studentGrade === 1 || studentGrade === 2) && nowMonth >= 10 && nowMonth <= 12) {
      examCheckboxes.forEach(cb => {
        cb.disabled = true;
        cb.checked = false;
      });
      availableCount = 0;
    }

    // 선택 가능한 시험이 0개면 안내
    if (availableCount === 0) {
      const guide = document.createElement('div');
      guide.textContent = "선택 가능한 시험이 없습니다.";
      guide.style = "color:#dc2626; margin:10px 0 0 10%; font-size:16px; font-weight:500;";
      document.getElementById('exam-options').appendChild(guide);
    }
  });
</script>

<h1>목표 성적 조회</h1>

<!-- 시험 분류 -->
<div class="section">
  <h2>시험 분류</h2>
  <div class="checkbox-group" id="exam-options">
    <c:forEach var="month" items="${examOptions}">
      <label>
        <input type="radio" class="exam-type" name="exam" value="${month}"
          <c:if test="${month == autoExamMonth}">checked</c:if>> ${month}월
        <c:if test="${month == 11}">(수능)</c:if>
      </label>
    </c:forEach>
  </div>
</div>

<!-- 출력 영역 -->
<h2 id="exam-title" style="display: none;"></h2>
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

<!-- JS 변수 전달 -->
<script>
  const memberNo = <%= memberNo %>;
  const studentGrade = <%= studentGrade %>;
  const currentYear = <%= currentYear %>;
</script>

<!-- 외부 JS -->
<script src="../../js/goal_score_view.js"></script>


</body>
</html>