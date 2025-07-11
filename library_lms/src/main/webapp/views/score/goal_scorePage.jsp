<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
  int studentGrade = 2;
	Integer memberNo = (Integer) session.getAttribute("memberNo");
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

    .checkbox-group {
      display: flex;
      flex-wrap: wrap;
      gap: 15px 30px;
    }

    .line-break {
      width: 100%;
      height: 1em;
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

    #score-section h2 {
      font-size: 18px;
      font-weight: bold;
      margin-bottom: 10px;
      text-align: left;
      margin-left: 160px;
    }

    #score-table {
      border-collapse: collapse;
      margin: 0 auto;
      text-align: center;
    }

    #score-table th, #score-table td {
      border: 1px solid #ddd;
      padding: 8px;
    }

    textarea {
      width: 100%;
      max-width: 600px;
      padding: 10px;
      border: 1px solid #ccc;
      border-radius: 4px;
    }
    
    /* 모달 스타일 */
	#modal {
	  display: none;
	  position: fixed;
	  top: 0; left: 0;
	  width: 100%; height: 100%;
	  background-color: rgba(0,0,0,0.5);
	  z-index: 9999;
	}
	
	.modal-content {
	  background-color: white;
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
	  cursor: pointer;
	}
    
    
  </style>
</head>

<body>

  <h1>목표 성적 설정</h1>

  <!-- 시험 분류 -->
  <div class="section" id="exam-section">
    <h2>시험 분류</h2>
    <div id="exam-checkboxes" class="checkbox-group">
      <input type="checkbox" name="exam" value="3" class="exam-type" id="exam3"><label for="exam3">3월</label>
      <input type="checkbox" name="exam" value="6" class="exam-type" id="exam6"><label for="exam6">6월</label>
      <input type="checkbox" name="exam" value="9" class="exam-type" id="exam9"><label for="exam9">9월</label>
      <input type="checkbox" name="exam" value="11" class="exam-type" id="exam11"><label for="exam11">11월(수능)</label>
    </div>
  </div>

  <!-- 과목 선택 -->
  <div class="section" id="subject-section">
    <h3>필수 과목</h3>
    <div class="checkbox-group">
      <label><input type="checkbox" checked disabled> 국어</label>
      <label><input type="checkbox" checked disabled> 수학</label>
      <label><input type="checkbox" checked disabled> 영어</label>
      <label><input type="checkbox" checked disabled> 한국사</label>
    </div>

    <h3>사회탐구</h3>
    <div class="checkbox-group">
      <label><input type="checkbox" class="social-subject"> 경제</label>
      <label><input type="checkbox" class="social-subject"> 사회문화</label>
      <label><input type="checkbox" class="social-subject"> 법과 정치</label>
      <label><input type="checkbox" class="social-subject"> 윤리와 사상</label>
      <label><input type="checkbox" class="social-subject"> 세계지리</label>
      <label><input type="checkbox" class="social-subject"> 한국지리</label>
      <label><input type="checkbox" class="social-subject"> 세계사</label>
      <label><input type="checkbox" class="social-subject"> 동아시아사</label>
      <label><input type="checkbox" class="social-subject"> 생활과 윤리</label>
    </div>

    <h3>과학탐구</h3>
    <div class="checkbox-group">
      <label><input type="checkbox" class="science-subject"> 물리1</label>
      <label><input type="checkbox" class="science-subject"> 화학1</label>
      <label><input type="checkbox" class="science-subject"> 생명과학1</label>
      <label><input type="checkbox" class="science-subject"> 지구과학1</label>
      <label><input type="checkbox" class="science2-subject"> 물리2</label>
      <label><input type="checkbox" class="science2-subject"> 화학2</label>
      <label><input type="checkbox" class="science2-subject"> 생명과학2</label>
      <label><input type="checkbox" class="science2-subject"> 지구과학2</label>
    </div>

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
  
  <div id="modal">
  <div class="modal-content">
    <p id="modal-message">메시지</p>
    <button id="modal-close-btn">확인</button>
  </div>
</div>
  
  

  <div id="result"></div>

  <!-- 점수 입력 테이블 -->
  <div id="score-section" style="display: none;">
    <h2>점수 입력</h2>

    <table id="score-table">
      <thead>
        <tr>
          <th>과목</th>
          <th>원점수</th>
          <th>등급</th>
        </tr>
      </thead>
      <tbody id="score-body"></tbody>
    </table>

    <div id="goal-section" style="margin-top: 40px;">
  <h3>세부 목표 작성</h3>
  <textarea id="goal-text" rows="5" placeholder="50자 이상 입력해주세요." style="resize: none;"></textarea>
  <p id="char-warning" style="color: red; display: none;">※ 50자 이상 반드시 작성해야 합니다.</p>
  <button id="final-submit" class="btn" style="margin-top: 20px;">설정완료</button>
</div>
    

  <script>
  const examCheckboxes = document.querySelectorAll('.exam-type');
  examCheckboxes.forEach(cb => {
    cb.addEventListener('change', () => {
      if (cb.checked) {
        examCheckboxes.forEach(other => {
          if (other !== cb) other.checked = false;
        });
      }
    });
  });

  function setupCombinedLimit() {
    const social = document.querySelectorAll('.social-subject');
    const science = document.querySelectorAll('.science-subject, .science2-subject');
    const all = [...social, ...science];
    all.forEach(cb => {
      cb.addEventListener('change', () => {
        if (all.filter(c => c.checked).length > 2) {
          cb.checked = false;
          showModal('탐구과목은 최대 2개까지만 선택할 수 있습니다.');
        }
      });
    });
  }

  function setupLang2Limit() {
    const lang = document.querySelectorAll('.lang2-subject');
    lang.forEach(cb => {
      cb.addEventListener('change', () => {
        if ([...lang].filter(c => c.checked).length > 1) {
          cb.checked = false;
          showModal('제2외국어는 최대 1개까지만 선택할 수 있습니다.');
        }
      });
    });
  }

  setupCombinedLimit();
  setupLang2Limit();

  function createScoreRow(subject) {
    return `
      <tr>
        <td>${subject}</td>
        <td><input type="number" class="score-input" data-subject="${subject}" placeholder="입력" style="width:60px; text-align:center;"></td>
        <td><input type="number" class="grade-input" data-subject="${subject}" placeholder="입력" style="width:60px; text-align:center;"></td>
      </tr>`;
  }

  document.querySelector('.btn').addEventListener('click', () => {
    const selectedExam = [...document.querySelectorAll('.exam-type')].find(cb => cb.checked);
    if (!selectedExam) return showModal('시험 분류를 선택해주세요.');

    const year = new Date().getFullYear();
    const month = selectedExam.value === '11' ? '11월(수능)' : selectedExam.value + '월';
    document.getElementById('result').innerHTML = `<strong>${year}년도 ${month} 모의고사</strong><br><br>`;

    const subjects = ['국어', '수학', '영어', '한국사'];
    const getCheckedSubjects = (selector) =>
      [...document.querySelectorAll(selector)]
        .filter(cb => cb.checked)
        .map(cb => cb.parentElement.textContent.trim());

    subjects.push(...getCheckedSubjects('.social-subject'));
    subjects.push(...getCheckedSubjects('.science-subject'));
    subjects.push(...getCheckedSubjects('.science2-subject'));
    subjects.push(...getCheckedSubjects('.lang2-subject'));

    document.getElementById('score-body').innerHTML = subjects.map(createScoreRow).join('');
    document.getElementById('score-section').style.display = 'block';
  });

  // 세부 목표 작성 체크
  document.getElementById('final-submit').addEventListener('click', () => {
    const content = document.getElementById('goal-text').value.trim();
    const warning = document.getElementById('char-warning');
    warning.style.display = content.length < 50 ? 'block' : 'none';
    if (content.length >= 50) showModal('목표가 성공적으로 저장되었습니다!');
  });

  // 모달창 닫기 버튼 이벤트 추가
  document.getElementById('modal-close-btn').addEventListener('click', () => {
    document.getElementById('modal').style.display = 'none';
  });

  function showModal(message) {
    document.getElementById('modal-message').textContent = message;
    document.getElementById('modal').style.display = 'block';
  }

  // 🔥 변경된 부분: 포커스가 벗어났을 때 (blur 이벤트) 유효성 검사
  document.getElementById('score-body').addEventListener('blur', (event) => {
    const input = event.target;
    
    if (input.classList.contains('score-input')) {
      const subject = input.dataset.subject;
      const num = Number(input.value.trim());

      if (input.value === '') return;

      if (["한국사", "물리1", "화학1", "생명과학1", "지구과학1", "물리2", "화학2", "생명과학2", "지구과학2", "경제", "사회문화", "법과 정치", "윤리와 사상", "세계지리", "한국지리", "세계사", "동아시아사", "생활과 윤리", "독일어", "프랑스어", "스페인어", "중국어", "일본어", "러시아어", "아랍어", "베트남어", "한문"].includes(subject)) {
        if(num < 0 || num > 50) {
          showModal("원점수는 0~50 사이의 숫자만 입력 가능합니다.");
          input.value = '';
          input.focus();
        }
      } else {
        if(num < 0 || num > 100) {
          showModal("원점수는 0~100 사이의 숫자만 입력 가능합니다.");
          input.value = '';
          input.focus();
        }
      }
    }

    if (input.classList.contains('grade-input')) {
      const num = Number(input.value.trim());
      if (input.value === '') return;

      if(num < 1 || num > 9) {
        showModal("등급은 1~9 사이의 숫자만 입력 가능합니다.");
        input.value = '';
        input.focus();
      }
    }
  }, true); // 캡처링 사용 필수


  </script>
</body>
</html>
