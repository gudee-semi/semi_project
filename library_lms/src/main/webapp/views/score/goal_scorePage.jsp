<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
  // [1] 로그인 대신 예시 세션 설정 (실서비스에서는 로그인에서 세팅)
  session.setAttribute("memberNo", 2);
  session.setAttribute("studentGrade", 3);
  int studentGrade = (session.getAttribute("studentGrade") != null) ? (Integer) session.getAttribute("studentGrade") : 1;
  Integer memberNo = (Integer) session.getAttribute("memberNo");
  if (memberNo == null) memberNo = -1;
  int currentYear = java.util.Calendar.getInstance().get(java.util.Calendar.YEAR);
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>목표 성적 설정</title>
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

<!-- 세부목표 입력 영역 완전 삭제! -->

<!-- 모달창 -->
<div id="modal">
  <div class="modal-content">
    <p id="modal-message"></p>
    <button id="modal-close-btn">확인</button>
  </div>
</div>

<script>
document.addEventListener('DOMContentLoaded', function() {
  // -----------------------------
  // [1] 시험 분류 1개만 선택(radio처럼)
  // -----------------------------
  function toggleExtraSubjectsSection() {
    const examChecked = document.querySelector('.exam-type:checked');
    const selectedMonth = examChecked ? examChecked.value : null;
    // 3학년 + (6/9/11)일 때만 추가 과목 표시
    if (studentGrade === 3 && ['6','9','11'].includes(selectedMonth)) {
      document.getElementById('science2-section').style.display = '';
      document.getElementById('lang2-section').style.display = '';
    } else {
      document.getElementById('science2-section').style.display = 'none';
      document.getElementById('lang2-section').style.display = 'none';
      // 숨길 때 해당 체크 해제
      document.querySelectorAll('.science2-subject, .lang2-subject').forEach(cb => cb.checked = false);
    }
  }
  // radio처럼 체크
  document.querySelectorAll('.exam-type').forEach(cb => {
    cb.addEventListener('change', function() {
      document.querySelectorAll('.exam-type').forEach(other => {
        if (other !== cb) other.checked = false;
      });
      toggleExtraSubjectsSection();
    });
  });
  toggleExtraSubjectsSection(); // 최초 호출

  // -----------------------------
  // [2] 사회/과학탐구(1,2 합산) 최대 2개 + 제2외국어 1개만 선택(체크 자체 제한)
  // -----------------------------
  function setupCombinedLimit() {
    // 탐구(사회/과학1/과학2) 모두 explore-subject 클래스
    const exploreCheckboxes = document.querySelectorAll('.explore-subject');
    function countChecked() { return Array.from(exploreCheckboxes).filter(cb => cb.checked).length; }
    exploreCheckboxes.forEach(cb => {
      cb.addEventListener('change', function(e) {
        if (cb.checked && countChecked() > 2) {
          // 초과시 바로 해제 + 알림
          cb.checked = false;
          showModal("사회/과학탐구 과목은 합쳐서 최대 2개까지 선택 가능합니다.");
        }
      });
    });
    // 제2외국어(1개만) - lang2-subject 클래스
    const lang2Checkboxes = document.querySelectorAll('.lang2-subject');
    function countLang2() { return Array.from(lang2Checkboxes).filter(cb => cb.checked).length; }
    lang2Checkboxes.forEach(cb => {
      cb.addEventListener('change', function() {
        if (cb.checked && countLang2() > 1) {
          cb.checked = false;
          showModal("제2외국어는 1개만 선택 가능합니다.");
        }
      });
    });
  }
  setupCombinedLimit();

  // -----------------------------
  //[3] 선택완료 클릭 시 과목 선택 확인/테이블 출력
  // -----------------------------
  document.getElementById('confirm-subjects').addEventListener('click', () => {
    const selectedMonth = document.querySelector('.exam-type:checked')?.value;
    if (!selectedMonth) return showModal('시험 분류를 선택해주세요.');
    const selected = ['국어','수학','영어','한국사'];
    document.querySelectorAll('.explore-subject:checked, .lang2-subject:checked')
      .forEach(cb => selected.push(cb.value));
    if (selected.length < 5) return showModal('탐구/선택 과목을 1개 이상 선택해주세요.');

    // 기존 점수 테이블 등 표시
    const titleString = `${currentYear}년 ${selectedMonth}월 모의고사`;
    document.getElementById('exam-title').textContent = titleString;
    document.getElementById('exam-title').style.display = 'block';
    document.getElementById('selected-subjects').textContent = selected.join(' | ');
    document.getElementById('score-body').innerHTML = selected.map(sub => `
      <tr>
        <td>${sub}</td>
        <td><input type="number" class="score-input" data-subject="${sub}" min="0" max="100" placeholder="입력"></td>
        <td><input type="number" class="grade-input" data-subject="${sub}" min="1" max="9" placeholder="입력"></td>
      </tr>`).join('');
    document.getElementById('score-table').style.display = 'table';

    // ★ 설정완료 버튼 표시!
    document.getElementById('final-submit').style.display = 'inline-block';

    setScoreInputValidation();
  });

  // -----------------------------
  // [4] 점수/등급 입력값 유효성(포커스아웃)
  // -----------------------------
  function setScoreInputValidation() {
    document.querySelectorAll('.score-input').forEach(input => {
      input.addEventListener('blur', function() {
        if (this.value && (this.value < 0 || this.value > 100))
          showModal("조건 이외의 숫자를 입력했습니다. (0~100)");
      });
    });
    document.querySelectorAll('.grade-input').forEach(input => {
      input.addEventListener('blur', function() {
        if (this.value && (this.value < 1 || this.value > 9))
          showModal("조건 이외의 숫자를 입력했습니다. (1~9)");
      });
    });
  }

  // -----------------------------
  // [6~8] 설정완료 클릭 시 저장/읽기전용 변환/모달 (한 번만!)
  // -----------------------------
  function showModal(msg) {
    document.getElementById('modal-message').textContent = msg;
    document.getElementById('modal').style.display = 'block';
  }
  document.getElementById('modal-close-btn').onclick = () => {
    document.getElementById('modal').style.display = 'none';
  };

  document.getElementById('final-submit').addEventListener('click', function() {
    let isValid = true;
    const examType = document.querySelector('.exam-type:checked')?.value;
    const data = [];
    document.querySelectorAll('.score-input').forEach((input, i) => {
      const score = parseInt(input.value, 10);
      const grade = parseInt(document.querySelectorAll('.grade-input')[i].value, 10);
      const sub = input.dataset.subject;
      if (isNaN(score) || score < 0 || score > 100) { isValid = false; showModal('원점수는 0~100 사이여야 합니다.'); }
      if (isNaN(grade) || grade < 1 || grade > 9) { isValid = false; showModal('등급은 1~9 사이여야 합니다.'); }
      data.push({ examTypeId: parseInt(examType), subjectName: sub, targetScore: score, targetLevel: grade });
    });
    if (!isValid) return;

    // 1. AJAX 저장
    fetch('/goal_score/insert', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({
        memberNo,
        examTypeId: parseInt(examType),
        year: currentYear,
        subjectScores: data
      })
    }).then(res => res.json())
      .then(res => {
        showModal(res.success ? '저장 성공!' : '저장 실패');
        // 2. 입력값 읽기
        const subjectNames = [];
        const scoreValues = [];
        const gradeValues = [];
        document.querySelectorAll('#score-body tr').forEach(tr => {
          subjectNames.push(tr.children[0].textContent);
          scoreValues.push(tr.children[1].querySelector('input').value);
          gradeValues.push(tr.children[2].querySelector('input').value);
        });
        // 3. 읽기전용 테이블로 변환
        renderResultTable(subjectNames, scoreValues, gradeValues);
        // 4. 입력폼 숨기기
        document.querySelectorAll('.score-input, .grade-input').forEach(inp => inp.style.display = 'none');
        document.getElementById('final-submit').style.display = 'none';
      });
  });

  // [helper] 읽기전용 테이블 렌더 함수
  function renderResultTable(subjects, scoreInputs, gradeInputs) {
    let html = '';
    for (let i = 0; i < subjects.length; i++) {
      html += `<tr>
        <td>${subjects[i]}</td>
        <td>${scoreInputs[i]}</td>
        <td>${gradeInputs[i]}</td>
      </tr>`;
    }
    document.getElementById('score-body').innerHTML = html;
  }
}); // DOMContentLoaded
</script>

<!-- 입력 완료 버튼은 점수 테이블 아래에 위치 -->
<div style="width:70%;margin:28px auto 0;text-align:center;">
  <button id="final-submit" class="btn" style="display:none;">설정완료</button>
</div>

</body>
</html>
