$(document).ready(function () {
  const examCheckboxes = $('input[name="exam"]');
  const memberNo = parseInt(document.getElementById('memberNo').value);
  const studentGrade = parseInt(document.getElementById('studentGrade').value);

  // [1] 체크박스 활성화 여부 결정
  $.ajax({
    url: '/goal_score_view/select',
    method: 'GET',
    data: { memberNo: memberNo },
    success: function (data) {
      examCheckboxes.each(function () {
        const examValue = parseInt($(this).val());
        $(this).prop('disabled', !data.includes(examValue));
      });
    },
    error: function () {
      alert("서버 오류: 시험 목록을 불러올 수 없습니다.");
    }
  });

  // [2] 시험 선택 시 성적 데이터 로드
  examCheckboxes.change(function () {
    examCheckboxes.not(this).prop('checked', false);
    const examTypeId = $(this).val();

    if (!$(this).is(':checked')) {
      $('#exam-title, #selected-subjects').empty();
      $('#score-body').empty();
      $('#score-table').hide();
      return;
    }

    $.ajax({
      url: '/goal_score_view/select',
      method: 'GET',
      data: {
        memberNo: memberNo,
        examTypeId: examTypeId
      },
      success: function (res) {
        if (res.length === 0) {
          $('#exam-title').text('');
          $('#selected-subjects').text('해당 시험에 입력된 성적이 없습니다.');
          $('#score-table').hide();
          return;
        }

        const examText = '2025년도 ' + examTypeId + '월 모의고사';
        $('#exam-title').text(examText);

        const subjects = res.map(item => item.subjectName).join(' | ');
        $('#selected-subjects').text(subjects);

        const html = res.map(item =>
          `<tr>
            <td>${item.subjectName}</td>
            <td>${item.targetScore != null ? item.targetScore : '-'}</td>
            <td>${item.targetLevel != null ? item.targetLevel : '-'}</td>
          </tr>`
        ).join('');

        $('#score-body').html(html);
        $('#score-table').show();
      },
      error: function () {
        alert("서버 오류: 성적을 불러올 수 없습니다.");
      }
    });
  });
});
