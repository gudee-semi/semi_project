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
    /* 전체 페이지 스타일 */
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
    /* 버튼 스타일 */
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
    /* 결과 표시 영역 */
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
      <input type="checkbox" name="exam" value="3" class="exam-type" id="exam3">
      <label for="exam3">3월</label>

      <input type="checkbox" name="exam" value="6" class="exam-type" id="exam6">
      <label for="exam6">6월</label>

      <input type="checkbox" name="exam" value="9" class="exam-type" id="exam9">
      <label for="exam9">9월</label>

      <input type="checkbox" name="exam" value="11" class="exam-type" id="exam11">
      <label for="exam11">11월(수능)</label>
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
  
	<!-- 점수 입력을 위한 영역 -->
	<div id="score-inputs"></div>
<!-- 점수 입력 + 세부 목표 작성 영역 -->
<div id="score-section" style="margin-top: 40px; display: none;">
  <h2>점수 입력</h2>
  <table id="score-table" style="border-collapse: collapse; margin: 20px auto; text-align: center;">
    <thead>
      <tr>
        <th style="border: 1px solid #ddd; padding: 8px;">과목</th>
        <th style="border: 1px solid #ddd; padding: 8px;">원점수</th>
        <th style="border: 1px solid #ddd; padding: 8px;">등급</th>
      </tr>
    </thead>
    <tbody id="score-body">
      <!-- JS에서 동적으로 생성 -->
    </tbody>
  </table>

  <div id="goal-section" style="margin-top: 40px;">
    <h3>세부 목표 작성</h3>
    <textarea id="goal-text" rows="5" placeholder="50자 이상 입력해주세요." style="width: 100%; max-width: 600px; padding: 10px; border: 1px solid #ccc; border-radius: 4px;"></textarea>
    
    <p id="char-warning" style="color: red; display: none; margin-top: 5px;">※ 50자 이상 반드시 작성해야 합니다.</p>
    <p id="emotion-warning" style="color: red; display: none; margin-top: 2px;">※ 작성하신 말은 정확히 진심인가요… 그래도 실현을 존중해주실건가요?</p>

    <button id="final-submit" class="btn" style="margin-top: 20px;">설정완료</button>
  </div>
</div>


  <script>
  // 시험 분류 하나만 선택 가능
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

  // 탐구과목 2개 제한
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

  // 제2외국어 1개 제한
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

	setupCombinedLimit();
	setupLang2Limit();

	//점수 입력 행 생성 함수
	function createScoreRow(subjectName) {
	  return `
	    <tr>
	      <td style="border: 1px solid #ddd; padding: 8px;">${subjectName}</td>
	      <td><input type="number" name="score_${subjectName}" placeholder="입력" style="width: 60px;"></td>
	      <td><input type="number" name="grade_${subjectName}" placeholder="입력" style="width: 60px;"></td>
	    </tr>
	  `;
	}


  // 선택완료 버튼 클릭 시
  // 선택완료 버튼 참조
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
    const subjects = ['국어', '수학', '영어', '한국사'];

    const getCheckedLabels = (selector) =>
      Array.from(document.querySelectorAll(selector))
        .filter(cb => cb.checked)
        .map(cb => cb.parentElement.textContent.trim());

    subjects.push(...getCheckedLabels('.social-subject'));
    subjects.push(...getCheckedLabels('.science-subject'));
    subjects.push(...getCheckedLabels('.science2-subject'));
    subjects.push(...getCheckedLabels('.lang2-subject'));

    resultHTML += subjects.join('  |  ');
    resultDiv.innerHTML = resultHTML;

    // 점수입력 + 세부목표 전체 영역 보이기
    const scoreSection = document.getElementById('score-section');
    scoreSection.style.display = 'block';

    // 점수입력 테이블 초기화 후 생성
    const scoreBody = document.getElementById('score-body');
    scoreBody.innerHTML = '';
    subjects.forEach(sub => {
      scoreBody.innerHTML += createScoreRow(sub);
    });
  });


  const finalSubmitBtn = document.getElementById('final-submit');
  const goalText = document.getElementById('goal-text');
  const charWarning = document.getElementById('char-warning');
  const emotionWarning = document.getElementById('emotion-warning');

  finalSubmitBtn.addEventListener('click', () => {
    const content = goalText.value.trim();

    charWarning.style.display = 'none';
    emotionWarning.style.display = 'none';

    if (content.length < 50) {
      charWarning.style.display = 'block';
    } else if (content.includes("포기") || content.includes("망함")) {
      emotionWarning.style.display = 'block';
    } else {
      alert('목표가 성공적으로 저장되었습니다!');
      // 서버 전송 로직이 있다면 여기에 작성
    }
  });

</script>


</body>
</html>
