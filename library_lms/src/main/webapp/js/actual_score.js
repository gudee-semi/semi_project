$(document).ready(function () {
  const examCheckboxes = $('input[name="exam"]');
  let availableCount = 0;

  const socialSubjects = ["경제", "사회문화", "법과정치", "윤리와 사상", "세계지리", "한국지리", "세계사", "동아시아사", "생활과 윤리"];
  const science1Subjects = ["물리1", "화학1", "생명과학1", "지구과학1"];
  const science2Subjects = ["물리학2", "화학2", "생명과학2", "지구과학2"];
  const lang2Subjects = ["독일어", "프랑스어", "스페인어", "중국어", "일본어", "러시아어", "아랍어", "베트남어", "한문"];

  // [A] 시험 체크박스 활성화
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

  // [C] 시험 선택시 UI 초기화 및 동적 탐구/외국어 표시
  examCheckboxes.change(function () {
    examCheckboxes.not(this).prop('checked', false);
    $('#exam-title').hide().text('');
    $('#selected-subjects').text('');
    $('#score-table').hide();
    $('#score-body').empty();
    $('#final-submit').hide();
    $('.explore-subject, .lang2-subject').prop('checked', false);

    const val = $(this).val();
    if (studentGrade === 3 && ['6', '9', '11'].includes(val)) {
      $('#science2-section, #lang2-section').show();
    } else {
      $('#science2-section, #lang2-section').hide();
      $('.science2-subject, .lang2-subject').prop('checked', false);
    }
  }).trigger('change');

  // [D] 탐구 과목 2개 제한
  $('.explore-subject').change(function () {
    if ($('.explore-subject:checked').length > 2) {
      $(this).prop('checked', false);
      showSwal("탐구과목은 2개까지 선택 가능합니다.");
    }
  });

  // [E] 제2외국어 1개 제한
  $('.lang2-subject').change(function () {
    if ($('.lang2-subject:checked').length > 1) {
      $(this).prop('checked', false);
      showSwal("제2외국어는 1개만 선택 가능합니다.");
    }
  });

  // [F] 선택완료 → 입력창 동적 생성
  $('#confirm-subjects').click(function () {
    const examMonth = $('.exam-type:checked').val();
    if (!examMonth) return showSwal("시험 분류를 선택해주세요.");

    const selected = ['국어', '수학', '영어', '한국사'];
    $('.explore-subject:checked, .lang2-subject:checked').each(function () {
      selected.push($(this).val());
    });

    if (selected.length < 5) return showSwal("탐구/선택 과목을 1개 이상 선택해주세요.");

    $('#exam-title').text(`${currentYear}년 ${examMonth}월 모의고사`).show();
    $('#selected-subjects').text(selected.join(' | '));

    $('#score-body').html(selected.map(sub => {
      const percentInput = ['영어', '한국사', ...lang2Subjects].includes(sub)
        ? '-' : `<input type="text" class="percent-input input-center" data-subject="${sub}" placeholder="입력">`;
      const rankInput = ['국어', '수학'].includes(sub)
        ? `<input type="text" class="rank-input input-center" data-subject="${sub}" placeholder="본인등수/전교 인원수">`
        : '-';
      return `
        <tr>
          <td>${sub}</td>
          <td><input type="text" class="score-input input-center" data-subject="${sub}" placeholder="입력"></td>
          <td><input type="text" class="grade-input input-center" data-subject="${sub}" placeholder="입력"></td>
          <td>${percentInput}</td>
          <td>${rankInput}</td>
        </tr>
      `;
    }).join(''));

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

		// [G-3] 백분위 유효성 검사 (0~100, 소수 둘째자리까지, 선행 0/소수점 3자리 이상 불가)
		$(document).on('blur', '.percent-input', function () {
		  const input = $(this);
		  const val = input.val().trim();

		  // [추가] 0, 1~99, 100 (정수), 0.01~99.99, 100.0~100.00 (소수점 둘째자리까지)
		  // - 0, 1~99, 100  (정수, 선행0 불가)
		  // - 0.xx, 1.xx~99.xx, 100.0~100.00 (소수 둘째자리까지, 선행0불가)
		  // - 00, 01, 1.000, 0.000 등 모두 불가
		  const regexPercent = /^(0|100|[1-9][0-9]?)(\.\d{1,2})?$/;

		  if (val === '') return input.css('border', '');

		  // 정규식 통과 + 소수점 둘째자리까지 확인
		  if (!regexPercent.test(val)) {
		    input.css('border', '1px solid #dc2626');
		    return showSwal("백분위는 0 DLTKD 100 이하의 정수, 소수 둘째자리까지만 입력하세요.", "warning", () => {
		      input.val('').focus();
		    });
		  }

		  // [추가] 범위 체크(0~100, 100.01~ 등 방지)
		  const num = Number(val);
		  if (isNaN(num) || num < 0 || num > 100) {
		    input.css('border', '1px solid #dc2626');
		    return showSwal("백분위는 0~100 사이여야 합니다.", "warning", () => {
		      input.val('').focus();
		    });
		  }

		  // [추가] 0.00, 100.000 등 소수점 셋째자리 이상 차단
		  if (val.includes('.')) {
		    const decimal = val.split('.')[1];
		    if (decimal && decimal.length > 2) {
		      input.css('border', '1px solid #dc2626');
		      return showSwal("소수점 둘째자리까지만 입력하세요.", "warning", () => {
		        input.val('').focus();
		      });
		    }
		  }

		  // 통과: 테두리 제거
		  input.css('border', '');
		});



  // [G-4] 석차 유효성 검사
  $(document).on('blur', '.rank-input', function () {
    const input = $(this);
    const val = input.val().trim();
    if (val === '') return input.css('border', '');

    const match = val.match(/^(\d+)\/(\d+)$/);
    if (!match) {
      input.css('border', '1px solid #dc2626');
      return showSwal("석차는 (본인등수/전체 인원수) 형식으로 입력하세요.", "warning", () => {
        input.val('').focus();
      });
    }

    const myRank = parseInt(match[1], 10);
    const total = parseInt(match[2], 10);

    if (myRank < 1 || total < 1 || myRank > total) {
      input.css('border', '1px solid #dc2626');
      return showSwal("본인 등수는 전체 인원수보다 작거나 같아야 하며 1 이상이어야 합니다.", "Warning", () => {
        input.val('').focus();
      });
    } else {
      input.css('border', '');
    }
  });

  // [H] 설정완료 버튼 → 입력값 유효성 검사 + DB 전송
  $('#final-submit').click(function () {
    const examType = $('.exam-type:checked').val();
    if (!examType) return showSwal('시험 분류를 선택하세요.');

    const data = [];
    const subjectNames = [];
    const scoreValues = [];
    const gradeValues = [];
    const percentageValues = [];
    const rankValues = [];
    let emptyFound = false;

	$('#score-body tr').each(function () {
	  const sub = $(this).find('td:first').text().trim();
	  const scoreInput = $(this).find('.score-input');
	  const gradeInput = $(this).find('.grade-input');
	  const percentInput = $(this).find('.percent-input');
	  const rankInput = $(this).find('.rank-input');

	  const scoreRaw = (scoreInput.val() || '').trim();
	  const gradeRaw = (gradeInput.val() || '').trim();
	  const percentRaw = percentInput.length ? (percentInput.val() || '').trim() : null;
	  const rankRaw = rankInput.length ? (rankInput.val() || '').trim() : null;

	  if (scoreInput.length && scoreRaw === '') scoreInput.css('border', '1px solid #dc2626');
	  if (gradeInput.length && gradeRaw === '') gradeInput.css('border', '1px solid #dc2626');
	  if (percentInput.length && percentRaw === '') percentInput.css('border', '1px solid #dc2626');
	  if (rankInput.length && rankRaw === '') rankInput.css('border', '1px solid #dc2626');

	  if ((scoreInput.length && scoreRaw === '') ||
	      (gradeInput.length && gradeRaw === '') ||
	      (percentInput.length && percentRaw === '') ||
	      (rankInput.length && rankRaw === '')) {
	    emptyFound = true;
	    return false;
	  }

      // 이미 blur에서 유효성 검사, 추가 체크시 아래 참고
      // if (isNaN(scoreRaw) || scoreRaw < 0 || scoreRaw > 100) return showSwal('원점수는 0 이상 100 이하의 숫자로 입력하세요.');
      // if (isNaN(gradeRaw) || gradeRaw < 1 || gradeRaw > 9) return showSwal('등급은 1 이상 9 이하의 숫자로 입력하세요.');
      // if (percentRaw !== '' && (isNaN(percentRaw) || percentRaw < 0 || percentRaw > 100)) return showSwal('백분위는 0 이상 100 이하의 숫자로 입력하세요.');

      data.push({
        subjectName: sub,
        targetScore: parseInt(scoreRaw),
        targetLevel: parseInt(gradeRaw),
        percentage: percentRaw === '' ? null : parseFloat(percentRaw),
        rank: ['국어', '수학'].includes(sub) ? rankRaw : null
      });

      subjectNames.push(sub);
      scoreValues.push(scoreRaw);
      gradeValues.push(gradeRaw);
      percentageValues.push(percentRaw || '-');
      rankValues.push(['국어', '수학'].includes(sub) ? (rankRaw || '-') : '-');
    });

    if (emptyFound) return showSwal('입력하지 않은 항목이 있습니다.');

    // [1] 전송 데이터 구성
    const subjectScores = subjectNames.map((subject, i) => ({
      subjectName: subject,
      actualScore: parseInt(scoreValues[i], 10),
      actualLevel: parseInt(gradeValues[i], 10),
      actualPercentage: percentageValues[i] === '-' ? null : parseFloat(percentageValues[i]),
      actualRank: rankValues[i] === '-' ? null : rankValues[i]
    }));

    const requestPayload = {
      memberNo: memberNo,
      examTypeId: parseInt($('.exam-type:checked').val()),
      subjectScores: subjectScores
    };

    // [2] AJAX 전송
    $.ajax({
      url: '/actual_score/insert',
      method: 'POST',
      contentType: 'application/json',
      data: JSON.stringify(requestPayload),
      xhrFields: { withCredentials: true },
      success: function (res) {
        if (res.status === 'duplicate') return showSwal('이미 성적을 입력하였습니다.', "error");
        if (!res.success) return showSwal('입력 실패', "error");
        showSwal('입력 완료', "success");
        renderResultTable(subjectNames, scoreValues, gradeValues, percentageValues, rankValues);
        $('.score-input, .grade-input').hide();
        $('#final-submit').hide();
      },
      error: function () {
        showSwal('서버 오류로 저장에 실패했습니다.', "error");
      }
    });
  });

  // [I] 결과 테이블 렌더링
  function renderResultTable(subs, scores, grades, percentage, rank) {
    let html = '';
    for (let i = 0; i < subs.length; i++) {
      html += `
        <tr>
          <td>${subs[i]}</td>
          <td>${scores[i]}</td>
          <td>${grades[i]}</td>
          <td>${percentage[i]}</td>
          <td>${rank[i]}</td>
        </tr>
      `;
    }
    $('#score-body').html(html);
  }

  // [J] Swal 기반 알림 함수 (공통 사용)
  // 디폴트 알림창 : 경고
  function showSwal(msg, icon = "warning", callback) {
    return Swal.fire({
      text: msg,
      confirmButtonColor: "#205DAC",
	  icon: icon,
      confirmButtonText: '확인',
    }).then(() => {
      if (typeof callback === 'function') callback();
    });
  }
});
