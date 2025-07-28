$(document).ready(function () {
  // [1] 삭제 결과에 따라 알림 표시
  const params = new URLSearchParams(window.location.search);
  const deleteResult = params.get("delete");
  const msg = params.get("msg") ? decodeURIComponent(params.get("msg")) : "";

  if (deleteResult === "success") {
    showSwal("삭제완료", "success").then(() => {
      window.location.href = "/analysis_scorePage/view";
    });
    return;
  } else if (deleteResult === "fail") {
    showSwal(msg || "삭제실패");
  }

  // [2] 세션에서 값 추출
  const memberNo = parseInt($('#memberNo').val());
  const studentGrade = parseInt($('#studentGrade').val());

  // [3] 시험 체크박스
  const examCheckboxes = $('input[name="exam"]');

  // 삭제 버튼 초기 숨김
  $('#delete-submit').hide();

  // [A] DB에 입력된 시험만 체크박스 활성화
  $.ajax({
    url: '/analysis_score/select',
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

  // [B] 시험 선택 → 테이블 + 차트 조회
  examCheckboxes.change(function () {
    examCheckboxes.not(this).prop('checked', false);

    if (!$(this).is(':checked')) {
      $('#score-table-wrapper').empty();
      $('#delete-btn').prop('disabled', true);
      $('#delete-submit').hide();
      $('#scoreComparisonChart').hide();
      $('#scoreRadarChart').hide();
      return;
    }

    const examTypeId = parseInt($(this).val());

    // [1] 성적 테이블 조회
    $.ajax({
      url: '/analysis_score/select',
      method: 'GET',
      data: {
        memberNo: memberNo,
        examTypeId: examTypeId,
        chartOnly: false
      },
      success: function (res) {
        $('#score-table-wrapper').html(res);

        // [2] 차트 데이터 조회
        $.ajax({
          url: '/analysis_score/select',
          method: 'GET',
          data: {
            memberNo: memberNo,
            examTypeId: examTypeId,
            chartOnly: true
          },
          success: function (chartRes) {
            $('#delete-submit').show();
            $('#scoreComparisonChart').show();
            $('#scoreRadarChart').show();

            if (window.scoreChart) window.scoreChart.destroy();
            if (window.radarChart) window.radarChart.destroy();

            const labels = chartRes.subjectNames;
            const goalScores = chartRes.goalScores;
            const actualScores = chartRes.actualScores;

            const barCtx = document.getElementById('scoreComparisonChart').getContext('2d');
            window.scoreChart = new Chart(barCtx, {
              type: 'bar',
              data: {
                labels: labels,
                datasets: [
                  {
                    label: '목표 점수',
                    data: goalScores,
                    backgroundColor: 'rgba(147, 197, 253, 0.5)',
                    borderColor: 'rgba(147, 197, 253, 0.5)',
                    borderWidth: 1
                  },
                  {
                    label: '실제 점수',
                    data: actualScores,
                    backgroundColor: 'rgba(59, 130, 246, 0.5)',
                    borderColor: 'rgba(59, 130, 246, 0.5)',
                    borderWidth: 1
                  }
                ]
              },
              options: {
                responsive: true,
                maintainAspectRatio: false,
                scales: { y: { beginAtZero: true, max: 100 } }
              }
            });

            const radarCtx = document.getElementById('scoreRadarChart').getContext('2d');
            window.radarChart = new Chart(radarCtx, {
              type: 'radar',
              data: {
                labels: labels,
                datasets: [
                  {
                    label: '목표 점수',
                    data: goalScores,
                    fill: true,
                    backgroundColor: 'rgba(147, 197, 253, 0.5)',
                    borderColor: 'rgba(147, 197, 253, 0.5)',
                    pointBackgroundColor: 'rgba(147, 197, 253, 0.5)'
                  },
                  {
                    label: '실제 점수',
                    data: actualScores,
                    fill: true,
                    backgroundColor: 'rgba(59, 130, 246, 0.5)',
                    borderColor: 'rgba(147, 197, 253, 1)',
                    pointBackgroundColor: 'rgba(147, 197, 253, 1)'
                  }
                ]
              },
              options: {
                responsive: true,
                maintainAspectRatio: false,
                scales: { r: { beginAtZero: true, max: 100 } }
              }
            });

            $('#delete-btn').prop('disabled', false);
          },
          error: () => showSwal("차트 데이터를 불러오는데 실패했습니다.")
        });
      },
      error: () => showSwal("성적표 데이터를 불러오는데 실패했습니다.")
    });
  });

  // 삭제 버튼 클릭
  $('#delete-submit').on('click', function (e) {
    e.preventDefault();
    const selectedExamTypeId = $('input[name="exam"]:checked').val();

    if (!memberNo || !selectedExamTypeId) {
      return showSwal("시험 분류를 선택해 주세요.", "warning");
    }

    // 삭제 확인 모달
    Swal.fire({
      text: "삭제하시겠습니까?",
      icon: "question",
      showCancelButton: true,
      confirmButtonColor: "#d33",
      cancelButtonColor: "#205DAC",
      confirmButtonText: "삭제",
      cancelButtonText: "취소"
    }).then((result) => {
      if (result.isConfirmed) {
        // ✅ 실제 삭제 AJAX 요청
        $.ajax({
          url: '/analysis_score/delete',
          type: 'POST',
          data: {
            memberNo: memberNo,
            examTypeId: selectedExamTypeId
          },
          success: function () {
            showSwal("삭제완료", "success").then(() => {
              window.location.href = "/analysis_scorePage/view";
            });
          },
          error: function (xhr) {
            const msg = xhr.responseText || "삭제실패";
            showSwal(msg);
          }
        });
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
