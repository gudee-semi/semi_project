$(document).ready(function () {
  const examCheckboxes = $('input[name="exam"]');
  let availableCount = 0;
  let invalidInput = null;
  
  // 
  const socialSubjects = ["경제", "사회문화", "법과정치", "윤리와 사상", "세계지리", "한국지리", "세계사", "동아시아사", "생활과 윤리"];
  const science1Subjects = ["물리1", "화학1", "생명과학1", "지구과학1"];
  const science2Subjects = ["물리학2", "화학2", "생명과학2", "지구과학2"];
  const lang2Subjects = ["독일어", "프랑스어", "스페인어", "중국어", "일본어", "러시아어", "아랍어", "베트남어", "한문"];

  // [1] 시험 체크박스 활성화
  examCheckboxes.each(function () {
    const examMonth = parseInt($(this).val(), 10);
    if (examMonth === 11) {
      if (studentGrade === 3) {
        $(this).prop('disabled', false).prop('checked', false);
        availableCount++;
      } else {
        $(this).prop('disabled', true).prop('checked', false);
      }
    } else {
      $(this).prop('disabled', false).prop('checked', false);
      availableCount++;
    }
  });

  if (availableCount === 0) {
    $('#exam-options').append(`
      <div style="color:#dc2626;margin:10px 0 0 10%;font-size:16px;font-weight:500;">
        선택 가능한 시험이 없습니다.
      </div>
    `);
  }

  // [2] 시험 선택
  examCheckboxes.change(function () {
    examCheckboxes.not(this).prop('checked', false);
    $('#exam-title').hide().text('');
    $('#selected-subjects').text('');
    $('#score-table').hide();
    $('#score-body').empty();
    $('#final-submit').hide();
    $('.explore-subject, .lang2-subject').prop('checked', false);

	// 3학년 6월, 9월, 11월 시험인 경우 과학탐구2, 제2외국어 과목 출력
    const val = $(this).val();
    if (studentGrade === 3 && ['6', '9', '11'].includes(val)) {
      $('#science2-section, #lang2-section').show();
    } else {
      $('#science2-section, #lang2-section').hide();
      $('.science2-subject, .lang2-subject').prop('checked', false);
    }
  }).trigger('change');

  // [3] 탐구 과목 2개 제한
  $('.explore-subject').change(function () {
    if ($('.explore-subject:checked').length > 2) {
      $(this).prop('checked', false);
      showSwal("탐구과목은 2개까지 선택 가능합니다.");
    }
  });

  // [4] 제2외국어 1개 제한
  $('.lang2-subject').change(function () {
    if ($('.lang2-subject:checked').length > 1) {
      $(this).prop('checked', false);
      showSwal("제2외국어는 1개만 선택 가능합니다.");
    }
  });

  // [5] 선택완료 → 입력창 생성
  $('#confirm-subjects').click(function () {
    const examMonth = $('.exam-type:checked').val();
    if (!examMonth) return showSwal("시험 분류를 선택해주세요.");

	// 국어, 수학, 영어, 한국사 과목은 필수로 선택
    const selected = ['국어', '수학', '영어', '한국사'];
    $('.explore-subject:checked, .lang2-subject:checked').each(function () {
      selected.push($(this).val());
    });

    if (selected.length < 5) return showSwal("탐구/선택 과목을 1개 이상 선택해주세요.");

    $('#exam-title').text(`${currentYear}년 ${examMonth}월 모의고사`).show();
    $('#selected-subjects').text(selected.join(' | '));

    $('#score-body').html(selected.map(sub => `
      <tr>
        <td>${sub}</td>
        <td><input type="text" class="score-input input-center" data-subject="${sub}" placeholder="입력"></td>
        <td><input type="text" class="grade-input input-center" data-subject="${sub}" placeholder="입력"></td>
      </tr>
    `).join(''));

    $('#score-table').show();
    $('#final-submit').show();
  });

  // [6-1] 원점수 유효성 검사
  $(document).on('blur', '.score-input', function () {
    const input = $(this);
    const sub = input.data('subject');
    const val = input.val().trim();

	// 한국사, 사회탐구, 과학탐구, 제2외국어의 원점수는 0~50 사이의 정수로 제한
    const isRestricted =
      sub === "한국사" ||
      socialSubjects.includes(sub) ||
      science1Subjects.includes(sub) ||
      science2Subjects.includes(sub) ||
      lang2Subjects.includes(sub);

	  // [추가] 정수만 허용하는 정규식
	    // 0~100 정수(00, 000, 소수점, 음수 불가)
	    const regexNormal = /^(0|[1-9][0-9]?|100)$/;
	    // 0~50 정수(00, 000, 소수점, 음수 불가)
	    const regexRestricted = /^(0|[1-9]|[1-4][0-9]|50)$/;

	    // 입력값이 있으면 검사
	    if (val !== '') {
	      let valid = false;

	      if (isRestricted) {
	        // [한국사/탐구/제2외국어] 0~50 정수만 허용
	        valid = regexRestricted.test(val);
	      } else {
	        // [그 외 과목] 0~100 정수만 허용
	        valid = regexNormal.test(val);
	      }

    if (!valid) {
      input.css('border', '1px solid #dc2626');
      invalidInput = input;
      const msg = isRestricted
        ? "한국사/탐구/선택과목 원점수는 0 이상 50 이하의 정수로 입력하세요."
        : "원점수는 0 이상 100 이하의 정수로 입력하세요.";
      return showSwal(msg, "warning", () => {
		input.val('').focus(); // 잘못 입력시 값 비우고 포커스
		      });
		    } else {
		      input.css('border', ''); // 유효 입력시 테두리 제거
		    }
		  } else {
		    // 값이 없으면 테두리 제거(기존 유지)
		    input.css('border', '');
		  }
		});

  
	// [G-2] 등급 유효성 검사 (1~9 정수만, 소수점/00/01/09 등 불가)
	$(document).on('blur', '.grade-input', function () {	
	  const input = $(this);
	  const val = input.val().trim();

	  // [추가] 1~9만 허용 (1,2,...9), 01, 09, 000, 1.0 등 불가
	  const regexGrade = /^[1-9]$/;

	  if (val !== '') {
	    if (!regexGrade.test(val)) {
	      input.css('border', '1px solid #dc2626');
		  invalidInput = input;
		return showSwal("등급은 1 이상 9 이하의 정수로 입력하세요.", "warning", () => {
		    input.val('').focus();
		});
		} else {
		     input.css('border', ''); // ✅ 유효 입력시 테두리 제거
		  }
	  } else {
		    // 값이 없으면 테두리 제거(기존 로직)
		    input.css('border', '');
		 }
	});

  
  
  
  // [H] 입력하지 않은 항목에 빨간 테두리 표시
    $('.score-input').each(function (i) {
      const scoreInput = $(this);
      const gradeInput = $('.grade-input').eq(i);
      const scoreRaw = scoreInput.val().trim();
      const gradeRaw = gradeInput.val().trim();

      scoreInput.css('border', ''); // 초기화
      gradeInput.css('border', '');

      if (scoreRaw === '') scoreInput.css('border', '1px solid #dc2626');
      if (gradeRaw === '') gradeInput.css('border', '1px solid #dc2626');

      if (scoreRaw === '' || gradeRaw === '') {
        emptyFound = true;
        return false;
      }
    });
    
    
    // [J] 모달 닫기 + 유효하지 않은 값 삭제
    $('#modal-close-btn').click(() => {
      $('#modal').hide();

      // 잘못된 입력 삭제
      if (invalidInput) {
        $(invalidInput).val('').css('border', '1px solid #dc2626');
        invalidInput = null;
      }
    });
    

	// [H] 설정완료 → DB 전송
	$('#final-submit').click(function () {
	  const examType = $('.exam-type:checked').val();
	  if (!examType) return showSwal('시험 분류를 선택하세요.');

	  const data = [];
	  const subjectNames = [];
	  const scoreValues = [];
	  const gradeValues = [];
	  let emptyFound = false;

	  $('.score-input').each(function (i) {
	    const scoreInput = $(this);
	    const gradeInput = $('.grade-input').eq(i);
	    const sub = scoreInput.data('subject');
	    const scoreRaw = scoreInput.val().trim();
	    const gradeRaw = gradeInput.val().trim();

	    // 초기화
	    scoreInput.css('border', '');
	    gradeInput.css('border', '');

	    // 입력 누락 시 빨간 테두리 표시
	    if (scoreRaw === '') scoreInput.css('border', '1px solid #dc2626');
	    if (gradeRaw === '') gradeInput.css('border', '1px solid #dc2626');

	    if (scoreRaw === '' || gradeRaw === '') {
	      emptyFound = true;
	      return false; // 중단
	    }

	    const scoreVal = parseInt(scoreRaw);
	    const gradeVal = parseInt(gradeRaw);

	    // 점수, 등급 유효성 검사 (각 항목에서 검사하면 바로 중단)
	    // 만약 과목별로 50점 제한이 있는 경우 아래 조건 추가해주면 됨
	    if (sub === "한국사" || // 예시: 50점 제한
	        socialSubjects.includes(sub) ||
	        science1Subjects.includes(sub) ||
	        science2Subjects.includes(sub) ||
	        lang2Subjects.includes(sub)) {
	      if (isNaN(scoreVal) || scoreVal < 0 || scoreVal > 50) {
	        scoreInput.css('border', '1px solid #dc2626');
	        return showSwal('한국사/탐구/선택과목 원점수는 0 이상 50 이하의 숫자로 입력하세요.');
	      }
	    } else {
	      if (isNaN(scoreVal) || scoreVal < 0 || scoreVal > 100) {
	        scoreInput.css('border', '1px solid #dc2626');
	        return showSwal('원점수는 0 이상 100 이하의 숫자로 입력하세요.');
	      }
	    }

	    if (isNaN(gradeVal) || gradeVal < 1 || gradeVal > 9) {
	      gradeInput.css('border', '1px solid #dc2626');
	      return showSwal('등급은 1 이상 9 이하의 숫자로 입력하세요.');
	    }

	    data.push({
	      subjectName: sub,
	      targetScore: scoreVal,
	      targetLevel: gradeVal
	    });

	    subjectNames.push(sub);
	    scoreValues.push(scoreRaw);
	    gradeValues.push(gradeRaw);
	  });
	  

	  if (emptyFound) return showSwal('입력하지 않은 항목이 있습니다.');

	  const requestPayload = {
	    memberNo: memberNo,
	    examTypeId: parseInt(examType),
	    subjectScores: data
	  };

	  $.ajax({
	    url: '/goal_score/insert',
	    method: 'POST',
	    contentType: 'application/json',
	    data: JSON.stringify(requestPayload),
	    xhrFields: { withCredentials: true },
	    success: function (res) {
	      if (!res.success) {
	        if (res.reason === 'duplicate') return showSwal('이미 목표 성적을 입력하였습니다.', "error");
	        return showSwal('입력실패', "error");
	      }
	      showSwal('입력완료', "success");
	      renderResultTable(subjectNames, scoreValues, gradeValues);
	      $('.score-input, .grade-input').hide();
	      $('#final-submit').hide();
	    },
	    error: function () {
	      showSwal('서버 오류로 저장에 실패했습니다.', "error");
	    }
	  });
	});

	// [I] 결과 테이블 렌더링
	function renderResultTable(subs, scores, grades) {
	  let html = '';
	  for (let i = 0; i < subs.length; i++) {
	    html += `
		<tr>
		  <td>${subs[i]}</td>
		  <td>${scores[i]}</td>
		  <td>${grades[i]}</td>
		  </tr>
		  `;
	  }
	  $('#score-body').html(html);
	}

	// ✅ Swal 기반 알림 함수 (공통 사용)
	// 디폴트 알림창 : 경고
	function showSwal(msg, icon = "warning", callback) {
	  return Swal.fire({
		  text: msg,
		  confirmButtonColor: "#205DAC",
		  icon: icon,
		  confirmButtonText: '확인'
		}).then(() => {
	    if (typeof callback === 'function') {
	      callback();
	    }
	  });
	}
	
	});