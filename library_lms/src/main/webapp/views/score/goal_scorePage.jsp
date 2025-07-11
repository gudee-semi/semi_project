<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
  session.setAttribute("memberNo", 2);
  session.setAttribute("studentGrade", 2);

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
    body { font-family: 'Pretendard', sans-serif; margin: 40px; }
    h1, h2, h3 { text-align: center; }
    .checkbox-group {
      display: flex;
      flex-wrap: wrap;
      gap: 10px 20px;
      justify-content: center;
      margin-bottom: 20px;
    }
    .btn {
      display: block;
      margin: 20px auto;
      padding: 8px 20px;
      border: 1px solid #3b82f6;
      background-color: white;
      color: #3b82f6;
      border-radius: 4px;
      cursor: pointer;
    }
    .btn:hover { background-color: #3b82f6; color: white; }
    #modal {
      display: none;
      position: fixed;
      top: 0; left: 0; width: 100%; height: 100%;
      background: rgba(0, 0, 0, 0.5);
      z-index: 999;
    }
    .modal-content {
      background: white;
      padding: 20px;
      margin: 20% auto;
      width: 300px;
      border-radius: 10px;
      text-align: center;
    }
    table { margin: 0 auto; border-collapse: collapse; }
    th, td { border: 1px solid #ccc; padding: 8px 16px; }
    textarea {
      display: block; margin: 20px auto;
      width: 90%; max-width: 600px; height: 100px;
      resize: none; padding: 10px;
    }
  </style>
</head>
<body>

<script>
  const studentGrade = <%= studentGrade %>;
  const memberNo = <%= memberNo %>;
  const currentYear = <%= currentYear %>;
</script>

<h1>목표 성적 설정</h1>

<!-- 시험 분류 -->
<h2>시험 분류</h2>
<div id="exam-options" class="checkbox-group"></div>

<h3>필수 과목</h3>
<div class="checkbox-group">
  <label><input type="checkbox" checked disabled> 국어</label>
  <label><input type="checkbox" checked disabled> 수학</label>
  <label><input type="checkbox" checked disabled> 영어</label>
  <label><input type="checkbox" checked disabled> 한국사</label>
</div>

<!-- 과목 선택 -->
<div id="optional-subjects"></div>
<button id="confirm-subjects" class="btn">선택완료</button>

<!-- 과목 입력 -->
<h2 id="exam-title" style="display:none;"></h2>
<div id="selected-subjects" style="text-align:center;"></div>
<table id="score-table" style="display:none;">
  <thead><tr><th>과목</th><th>원점수</th><th>등급</th></tr></thead>
  <tbody id="score-body"></tbody>
</table>

<textarea id="goal-text" placeholder="50자 이상 작성하세요"></textarea>
<p id="char-warning" style="color:red;text-align:center;display:none;">※ 50자 이상 반드시 작성해야 합니다.</p>
<button id="final-submit" class="btn">설정완료</button>

<!-- 모달 -->
<div id="modal">
  <div class="modal-content">
    <p id="modal-message"><%= request.getAttribute("modalMessage") != null ? request.getAttribute("modalMessage") : "" %></p>
    <button id="modal-close-btn">확인</button>
  </div>
</div>

<script>
const examMap = { 1: [3, 6, 9], 2: [3, 6, 9], 3: [3, 6, 9, 11] };
const examOptions = examMap[studentGrade] || [];
const examDiv = document.getElementById('exam-options');

examOptions.forEach(month => {
  const label = document.createElement('label');
  let labelText = month + '월';
  if (month === 11) labelText += '(수능)';
  label.innerHTML = `<input type="checkbox" class="exam-type" value="${month}"> ${labelText}`;
  examDiv.appendChild(label);
});

const subjects = {
  social: ['생활과 윤리', '윤리와 사상', '한국지리', '세계지리', '동아시아사', '세계사', '경제', '정치와 법', '사회문화'],
  science1: ['물리학 I', '화학 I', '생명과학 I', '지구과학 I'],
  science2: ['물리학 II', '화학 II', '생명과학 II', '지구과학 II'],
  lang2: ['독일어 I', '프랑스어 I', '스페인어 I', '중국어 I', '일본어 I', '러시아어 I', '아랍어 I', '베트남어 I']
};

function renderOptionalSubjects(showExtra) {
  const container = document.getElementById('optional-subjects');
  container.innerHTML = '';
  const appendGroup = (label, className, list) => {
    const group = document.createElement('div');
    group.classList.add('checkbox-group');
    const heading = document.createElement('h3');
    heading.textContent = label;
    group.appendChild(heading);
    list.forEach(sub => {
      const labelEl = document.createElement('label');
      labelEl.innerHTML = `<input type="checkbox" class="${className}"> ${sub}`;
      group.appendChild(labelEl);
    });
    container.appendChild(group);
  };
  appendGroup('사회탐구', 'social-subject', subjects.social);
  appendGroup('과학탐구', 'science-subject', subjects.science1);
  if (showExtra) {
    appendGroup('과학탐구2', 'science2-subject', subjects.science2);
    appendGroup('제2외국어', 'lang2-subject', subjects.lang2);
  }

  setLimit('.social-subject', 1, '사회탐구는 1과목만 선택 가능합니다.');
  setLimit('.science-subject', 1, '과학탐구 I은 1과목만 선택 가능합니다.');
  setLimit('.science2-subject', 1, '과학탐구 II는 1과목만 선택 가능합니다.');
  setLimit('.lang2-subject', 1, '제2외국어는 1과목만 선택 가능합니다.');
}

function setLimit(selector, max, msg) {
  document.querySelectorAll(selector).forEach(cb => {
    cb.addEventListener('change', () => {
      const selected = [...document.querySelectorAll(selector)].filter(c => c.checked);
      if (selected.length > max) {
        cb.checked = false;
        showModal(msg);
      }
    });
  });
}

const examTypes = document.querySelectorAll('.exam-type');
examTypes.forEach(cb => {
  cb.addEventListener('change', () => {
    examTypes.forEach(other => { if (other !== cb) other.checked = false; });
    const showExtra = (studentGrade === 3 && ['6','9','11'].includes(cb.value));
    renderOptionalSubjects(showExtra);
  });
});

const confirmBtn = document.getElementById('confirm-subjects');
confirmBtn.addEventListener('click', () => {
  const selectedMonth = document.querySelector('.exam-type:checked')?.value;
  if (!selectedMonth) return showModal('시험 분류를 선택해주세요.');

  const selected = ['국어','수학','영어','한국사'];
  document.querySelectorAll('.social-subject, .science-subject, .science2-subject, .lang2-subject')
    .forEach(cb => { if (cb.checked) selected.push(cb.parentElement.innerText.trim()); });

  document.getElementById('exam-title').textContent = `${currentYear}년 ${selectedMonth}월 모의고사`;
  document.getElementById('exam-title').style.display = 'block';
  document.getElementById('selected-subjects').textContent = selected.join(' | ');

  document.getElementById('score-body').innerHTML = selected.map(sub => `
    <tr>
      <td>${sub}</td>
      <td><input type="number" class="score-input" data-subject="${sub}" min="0" max="100"></td>
      <td><input type="number" class="grade-input" data-subject="${sub}" min="1" max="9"></td>
    </tr>`).join('');

  document.getElementById('score-table').style.display = 'table';
});

function showModal(msg) {
  document.getElementById('modal-message').textContent = msg;
  document.getElementById('modal').style.display = 'block';
}
document.getElementById('modal-close-btn').onclick = () => {
  document.getElementById('modal').style.display = 'none';
};

document.getElementById('final-submit').addEventListener('click', () => {
  const content = document.getElementById('goal-text').value.trim();
  if (content.length < 50) {
    document.getElementById('char-warning').style.display = 'block';
    return;
  }
  document.getElementById('char-warning').style.display = 'none';

  const examType = document.querySelector('.exam-type:checked')?.value;
  const data = [];
  document.querySelectorAll('.score-input').forEach((input, i) => {
    const score = parseInt(input.value);
    const grade = parseInt(document.querySelectorAll('.grade-input')[i].value);
    const sub = input.dataset.subject;
    if (score < 0 || score > 100) return showModal('원점수는 0~100 사이여야 합니다.');
    if (grade < 1 || grade > 9) return showModal('등급은 1~9 사이여야 합니다.');
    data.push({ memberNo, examTypeId: parseInt(examType), subjectId: sub, targetScore: score, targetLevel: grade });
  });

  fetch('/goal_score/insert', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify(data)
  }).then(res => res.json())
    .then(res => showModal(res.success ? '저장 성공!' : '저장 실패'));
});

// 조회 기능
window.addEventListener('DOMContentLoaded', () => {
  fetch('/goal_score/select?memberNo=' + memberNo)
    .then(res => res.json())
    .then(data => {
      console.log("조회된 목표 성적 리스트", data);
      // 추가 표시 가능
    });
});
</script>

</body>
</html>
