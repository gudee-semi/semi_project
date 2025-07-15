$(document).ready(function () {
  const examCheckboxes = $('input[name="exam"]');
  let availableCount = 0;

  // [A] 시험 분류 체크박스 활성화 조건
  examCheckboxes.each(function () {
    const examMonth = parseInt($(this).val(), 10);

    if (examMonth === 11) {
      // 11월(수능): 3학년만 허용
      if (studentGrade === 3) {
        $(this).prop('disabled', false).prop('checked', false);
        availableCount++;
      } else {
        $(this).prop('disabled', true).prop('checked', false);
      }
    } else {
      // 3, 6, 9월: 모든 학년 가능
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

  // [C] 시험 분류 선택 이벤트: 단일 선택 + 추가 과목 토글 처리
  examCheckboxes.change(function () {
    // 하나만 선택되도록 다른 체크 해제
    examCheckboxes.not(this).prop('checked', false);

    // 성적표 초기화
    $('#exam-title').hide().text('');
    $('#selected-subjects').text('');
    $('#score-table').hide();
    $('#score-body').empty();
    $('#final-submit').hide();

    // 탐구/제2외국어 과목 초기화
    $('.explore-subject, .lang2-subject').prop('checked', false);

    const val = $(this).val();
    if (studentGrade === 3 && ['6', '9', '11'].includes(val)) {
      $('#science2-section, #lang2-section').show();
    } else {
      $('#science2-section, #lang2-section').hide();
      $('.science2-subject, .lang2-subject').prop('checked', false);
    }
  }).trigger('change');
});

  // [2] 탐구 2개 제한 + 제2외국어 1개 제한
  $('.explore-subject').change(function () {
    if ($('.explore-subject:checked').length > 2) {
      $(this).prop('checked', false);
      showModal("탐구과목은 2개까지 선택 가능합니다.");
    }
  });
  $('.lang2-subject').change(function () {
    if ($('.lang2-subject:checked').length > 1) {
      $(this).prop('checked', false);
      showModal("제2외국어는 1개만 선택 가능합니다.");
    }
  });

  // [3] 선택완료 버튼 동작
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

  // [4] 유효성 검사
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

  // [6~8] 설정완료
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

      const scoreRaw = scoreInput.val().trim();
      const gradeRaw = gradeInput.val().trim();
      const sub = scoreInput.data('subject');

      // 입력 칸 초기화
      scoreInput.css('border', '');
      gradeInput.css('border', '');

      // 미입력 검사 및 시각 표시
      if (scoreRaw === '' || gradeRaw === '') {
        if (scoreRaw === '') scoreInput.css('border', '2px solid #dc2626');
        if (gradeRaw === '') gradeInput.css('border', '2px solid #dc2626');
        emptyFound = true;
        return false;
      }

      // 유효성 검사
	  // 원점수는 0~100 사이의 값, 등급은 1~0 사이의 값만 입력 가능
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

	// 입력하지 않은 칸이 존재하면 모달창 뜨기
    if (emptyFound) {
      return showModal('입력하지 않은 항목이 있습니다.');
    }

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
      success: function (res) {
        // 수정: 중복 응답 처리
        if (!res.success) {
          if (res.reason === 'duplicate') {
            return showModal('이미 목표 성적을 입력하였습니다.');
          }
          return showModal('입력실패');
        }

        // ✅ 정상 응답 처리
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

  function renderResultTable(subs, scores, grades) {
    let html = '';
    for (let i = 0; i < subs.length; i++) {
      html += `<tr><td>${subs[i]}</td><td>${scores[i]}</td><td>${grades[i]}</td></tr>`;
    }
    $('#score-body').html(html);
  }

  function showModal(msg) {
    $('#modal-message').text(msg);
    $('#modal').show();
  }

  $('#modal-close-btn').click(() => $('#modal').hide());
});
