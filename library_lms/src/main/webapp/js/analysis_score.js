$(document).ready(function () {
  // [1] 삭제 결과 모달 알림
  const params = new URLSearchParams(window.location.search);
  const deleteResult = params.get("delete");
  const msg = params.get("msg") ? decodeURIComponent(params.get("msg")) : "";

  if (deleteResult === "success") {
    alert("삭제 완료");
    window.location.href = "/analysis_scorePage/view";
    return;
  } else if (deleteResult === "fail") {
    alert(msg || "삭제하지 못했습니다");
  }

  // [2] 세션에서 memberNo, studentGrade 값 추출
  const memberNo = parseInt($('#memberNo').val());
  const studentGrade = parseInt($('#studentGrade').val());

  // [3] 시험 체크박스
  const examCheckboxes = $('input[name="exam"]');

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
      alert("⚠ 서버 오류: 시험 목록을 불러올 수 없습니다.");
    }
  });

  // [B] 시험 선택 시 테이블 + 차트 조회
  examCheckboxes.change(function () {
    examCheckboxes.not(this).prop('checked', false);

    if (!$(this).is(':checked')) {
      $('#score-table-wrapper').empty();
      $('#scoreComparisonChart').hide();
      $('#scoreRadarChart').hide();
      return;
    }

    const examTypeId = parseInt($(this).val());

    // [1] 성적 테이블 불러오기
    $.ajax({
      url: '/analysis_score/select',
      method: 'GET',
      data: {
        memberNo: memberNo,
        examTypeId: examTypeId,
        chartOnly: false
      },
      success: function (res) {
        $('#score-table-wrapper').html(res); // 서버에서 렌더링한 <table> 응답 삽입

        // [2] 차트 데이터 요청
        $.ajax({
          url: '/analysis_score/select',
          method: 'GET',
          data: {
            memberNo: memberNo,
            examTypeId: examTypeId,
            chartOnly: true
          },
          success: function (chartRes) {
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
					        backgroundColor: 'rgba(59, 130, 246, 0.5)',  // 파란색
					        borderColor: 'rgba(59, 130, 246, 1)',
					        borderWidth: 1
					      },
					      {
					        label: '실제 점수',
					        data: actualScores,
					        backgroundColor: 'rgba(147, 197, 253, 0.5)',  // 연파랑
					        borderColor: 'rgba(147, 197, 253, 1)',
					        borderWidth: 1
					      }
                ]
              },
              options: {
                responsive: true,
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
					backgroundColor: 'rgba(59, 130, 246, 0.2)',
			        borderColor: 'rgba(59, 130, 246, 1)',
			        pointBackgroundColor: 'rgba(59, 130, 246, 1)'
                  },
                  {
                    label: '실제 점수',
                    data: actualScores,
                    fill: true,
					backgroundColor: 'rgba(147, 197, 253, 0.2)',
			       borderColor: 'rgba(147, 197, 253, 1)',
			       pointBackgroundColor: 'rgba(147, 197, 253, 1)'
                  }
                ]
              },
              options: {
                responsive: true,
                scales: { r: { beginAtZero: true, max: 100 } }
              }
            });

            // 삭제 버튼 활성화
            $('#delete-btn').prop('disabled', false);
          },
          error: () => alert('차트 데이터 불러오기 실패')
        });
      },
      error: () => alert('성적표 데이터 불러오기 실패')
    });
  });

  // 삭제 버튼 클릭
  $('#delete-submit').on('click', function (e) {
    e.preventDefault();
    const selectedExamTypeId = $('input[name="exam"]:checked').val();

    if (!memberNo || !selectedExamTypeId) {
      alert("시험 분류를 선택해 주세요.");
      return;
    }

    $.ajax({
      url: '/analysis_score/delete',
      type: 'POST',
      data: {
        memberNo: memberNo,
        examTypeId: selectedExamTypeId
      },
      success: function () {
        alert("삭제 완료");
        window.location.href = "/analysis_scorePage/view";
      },
      error: function (xhr) {
        const msg = xhr.responseText || "삭제하지 못했습니다.";
        alert(msg);
      }
    });
  });
});
