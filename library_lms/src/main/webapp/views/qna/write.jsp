<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>질의응답 작성 페이지</title>
</head>
<body>
	<h1>질의응답 작성</h1>
	<form id="postQnaFrm">
	
		<select name="qnaCategory" id="qnaCategory">
		  <option value=0>선택하세요</option>
		  <option value=1>시설</option>
		  <option value=2>좌석</option>
		  <option value=3>환불</option>
		  <option value=4>기타</option>
		</select>
		
		<select name="qnaVisibility" id="qnaVisibility">
		  <option value="공개">공개</option>
		  <option value="비공개">비공개</option>
		</select>
		
	    <label>작성자:</label><br>
		<input type="text" name="qnaWriter" required><br>
	    <label>제목:</label><br>
	    <input type="text" name="qnaTitle" required><br><br>
	    
	    <label>내용:</label><br>
	    <textarea name="qnaContent" rows="5" cols="40" required></textarea><br><br>
	    
	    <label>파일첨부:</label><br>
	    <input type="file" name="boardFile" ><br><br>
	    
	    <input type="submit" value="등록">
	</form>
	<script>
		$("#postQnaFrm").submit(function(e){
			e.preventDefault();
			
			const form = document.getElementById("postQnaFrm");
			const formData = new FormData(form);
			// 유효성 검사
			
			$.ajax({
				url : "/qnaPost",
				type : "post",
				data : formData,
				enctype : "multipart/form-data",
				contentType : false,
				processData : false,
				cache : false,
				dataType : "json",
				success : function(data){
					alert(data.res_msg);
					if(data.res_code == 200){
						location.href = "<%=request.getContextPath() %>/boardList";
					}
				}
			})
		});
	</script>
</body>
</html>