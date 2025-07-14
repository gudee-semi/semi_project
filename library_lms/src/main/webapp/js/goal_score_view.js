$(document).ready(function () {
  // [1] 현재 월 계산
  const now = new Date();
  const nowMonth = now.getMonth() + 1; // 0~11이므로 +1 필요
  let availableCount = 0;

  // [2] 시험 분류 체크박스 활성/비활성 처리
  $('.exam-type').each(function () {
    const examMonth = parseInt($(this).val(), 10);
    if (examMonth < nowMonth) {
      $(this).prop('disabled', true).prop('checked', false); // 지난 시험은 비활성화
    } else {
      $(this).prop('disabled', false); // 다가올 시험만 활성화
      availableCount++;
    }
  });

  // [3] 3학년인 경우 10월~12월엔 11월(수능)만 선택 가능
  if (studentGrade === 3 && nowMonth >= 10 && nowMonth <= 12) {
    $('.exam-type').each(function () {
      if ($(this).val() !== '11') {
        $(this).prop('disabled', true).prop('checked', false);
      } else {
        $(this).prop('disabled', false).prop('checked', true);
      }
    });
    availableCount = 1;
  }

  // [4] 1~2학년이 10월 이후에는 전부 비활성화
  if ((studentGrade === 1 || studentGrade === 2) && nowMonth >= 10 && nowMonth <= 12) {
    $('.exam-type').prop('disabled', true).prop('checked', false);
    availableCount = 0;
  }

  // [5] 선택 가능한 시험이 없으면 안내 메시지 출력 후 종료
  if (availableCount === 0) {
    $('#exam-options').append(
      '<div style="color:#dc2626; margin:10px 0 0 10%; font-size:16px; font-weight:500;">선택 가능한 시험이 없습니다.</div>'
    );
    return;
  }

  // [6] 선택된 시험 ID 가져오기 (체크된 라디오값)
  const examType = $('.exam-type:checked').val();
  if (!examType) {
    return; // 선택된 값이 없으면 종료
  }

  // [7] 서버에 보낼 조회용 파라미터 (GET 방식이므로 객체로 전달)
  const requestParams = {
    memberNo: memberNo, // ❗ JSP에서 선언한 전역변수 사용 (재선언 X)
    examTypeId: parseInt(examType)
  };

  // [8] AJAX 요청 → 목표 성적 조회
  $.ajax({
    url: '/goal_score_view/select', // ❗ 매핑된 서블릿 or 컨트롤러 경로여야 함
    method: 'GET',
    data: requestParams,
    success: function (res) {
      if (!res || res.length === 0) {
        $('#exam-title').hide();
        $('#selected-subjects').text('');
        $('#score-table').hide();
        showModal('입력된 성적이 없습니다.');
        return;
      }

      // [8-1] 시험명 출력 (예: 2025년 9월 모의고사)
      const examMonth = parseExamMonth(res[0].examTypeId);
      $('#exam-title').text(`${currentYear}년 ${examMonth}월 모의고사`).show();

      // [8-2] 선택된 과목 목록 출력
      const subjects = res.map(r => r.subjectName).join(' | ');
      $('#selected-subjects').text(subjects);

      // [8-3] 점수/등급 테이블 출력
      renderResultTable(res);
      $('#score-table').show();
    },
    error: function () {
      showModal('서버 오류로 조회에 실패했습니다.');
    }
  });
});

// ✅ 시험 ID → 월 변환 함수
function parseExamMonth(examTypeId) {
  const map = {
    1: 3, 2: 6, 3: 9, 4: 11,
    11: 11 // 수능 처리용 (중복 가능)
  };
  return map[examTypeId] || '?';
}

// ✅ 결과 테이블 렌더링 함수
function renderResultTable(scoreList) {
  let html = '';
  scoreList.forEach(item => {
    html += `
      <tr>
        <td>${item.subjectName}</td>
        <td>${item.targetScore ?? '-'}</td>
        <td>${item.targetLevel ?? '-'}</td>
      </tr>`;
  });
  $('#score-body').html(html);
}

// ✅ 모달 알림 함수
function showModal(msg) {
  $('#modal-message').text(msg);
  $('#modal').show();
}

// ✅ 모달 닫기 버튼
$('#modal-close-btn').click(() => $('#modal').hide());
