$(document).ready(function () {
  // [1] 삭제 결과에 따라 알림 표시
  const params = new URLSearchParams(window.location.search);
  const deleteResult = params.get("delete");
  const msg = params.get("msg") ? decodeURIComponent(params.get("msg")) : "";

  if (deleteResult === "success") {
    showSwal("삭제 완료", "success").then(() => {
      window.location.href = "/goal_score_view/view";
    });
    return;
  } else if (deleteResult === "fail") {
    showSwal(msg || "삭제하지 못했습니다.");
  }

  // [2] 세션에서 값 가져오기
  const memberNo = parseInt($('#memberNo').val());
  const studentGrade = parseInt($('#studentGrade').val());

  // [3] 시험 체크박스
  const examCheckboxes = $('input[name="exam"]');

  // 삭제 버튼 초기 숨김
  $('#delete-submit').hide();

  // [A] DB에 입력된 시험만 체크박스 활성화
  $.ajax({
    url: '/goal_score_view/select',
    method: 'GET',
    data: { memberNo: memberNo },
    success: function (data) {
      examCheckboxes.each(function () {
        const examValue = parseInt($(this).val());
        const isEnabled = data.includes(examValue);
        $(this).prop('disabled', !isEnabled).prop('checked', false);
      });
    },
    error: function () {
      showSwal("⚠ 서버 오류: 시험 목록을 불러올 수 없습니다.");
    }
  });

  // [B] 시험 선택 시 목표 성적 조회
  examCheckboxes.change(function () {
    examCheckboxes.not(this).prop('checked', false);

    if (!$(this).is(':checked')) {
      $('#score-table').hide();
      $('#exam-title').empty();
      $('#selected-subjects').empty();
      $('#score-body').empty();
      $('#delete-btn').prop('disabled', true);
      $('#delete-submit').hide();
      return;
    }

    const examTypeId = parseInt($(this).val());

    $.ajax({
      url: '/goal_score_view/select',
      method: 'GET',
      data: {
        memberNo: memberNo,
        examTypeId: examTypeId
      },
      success: function (res) {
        $('#exam-title').html(res);
        $('#score-table').show();
        $('#delete-submit').show();
      },
      error: function () {
        showSwal("성적 데이터를 불러오는데 실패했습니다.");
      }
    });
  });

  // [D] 삭제 버튼 클릭 시 삭제 요청
  $('#delete-submit').on('click', function (e) {
    e.preventDefault();

    const selectedExamTypeId = $('input[name="exam"]:checked').val();

    if (!memberNo || !selectedExamTypeId) {
      return showSwal("시험 분류를 선택해 주세요.", "warning");
    }

    $.ajax({
      url: '/goal_score/delete',
      type: 'POST',
      data: {
        memberNo: memberNo,
        examTypeId: selectedExamTypeId
      },
      success: function () {
        showSwal("삭제 완료", "success").then(() => {
          window.location.href = "/goal_score_view/view";
        });
      },
      error: function (xhr) {
        const errMsg = xhr.responseText || "삭제하지 못했습니다.";
        showSwal(errMsg);
      }
    });
  });

  // ✅ [J] Swal 기반 알림 함수 (공통 사용)
  // 디폴트 알림창 : 실패
  function showSwal(msg, icon = "error", callback) {
    return Swal.fire({
      text: msg,
      confirmButtonColor: "#205DAC",
	  icon: icon,
	  confirmButtonText: '확인'
    });
  }
});
