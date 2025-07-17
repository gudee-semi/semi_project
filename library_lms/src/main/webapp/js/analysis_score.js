$(document).ready(function () {
  // [1] 삭제 결과에 따라 모달(알림) 노출 (URL 파라미터 검사)
  const params = new URLSearchParams(window.location.search);
  const deleteResult = params.get("delete");
  const msg = params.get("msg") ? decodeURIComponent(params.get("msg")) : "";

  if (deleteResult === "success") {
    alert("삭제 완료");
    window.location.href = "/analysis_scorePage/view";
    return;
  } else if (deleteResult === "fail") {
    alert(msg || "삭제하지 못했습니다");
    // 실패 시는 현재 페이지에 머무름 (추가 행동 가능)
  }
  
  // [2] 세션에서 값 가져오기
    const memberNo = parseInt($('#memberNo').val());
    const studentGrade = parseInt($('#studentGrade').val());

    // [3] 시험 체크박스 객체
    const examCheckboxes = $('input[name="exam"]');

    // [A] DB에 입력된 시험만 체크박스 활성화
    $.ajax({
      url: '/analysis_score/select',
      method: 'GET',
      data: { memberNo: memberNo },
      success: function (data) {
        // data: DB에 입력된 exam_type_id 배열
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
	

	// [B] 시험 체크박스 선택 이벤트: 하나만 선택, 선택 시 성적 조회
	examCheckboxes.change(function () {
	  // 나머지 체크박스 체크 해제
	  examCheckboxes.not(this).prop('checked', false);

	  if (!$(this).is(':checked')) {
	    // 체크 해제 시 테이블 숨기기 및 초기화
	    $('#score-table').hide();
	    $('#exam-title').empty();
	    $('#selected-subjects').empty();
	    $('#score-body').empty();
	    $('#delete-btn').prop('disabled', true);
	    return;
	  }
	  
	  const examTypeId = parseInt($(this).val());
	  
	  // 선택된 시험의 성적 조회 AJAX
	  $.ajax({
		url: '/analysis_score/select',
		method: 'GET',
		data:{
			memberNo: memberNo,
			examTypeId: examTypeId
		},
		success: function (res) {
			$('#exam-title').html(res);
			//여기서 테이블, 점수 등 필요한 화면 렌더링 추가
			// 삭제 버튼 활성화
			$('#delete-btn').prop('disabled', false);
		},
		error: function () {
			alert('성적 데이터를 불러오는데 실패했습니다.');
		}
	  });
	 });
	 
	 
	 // 삭제 버튼 클릭 시 AJAX로 삭제 요청 보내기
	 $('#delete-submit').on('click', (e) => {
		e.preventDefault();
		// 항상 최신 선택값을 읽음
		const selectedExamTypeId = $('input[name="exam"]:checked').val();
		
		if (!memberNo || !selectedExamTypeId) {
			alert("시험 분류를 선택해 주세요.");
			return;
		}
		
		$.ajax({
			url: '/analysis_score/delete',
			type: 'post',
			data: {
				memberNo: memberNo,
				examTypeId: selectedExamTypeId
			},
			success: function (res) {
				//서버에서 바로 redirect 해도 되지만, 여기서는 JS에서 안내 후 페이지 이동
				alert("삭제 완료");
				window.location.href = "/analysis_scorePage/view";
			},
			error: function (xhr, status, error) {
				let msg = "삭제하지 못했습니다.";
				if (xhr.responseText) msg = xhr.responseText;
				alert(msg);
			}	
		});
	 });
 });  
	  