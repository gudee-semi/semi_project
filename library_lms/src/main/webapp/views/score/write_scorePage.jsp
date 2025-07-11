<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

  <style>
    body {
      font-family: 'Pretendard', sans-serif;
      text-align: center;
      padding: 40px;
    }

    h1 {
      font-size: 36px;
      font-weight: bold;
    }

    .exam-type {
      margin: 10px;
    }

    .score-table {
      margin: 10px auto;
      border-collapse: collapse;
      width: 860px;
    }

    .score-table th,
    .score-table td {
      border: 1px solid #ddd;
      padding: 10px;
    }

    .highlight {
      font-size: 20px;
      font-weight: bold;
      margin-top: 20px;
      color: #333;
    }

    .input-select {
      width: 160px;
      padding: 6px;
      text-align: center;
      box-sizing: border-box;
    }

    span.display-value {
      display: inline-block;
      width: 160px;
      padding: 6px;
      box-sizing: border-box;
    }

    .button {
      margin-top: 20px;
      padding: 10px 20px;
      background-color: royalblue;
      color: white;
      border: none;
      border-radius: 5px;
      cursor: pointer;
    }

    .table-wrapper {
      width: 860px;
      margin: 50px auto 0;
    }

    .table-header,
    .table-footer {
      display: flex;
      justify-content: space-between;
      align-items: flex-start;
      width: 100%;
    }

    .left-title {
      font-weight: bold;
      font-size: 25px;
      color: #000;
    }

    .right-note {
      font-size: 13px;
      color: #666;
      text-align: right;
      line-height: 1.4;
    }

    .bottom-note {
      font-size: 13px;
      color: red;
      margin-top: 5px;
      text-align: left;
    }

    /* 모달 스타일 */
    #modal {
      display: none;
      position: fixed;
      top: 0; left: 0;
      width: 100%;
      height: 100%;
      background-color: rgba(0, 0, 0, 0.5);
      z-index: 9999;
    }

    #modal .modal-content {
      background: white;
      width: 300px;
      margin: 15% auto;
      padding: 20px;
      border-radius: 10px;
      text-align: center;
    }

    #modal-close-btn {
      margin-top: 10px;
      padding: 6px 16px;
      background: royalblue;
      color: white;
      border: none;
      border-radius: 5px;
    }
  </style>
</head>
<body>
<h1>성적 입력</h1>

  <!-- 시험 분류 -->
<div style="display: flex; justify-content: center; align-items: center; gap: 10px; margin-bottom: 20px;">
  <span style="font-weight: 500;">시험 분류</span>
  <span style="color: #aaa;">|</span>
  <label class="exam-type"><input type="checkbox" name="exam" value="3" class="exam-checkbox"> 3월</label>
  <label class="exam-type"><input type="checkbox" name="exam" value="6" class="exam-checkbox"> 6월</label>
  <label class="exam-type"><input type="checkbox" name="exam" value="9" class="exam-checkbox"> 9월</label>
</div>


  <!-- 선택된 시험 정보 -->
  <div class="highlight" id="exam-info"></div>

  <!-- 점수 입력 테이블 + 설명 -->
  <div class="table-wrapper">
    <!-- 상단 텍스트 -->
    <div class="table-header" style="margin-bottom: 5px;">
      <div class="left-title">점수 입력</div>
      <div class="right-note">
        ※ 국어 / 수학 / 영어 / 한국사 과목은 반드시 입력<br>
        ※ 백분위와 학교 석차는 국어 / 수학 과목만 입력
      </div>
    </div>

    <!-- 테이블 -->
    <table class="score-table">
      <thead>
        <tr>
          <th>과목</th>
          <th>원점수</th>
          <th>등급</th>
          <th>백분위</th>
          <th>전국석차</th>
        </tr>
      </thead>
      <tbody id="score-body">
        <script>
          const subjects = ["국어", "수학", "영어", "한국사", "물리", "경제", "독일어"];
          document.write(subjects.map(subject => {
            const isRankEditable = subject === "국어" || subject === "수학";
            const rankCell = isRankEditable
              ? `<input type="text" class="input-select rank" placeholder="본인등수/전교 인원수">`
              : `<span class="display-value">-</span>`;

            return `
              <tr>
                <td>${subject}</td>
                <td><input type="text" class="input-select" data-type="score" data-subject="${subject}" placeholder="입력" onblur="validateInput(this)"></td>
                <td><input type="text" class="input-select" data-type="grade" data-subject="${subject}" placeholder="입력" onblur="validateInput(this)"></td>
                <td><input type="text" class="input-select" data-type="percent" data-subject="${subject}" placeholder="입력" onblur="validateInput(this)"></td>
                <td>${rankCell}</td>
              </tr>`;
          }).join(''));
        </script>
      </tbody>
    </table>

    <!-- 하단 텍스트 -->
    <div class="table-footer">
      <div class="bottom-note">※ 필수 과목은 반드시 입력해야 합니다</div>
      <div></div> <!-- 오른쪽 비움 -->
    </div>
  </div>

  <button class="button" onclick="finalizeInputs()">선택 완료</button>

  <!-- 커스텀 모달 -->
  <div id="modal">
    <div class="modal-content">
      <p id="modal-message">메시지</p>
      <button id="modal-close-btn">확인</button>
    </div>
  </div>

  <script>
    // 시험분류 체크박스 하나만 선택되도록
    const examCheckboxes = document.querySelectorAll('.exam-checkbox');
    const examInfo = document.getElementById('exam-info');

    examCheckboxes.forEach(cb => {
      cb.addEventListener('change', () => {
        if (cb.checked) {
          examCheckboxes.forEach(other => {
            if (other !== cb) other.checked = false;
          });
          const year = new Date().getFullYear();
          examInfo.textContent = `${year}년도 ${cb.value}월 모의고사`;
        } else {
          const noneChecked = Array.from(examCheckboxes).every(c => !c.checked);
          if (noneChecked) examInfo.textContent = '';
        }
      });
    });

    // 모달 관리
    function showModal(message) {
      document.getElementById('modal-message').textContent = message;
      document.getElementById('modal').style.display = 'block';
    }

    document.getElementById('modal-close-btn').addEventListener('click', function () {
      document.getElementById('modal').style.display = 'none';
    });

    const halfScoreSubjects = ["한국사", "물리", "경제", "독일어"];

    // 유효성 검사
    function validateInput(input) {
      const value = input.value.trim();
      const type = input.dataset.type;
      const subject = input.dataset.subject;

      if (value === "") return;

      if (type === "score") {
        const num = Number(value);
        if (halfScoreSubjects.includes(subject)) {
          if (!/^\d{1,2}$/.test(value) || num < 0 || num > 50) {
            showModal("0~50 사이의 값으로 입력하세요");
            input.focus();
            return;
          }
        } else {
          if (!/^\d{1,3}$/.test(value) || num < 0 || num > 100) {
            showModal("0~100 사이의 값으로 입력하세요");
            input.focus();
            return;
          }
        }
      }

      if (type === "grade") {
        if (!/^[1-9]$/.test(value)) {
          showModal("1~9 사이의 값으로 입력하세요");
          input.focus();
        }
      }

      if (type === "percent") {
        if (!/^\d{1,3}(\.\d{1,2})?$/.test(value) || Number(value) < 0 || Number(value) > 100) {
          showModal("소수점 두자리까지 입력가능합니다");
          input.focus();
        }
      }
    }

    // 입력값 → span으로 변경
    function finalizeInputs() {
      const inputs = document.querySelectorAll('.input-select');
      inputs.forEach(input => {
        const value = input.value.trim() === "" ? "-" : input.value.trim();
        const span = document.createElement('span');
        span.className = 'display-value';
        span.textContent = value;
        input.parentNode.replaceChild(span, input);
      });
    }
  </script>


</body>
</html>