<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>질의응답 수정</title>
<script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
	<script>
		// 삭제 전에 사용자에게 확인 메시지를 띄우는 함수
		function confirmUpdate() {
		// confirm 창을 띄우고 결과를 반환
		return confirm("수정하시겠습니까?");
	    }
	</script>
</head>
<body>
	<h1>질의응답 수정</h1>
	
	<form id="updateQnaFrm" action="/qna/update" method="post" onsubmit="return confirmUpdate();">
	    <input type="hidden" name="no" value="${qna.qnaId }">
	    
	    <p>No ${qna.qnaId }</p>
	    카테고리 
	    <select name="qnaCategory" id="qnaCategory">
		  <option value=0>--선택--</option>
		  <option value='시설' ${qna.category == '시설' ? 'selected' : ''}>시설</option>
		  <option value='좌석' ${qna.category == '좌석' ? 'selected' : ''}>좌석</option>
		  <option value='환불' ${qna.category == '환불' ? 'selected' : ''}>환불</option>
		  <option value='기타' ${qna.category == '기타' ? 'selected' : ''}>기타</option>
		</select>
	    제목 <input type="text" name="qnaTitle" id="qnaTitle" value="${qna.title }"><br>
	    공개여부 
	    <select name="qnaVisibility" id="qnaVisibility">
		  <option value=1 ${qna.category == '1' ? 'selected' : ''}>공개</option>
		  <option value=0 ${qna.category == '0' ? 'selected' : ''}>비공개</option>
		</select>
	    
	    <p>작성자 ${qna.memberId }</p>
	    내용 <input type="text" name="qnaContent" id="qnaContent" value="${qna.content }"><br>
	    <p>작성일 : ${qna.regDate }</p>
	    
    	<input type="submit" value="수정완료">
	</form>
</body>
</html>