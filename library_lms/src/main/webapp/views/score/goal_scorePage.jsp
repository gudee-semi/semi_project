<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
  int studentGrade = 2; // 예시용. 실제로는 세션에서 가져올 수 있음
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>목표 성적 설정 페이지</title>
  <style>
    body {
      font-family: 'Pretendard', sans-serif;
      margin: 40px;
    }

    h1 {
      text-align: center;
      font-size: 22px;
      font-weight: bold;
      margin-bottom: 30px;
    }

    .section {
      margin-bottom: 25px;
    }

    .row {
      display: flex;
      align-items: flex-start;
      margin-bottom: 15px;
    }

    .label {
      min-width: 100px;
      font-weight: bold;
      display: flex;
      align-items: center;
    }

    .checkbox-group {
      display: flex;
      flex-wrap: wrap;
      gap: 15px 30px;
    }

    .line-break {
      width: 100%;
      height: 1em;
    }

    hr {
      border: none;
      border-top: 1px solid #ccc;
      margin: 25px 0;
    }

    input[type="checkbox"] {
      accent-color: #3b82f6;
    }

    .btn {
      display: block;
      margin: 40px auto 0;
      padding: 8px 20px;
      border: 1px solid #3b82f6;
      background-color: white;
      color: #3b82f6;
      border-radius: 4px;
      cursor: pointer;
      font-size: 14px;
    }

    .btn:hover {
      background-color: #3b82f6;
      color: white;
    }

    #result {
      text-align: center;
      margin-top: 40px;
      font-size: 16px;
    }
  </style>
</head>

<body>

  <h1>목표 성적 설정</h1>

  <!-- 시험 분류 -->
  <div class="section" id="exam-section">
    <h2>시험 분류</h2>
    <div id="exam-checkboxes" class="checkbox-group">
      <label><input type="checkbox" name="exam" value="3" class="exam-type"> 3월</label>
      <label><input type="checkbox" name="exam" value="6" class="exam-type"> 6월</label>
      <label><input type="checkbox" name="exam" value="9" class="exam-type"> 9월</label>
      <label><input type="checkbox" name="exam" value="11" class="exam-type"> 11월(수능)</label>
    </div>
  </div>

  <!-- 과목 선택 (항상 표시) -->
  <div class="section" id="subject-section">
    <h3>필수 과목</h3>
    <div class="checkbox-group">
      <label><input type="checkbox" checked disabled> 국어</label>
      <label><input type="checkbox" checked disabled> 수학</label>
      <label><input type="checkbox" checked disabled> 영어</label>
      <label><input type="checkbox" checked disabled> 한국사</label>
    </div>

    <div class="line-break"></div>

    <h3>사회탐구</h3>
    <div class="checkbox-group">
      <label><input type="checkbox" class="social-subject"> 경제</label>
      <label><input type="checkbox" class="social-subject"> 사회문화</label>
      <label><input type="checkbox" class="social-subject"> 법과 정치</label>
      <label><input type="checkbox" class="social-subject"> 윤리와 사상</label>
      <div class="line-break"></div>
      <label><input type="checkbox" class="social-subject"> 세계지리</label>
      <label><input type="checkbox" class="social-subject"> 한국지리</label>
      <label><input type="checkbox" class="social-subject"> 세계사</label>
      <label><input type="checkbox" class="social-subject"> 동아시아사</label>
      <label><input type="checkbox" class="social-subject"> 생활과 윤리</label>
    </div>

    <div class="line-break"></div>

    <h3>과학탐구</h3>
    <div class="checkbox-group">
      <label><input type="checkbox" class="science-subject"> 물리1</label>
      <label><input type="checkbox" class="science-subject"> 화학1</label>
      <label><input type="checkbox" class="science-subject"> 생명과학1</label>
      <label><input type="checkbox" class="science-subject"> 지구과학1</label>
      <div class="line-break"></div>
      <label><input type="checkbox" class="science2-subject"> 물리2</label>
      <label><input type="checkbox" class="science2-subject"> 화학2</label>
      <label><input type="checkbox" class="science2-subject"> 생명과학2</label>
      <label><input type="checkbox" class="science2-subject"> 지구과학2</label>
    </div>

    <div class="line-break"></div>

    <h3>제2외국어</h3>
    <div class="checkbox-group">
      <label><input type="checkbox" class="lang2-subject"> 독일어</label>
      <label><input type="checkbox" class="lang2-subject"> 프랑스어</label>
      <label><input type="checkbox" class="lang2-subject"> 스페인어</label>
      <label><input type="checkbox" class="lang2-subject"> 중국어</label>
      <label><input type="checkbox" class="lang2-subject"> 일본어</label>
      <label><input type="checkbox" class="lang2-subject"> 러시아어</label>
      <label><input type="checkbox" class="lang2-subject"> 아랍어</label>
      <label><input type="checkbox" class="lang2-subject"> 베트남어</label>
      <label><input type="checkbox" class="lang2-subject"> 한문</label>
    </div>
  </div>

  <button class="btn">선택완료</button>

  <div id="result"></div>

  <script>
    // 시험 분류: 하나만 선택 가능
    const examCheckboxes = document.querySelectorAll('.exam-type');
    examCheckboxes.forEach(cb => {
      cb.addEventListener('change', () => {
        if (cb.checked) {
          examCheckboxes.forEach(otherCb => {
            if (otherCb !== cb) otherCb.checked = false;
          });
        }
      });
    });

    // 과목 제한 설정
    function setupCombinedLimit() {
      const socialCheckboxes = document.querySelectorAll('.social-subject');
      const scienceCheckboxes = document.querySelectorAll('.science-subject, .science2-subject');
      const combined = [...socialCheckboxes, ...scienceCheckboxes];

      combined.forEach(cb => {
        cb.addEventListener('change', () => {
          const checkedCount = combined.filter(c => c.checked).length;
          if (checkedCount > 2) {
            cb.checked = false;
            alert('탐구과목은 최대 2개까지만 선택할 수 있습니다.');
          }
        });
      });
    }

    function setupLang2Limit() {
      const lang2Checkboxes = document.querySelectorAll('.lang2-subject');
      lang2Checkboxes.forEach(cb => {
        cb.addEventListener('change', () => {
          const checkedCount = Array.from(lang2Checkboxes).filter(c => c.checked).length;
          if (checkedCount > 1) {
            cb.checked = false;
            alert('제2외국어는 최대 1개까지만 선택할 수 있습니다.');
          }
        });
      });
    }

    // 초기화 함수
    function resetAllSubjects() {
      const allSubjectCheckboxes = document.querySelectorAll('.social-subject, .science-subject, .science2-subject, .lang2-subject');
      allSubjectCheckboxes.forEach(cb => cb.checked = false);
    }

    setupCombinedLimit();
    setupLang2Limit();

    const completeBtn = document.querySelector('.btn');
    const resultDiv = document.getElementById('result');

    completeBtn.addEventListener('click', () => {
      const selectedExam = Array.from(document.querySelectorAll('.exam-type')).find(cb => cb.checked);
      if (!selectedExam) {
        alert('시험 분류를 선택해주세요.');
        return;
      }

      const examMonth = selectedExam.value;
      const currentYear = new Date().getFullYear();
      const displayMonth = examMonth === '11' ? '11월(수능)' : examMonth + '월';

      let resultHTML = `<strong>${currentYear}년도 ${displayMonth} 모의고사</strong><br><br>`;
      console.log("결과 미리보기:", resultHTML);

      const subjects = ['국어', '수학', '영어', '한국사'];

      const getCheckedLabels = (selector) =>
        Array.from(document.querySelectorAll(selector))
          .filter(cb => cb.checked)
          .map(cb => cb.parentElement.textContent.trim());

      subjects.push(...getCheckedLabels('.social-subject'));
      subjects.push(...getCheckedLabels('.science-subject'));
      subjects.push(...getCheckedLabels('.science2-subject'));
      subjects.push(...getCheckedLabels('.lang2-subject'));

      resultHTML += subjects.join(' | ');

      resultDiv.innerHTML = resultHTML;
    });
  </script>

</body>
</html>
