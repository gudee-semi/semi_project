$(document).ready(function () {
  const examCheckboxes = $('input[name="exam"]');
  let availableCount = 0;

  // [A] 시험 체크박스 활성화 조건
  examCheckboxes.each(function () {
    const examMonth = parseInt($(this).val(), 10);

    if (examMonth === 11) {
      // 11월(수능)은 3학년만 선택 가능
      if (studentGrade === 3) {
        $(this).prop('disabled', false).prop('checked', false);
        availableCount++;
      } else {
        $(this).prop('disabled', true).prop('checked', false);
      }
    } else {
      // 3, 6, 9월은 전 학년 허용
      $(this).prop('disabled', false).prop('checked', false);
      availableCount++;
    }
  });

  // [B] 선택 가능한 시험이 없으면 안내 문구 출력
  if (availableCount === 0) {
    $('#exam-options').append(`
      <div style="color:#dc2626;margin:10px 0 0 10%;font-size:16px;font-weight:500;">
        선택 가능한 시험이 없습니다.
      </div>
    `);
  }

  // [C] 시험 선택: 하나만 선택 + 과목 토글
  examCheckboxes.change(function () {
    examCheckboxes.not(this).prop('checked', false); // 하나만 선택되도록

    // 초기화
    $('#exam-title').hide().text('');
    $('#selected-subjects').text('');
    $('#score-table').hide();
    $('#score-body').empty();
    $('#final-submit').hide();
    $('.explore-subject, .lang2-subject').prop('checked', false);

    // 과목 토글 조건
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
      showModal("탐구과목은 2개까지 선택 가능합니다.");
    }
  });

  // [E] 제2외국어 1개 제한
  $('.lang2-subject').change(function () {
    if ($('.lang2-subject:checked').length > 1) {
      $(this).prop('checked', false);
      showModal("제2외국어는 1개만 선택 가능합니다.");
    }
  });

  // [F] 선택완료 버튼 → 입력창 생성
  $('#confirm-subjects').click(function () {
    const examMonth = $('.exam-type:checked').val();
    if (!examMonth) return showModal("시험 분류를 선택해주세요.");

    const selected = ['국어', '수학', '영어', '한국사'];
    $('.explore-subject:checked, .lang2-subject:checked').each(function () {
      selected.push($(this).val());
    });

    if (selected.length < 5) return showModal("탐구/선택 과목을 1개 이상 선택해주세요.");

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

  // [G] 입력값 유효성 검사
  $(document).on('blur', '.score-input', function () {
    const v = parseInt($(this).val());
    if ($(this).val() !== '' && (isNaN(v) || v < 0 || v > 100)) {
      showModal("원점수는 0~100 사이여야 합니다.");
    }
  });

  $(document).on('blur', '.grade-input', function () {
    const v = parseInt($(this).val());
    if ($(this).val() !== '' && (isNaN(v) || v < 1 || v > 9)) {
      showModal("등급은 1~9 사이여야 합니다.");
    }
  });

  // [H] 설정완료 → DB 전송
  $('#final-submit').click(function () {
    const examType = $('.exam-type:checked').val();
    if (!examType) return showModal('시험 분류를 선택하세요.');

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

      scoreInput.css('border', '');
      gradeInput.css('border', '');

      if (scoreRaw === '' || gradeRaw === '') {
        if (scoreRaw === '') scoreInput.css('border', '2px solid #dc2626');
        if (gradeRaw === '') gradeInput.css('border', '2px solid #dc2626');
        emptyFound = true;
        return false;
      }

      if ((isNaN(scoreRaw) || scoreRaw < 0 || scoreRaw > 100)) return showModal('원점수는 0~100 사이여야 합니다.');
      if ((isNaN(gradeRaw) || gradeRaw < 1 || gradeRaw > 9)) return showModal('등급은 1~9 사이여야 합니다.');

      data.push({
        subjectName: sub,
        targetScore: parseInt(scoreRaw),
        targetLevel: parseInt(gradeRaw)
      });

      subjectNames.push(sub);
      scoreValues.push(scoreRaw);
      gradeValues.push(gradeRaw);
    });

    if (emptyFound) return showModal('입력하지 않은 항목이 있습니다.');

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
	  xhrFields: {
	    withCredentials: true    // ✅ 세션 쿠키 포함 필수!
	  },
	  success: function (res) {
	    if (!res.success) {
	      if (res.reason === 'duplicate') return showModal('이미 목표 성적을 입력하였습니다.');
	      return showModal('입력실패');
	    }
	    showModal('입력완료');
	    renderResultTable(subjectNames, scoreValues, gradeValues);
	    $('.score-input, .grade-input').hide();
	    $('#final-submit').hide();
	  },
	  error: function () {
	    showModal('서버 오류로 저장에 실패했습니다.');
	  }
	});
	});
  // [I] 결과 테이블 렌더링 함수
  function renderResultTable(subs, scores, grades) {
    let html = '';
    for (let i = 0; i < subs.length; i++) {
      html += `<tr><td>${subs[i]}</td><td>${scores[i]}</td><td>${grades[i]}</td></tr>`;
    }
    $('#score-body').html(html);
  }

  // [J] 모달 출력 함수
  function showModal(msg) {
    $('#modal-message').text(msg);
    $('#modal').show();
  }

  $('#modal-close-btn').click(() => $('#modal').hide());
});
