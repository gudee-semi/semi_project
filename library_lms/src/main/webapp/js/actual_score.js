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

  // [G-1] 원점수 유효성 검사
  $(document).on('blur', '.score-input', function () {
    const input = $(this);
    const sub = input.data('subject');
    const val = input.val().trim();
    const v = parseInt(val);

    const isRestricted =
      sub === "한국사" ||
      socialSubjects.includes(sub) ||
      science1Subjects.includes(sub) ||
      science2Subjects.includes(sub) ||
      lang2Subjects.includes(sub);

    const min = 0;
    const max = isRestricted ? 50 : 100;

    if (val === '') return input.css('border', '');
    if (isNaN(v) || v < min || v > max) {
      input.css('border', '1px solid #dc2626');
      return showSwal(
        isRestricted
          ? "한국사/탐구/선택과목 원점수는 0 이상 50 이하의 숫자로 입력하세요."
          : "원점수는 0 이상 100 이하의 숫자로 입력하세요.",
        () => {
          input.val('').focus();
        }
      );
    } else {
      input.css('border', '');
    }
  });

  // [G-2] 등급 유효성 검사
  $(document).on('blur', '.grade-input', function () {
    const input = $(this);
    const val = input.val().trim();
    const v = parseInt(val);

    if (val === '') return input.css('border', '');
    if (isNaN(v) || v < 1 || v > 9) {
      input.css('border', '1px solid #dc2626');
      return showSwal("등급은 1 이상 9 이하의 숫자로 입력하세요.", () => {
        input.val('').focus();
      });
    } else {
      input.css('border', '');
    }
  });

  // [G-3] 백분위 유효성 검사
  $(document).on('blur', '.percent-input', function () {
    const input = $(this);
    const val = input.val().trim();
    const v = parseInt(val);

    if (val === '') return input.css('border', '');
    if (isNaN(v) || v < 0 || v > 100) {
      input.css('border', '1px solid #dc2626');
      return showSwal("백분위는 0 이상 100 이하의 숫자로 입력하세요.", () => {
        input.val('').focus();
      });
    } else {
      input.css('border', '');
    }
  });

  // [G-4] 석차 유효성 검사
  $(document).on('blur', '.rank-input', function () {
    const input = $(this);
    const val = input.val().trim();
    if (val === '') return input.css('border', '');

    const match = val.match(/^(\d+)\/(\d+)$/);
    if (!match) {
      input.css('border', '1px solid #dc2626');
      return showSwal("석차는 (본인등수/전체 인원수) 형식으로 입력하세요.", () => {
        input.val('').focus();
      });
    }

    const myRank = parseInt(match[1], 10);
    const total = parseInt(match[2], 10);

    if (myRank < 1 || total < 1 || myRank > total) {
      input.css('border', '1px solid #dc2626');
      return showSwal("본인 등수는 전체 인원수보다 작거나 같아야 하며 1 이상이어야 합니다.", () => {
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
        if (res.status === 'duplicate') return showSwal('이미 성적을 입력하였습니다.');
        if (!res.success) return showSwal('입력 실패');
        showSwal('입력 완료');
        renderResultTable(subjectNames, scoreValues, gradeValues, percentageValues, rankValues);
        $('.score-input, .grade-input').hide();
        $('#final-submit').hide();
      },
      error: function () {
        showSwal('서버 오류로 저장에 실패했습니다.');
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
  function showSwal(msg, callback) {
    return Swal.fire({
      title: " ",
      text: msg,
      confirmButtonText: '확인',
      confirmButtonColor: "#205DAC"
    }).then(() => {
      if (typeof callback === 'function') callback();
    });
  }
});
