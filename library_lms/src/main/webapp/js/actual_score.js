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
		<td><input type="text" class="percent-input input-center" data-subject="${sub}" placeholder="입력"></td>
		    <td>${
		      ['국어', '수학'].includes(sub) ?
		        `<input type="text" class="rank-input input-center" data-subject="${sub}" placeholder="본인등수/전교 인원수">` :
		        '-'
		    }</td>
		  </tr>
    `).join(''));

    $('#score-table').show();
    $('#final-submit').show();
  });

  // [G] 입력값 유효성 검사
  // 원점수 입력란
  $(document).on('blur', '.score-input', function () {
    const v = parseInt($(this).val());
    if ($(this).val() !== '' && (isNaN(v) || v < 0 || v > 100)) {
      showModal("원점수는 0~100 사이여야 합니다.");
    }
  });

  // 등급 입력란
  $(document).on('blur', '.grade-input', function () {
    const v = parseInt($(this).val());
    if ($(this).val() !== '' && (isNaN(v) || v < 1 || v > 9)) {
      showModal("등급은 1~9 사이여야 합니다.");
    }
  });
  
  // 백분위 입력란
  $(document).on('blur', '.percent-input', function () {
    const v = parseFloat($(this).val());
    if ($(this).val() !== '' && (isNaN(v) || v < 0 || v > 100)) {
      showModal("백분위는 0~100 사이여야 합니다.");
    }
  });
  
  // 학교석차 입력란 유효성 검사
   $(document).on('blur', '.rank-input', function () {
     const v = $(this).val().trim();
     if (v && !/^\d+\/\d+$/.test(v)) {
       showModal("석차는 (본인등수/전체인원수) 형식으로 입력하세요.");
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
    const percentageValues = [];
    const rank = [];
    let emptyFound = false;

    $('#score-body tr').each(function () {
	const sub = $(this).find('td:first').text().trim();
	const scoreRaw = ($(this).find('.score-input').val() || '').trim();
	const gradeRaw = ($(this).find('.grade-input').val() || '').trim();
	const percentRaw = ($(this).find('.percent-input').val() || '').trim();
	const rankRaw = ($(this).find('.rank-input').val() || '-').trim();

	// 유효성 검사: 빈칸일 경우 빨간 테두리
      if (scoreRaw === '' || gradeRaw === '') {
        if (scoreRaw === '') $(this).find('.score-input').css('border', '2px solid red');
        if (gradeRaw === '') $(this).find('.grade-input').css('border', '2px solid red');
        emptyFound = true;
        return false;
      }

      if (isNaN(scoreRaw) || scoreRaw < 0 || scoreRaw > 100) return showModal('원점수는 0~100 사이여야 합니다.');
      if (isNaN(gradeRaw) || gradeRaw < 1 || gradeRaw > 9) return showModal('등급은 1~9 사이여야 합니다.');
      if (percentRaw !== '' && (isNaN(percentRaw) || percentRaw < 0 || percentRaw > 100)) return showModal('백분위는 0~100 사이여야 합니다.');

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
      rank.push(['국어', '수학'].includes(sub) ? (rankRaw || '-') : '-');
    });

	if (emptyFound) return showModal('입력하지 않은 항목이 있습니다.');

	// [1] JSON으로 보낼 객체 구성
	// 전송 객체 만들기
	const subjectScores = [];
	for (let i = 0; i < subjectNames.length; i++) {
	  subjectScores.push({
	    subjectName: subjectNames[i],
	    actualScore: parseInt(scoreValues[i], 10),
	    actualLevel: parseInt(gradeValues[i], 10),
	    actualPercentage: percentageValues[i] === '-' ? null : parseFloat(percentageValues[i]),
	    actualRank: rank[i] === '-' ? null : rank[i]
	  });
	}


	// [2] 요청 객체
	const requestPayload = {
	  memberNo: memberNo,
	  examTypeId: parseInt($('.exam-type:checked').val()),
	  subjectScores: subjectScores
	};

	// [3] 전송
	$.ajax({
	  url: '/actual_score/insert',
	  method: 'POST',
	  contentType: 'application/json',
	  data: JSON.stringify(requestPayload),
	  xhrFields: {
	    withCredentials: true  // 세션 유지
	  },
	  success: function (res) {
	    // ✅ 먼저 중복 여부 확인
	    if (res.status === 'duplicate') {
	      return showModal('이미 목표 성적을 입력하였습니다.');
	    }

	    // ✅ 서버에서 실패 응답 (성공 여부가 false일 때)
	    if (!res.success) {
	      return showModal('입력 실패');
	    }

	    // ✅ 성공 처리
	    showModal('입력 완료');
	    renderResultTable(subjectNames, scoreValues, gradeValues, percentageValues, rank);
	    $('.score-input, .grade-input').hide();
	    $('#final-submit').hide();
	  },
	  error: function () {
	    showModal('서버 오류로 저장에 실패했습니다.');
	  }
	});


	  });
	  
	  // [I] 테이블 렌더링
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


	    // [J] 모달
	    function showModal(msg) {
	      $('#modal-message').text(msg);
	      $('#modal').show();
	    }

	    $('#modal-close-btn').click(() => $('#modal').hide());
	  });
