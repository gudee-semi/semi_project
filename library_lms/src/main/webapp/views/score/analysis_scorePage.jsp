<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>성적 조회 및 분석</title>

<style>
    body {
      font-family: 'Pretendard', sans-serif;
      text-align: center;
      padding: 40px;
    }

    h1 {
      font-size: 24px;
      font-weight: bold;
    }

    .exam-type {
      margin: 10px;
    }

    .score-table {
      margin: 20px auto;
      border-collapse: collapse;
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

    .graph-container {
      display: flex;
      justify-content: center;
      align-items: flex-start;
      gap: 60px;
      margin-top: 60px;
    }

    .graph-wrapper {
      text-align: right;
    }

    .graph-wrapper canvas {
      display: block;
      margin: 0 auto;
    }

    .graph-note {
      font-size: 13px;
      color: gray;
      margin-top: 5px;
    }

    /* 모달 */
    #modal {
      display: none;
      position: fixed;
      top: 0; left: 0;
      width: 100%; height: 100%;
      background-color: rgba(0, 0, 0, 0.5);
      z-index: 9999;
    }

    .modal-content {
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

  <div class="highlight" id="exam-info"></div>

  <!-- 점수 입력 테이블 -->
  <table class="score-table" id="score-table">
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
              <td><input type="text" class="input-select" data-type="percent" data-subject="${subject}" placeholder="본인 등수 / 전교 인원수 " onblur="validateInput(this)"></td>
              <td>${rankCell}</td>
            </tr>`;
        }).join(''));
      </script>
    </tbody>
  </table>

  <div style="text-align: right; width: 860px; margin: 0 auto;">
    <button class="button" onclick="finalizeInputs()">선택 완료</button>
  </div>

  <!-- 그래프들 -->
  <div class="graph-container">
    <div class="graph-wrapper">
      <canvas id="scoreBarChart" width="400" height="300"></canvas>
      <div class="graph-note">(한국사 / 탐구 / 제2외국어 과목은 50점이 만점입니다.)</div>
    </div>
    <div class="graph-wrapper">
      <canvas id="scoreRadarChart" width="400" height="300"></canvas>
      <div class="graph-note">(한국사 / 탐구 / 제2외국어 과목은 점수에 ×2로 반영됩니다.)</div>
    </div>
  </div>

  <!-- 모달 -->
  <div id="modal">
    <div class="modal-content">
      <p id="modal-message">메시지</p>
      <button id="modal-close-btn">확인</button>
    </div>
  </div>

  <script>
    const examCheckboxes = document.querySelectorAll('.exam-checkbox');
    const examInfo = document.getElementById('exam-info');

    examCheckboxes.forEach(cb => {
      cb.addEventListener('change', () => {
        if (cb.checked) {
          examCheckboxes.forEach(otherCb => {
            if (otherCb !== cb) otherCb.checked = false;
          });
          const year = new Date().getFullYear();
          examInfo.textContent = `${year}년도 ${cb.value}월 모의고사`;
        } else {
          const noneChecked = Array.from(examCheckboxes).every(cb => !cb.checked);
          if (noneChecked) examInfo.textContent = '';
        }
      });
    });

    document.getElementById('modal-close-btn').addEventListener('click', function () {
      document.getElementById('modal').style.display = 'none';
    });

    function showModal(message) {
      document.getElementById('modal-message').textContent = message;
      document.getElementById('modal').style.display = 'block';
    }

    function validateInput(input) {
      const value = input.value.trim();
      const type = input.dataset.type;
      const subject = input.dataset.subject;
      if (value === '') return;

      if (type === 'score') {
        const num = Number(value);
        if (["한국사", "물리", "경제", "독일어"].includes(subject)) {
          if (!/^\d{1,2}$/.test(value) || num < 0 || num > 50) {
            showModal("0~50 사이의 값으로 입력하세요");
            input.focus();
          }
        } else {
          if (!/^\d{1,3}$/.test(value) || num < 0 || num > 100) {
            showModal("원점수는 0~100 사이의 값으로 입력하세요");
            input.focus();
          }
        }
      }

      if (type === 'grade') {
        if (!/^[1-9]$/.test(value)) {
          showModal("등급은 1~9 사이의 값으로 입력하세요");
          input.focus();
        }
      }

      if (type === 'percent') {
        if (!/^\d{1,3}(\.\d{1,2})?$/.test(value) || Number(value) < 0 || Number(value) > 100) {
          showModal("백분위는 0~100사이의 값, 소수점 두자리까지 입력가능합니다");
          input.focus();
        }
      }
    }

    function drawCharts(subjects, scores, goals) {
      const barCtx = document.getElementById('scoreBarChart').getContext('2d');
      new Chart(barCtx, {
        type: 'bar',
        data: {
          labels: subjects,
          datasets: [
            {
              label: '목표 점수',
              data: goals,
              backgroundColor: 'rgba(54, 162, 235, 0.4)'
            },
            {
              label: '성적',
              data: scores,
              backgroundColor: 'rgba(54, 162, 235, 0.8)'
            }
          ]
        },
        options: {
          responsive: false,
          plugins: {
            legend: {
              position: 'top',
              align: 'end'
            }
          },
          scales: {
            y: {
              beginAtZero: true,
              max: 100
            }
          }
        }
      });

      const radarCtx = document.getElementById('scoreRadarChart').getContext('2d');
      new Chart(radarCtx, {
        type: 'radar',
        data: {
          labels: subjects,
          datasets: [
            {
              label: '성적',
              data: scores,
              fill: true,
              backgroundColor: 'rgba(255, 159, 64, 0.2)',
              borderColor: 'rgba(255, 159, 64, 1)',
              pointBackgroundColor: 'rgba(255, 159, 64, 1)'
            }
          ]
        },
        options: {
          responsive: false,
          scales: {
            r: {
              angleLines: { display: true },
              suggestedMin: 0,
              suggestedMax: 100
            }
          },
          plugins: {
            legend: {
              display: false
            }
          }
        }
      });
    }

    function finalizeInputs() {
      const inputs = document.querySelectorAll('.input-select');
      const subjectList = ["국어", "수학", "영어", "한국사", "물리", "경제", "독일어"];
      const scores = [];
      const goals = [92, 83, 100, 50, 30, 45, 49];

      subjectList.forEach(subject => {
        const scoreInput = document.querySelector(`input[data-subject="${subject}"][data-type="score"]`);
        const scoreValue = scoreInput?.value?.trim();
        const parsed = Number(scoreValue);
        const score = (!isNaN(parsed) && parsed >= 0) ? parsed : 0;
        scores.push(score);
      });

      inputs.forEach(input => {
        const value = input.value.trim() === "" ? "-" : input.value.trim();
        const span = document.createElement('span');
        span.className = 'display-value';
        span.textContent = value;
        input.parentNode.replaceChild(span, input);
      });

      drawCharts(subjectList, scores, goals);
    }
  </script>


</body>
</html>