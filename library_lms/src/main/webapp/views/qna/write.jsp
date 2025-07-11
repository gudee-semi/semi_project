<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>질의응답 작성 페이지</title>
<script src="<c:url value='/resources/jquery-3.7.1.js'/>"></script>
<style>
	textarea {
      resize: none;
    }
    .menu-name {
    	width: 60px;
    }
</style>
</head>
<body>
<!-- include 넣기 -->
	<h1>질의응답 작성</h1>
		<form id="writeQnaFrm">
			<div class="menu-name">카테고리</div>
				<select name="qnaCategory" id="qnaCategory">
				  <option value=0>--선택--</option>
				  <option value=1>시설</option>
				  <option value=2>좌석</option>
				  <option value=3>환불</option>
				  <option value=4>기타</option>
				</select>
			
			<div class="menu-name">공개여부</div>
				<select name="qnaVisibility" id="qnaVisibility">
				  <option value=1>공개</option>
				  <option value=0>비공개</option>
				</select>
			
			<input type="hidden" name="qnaWriter" required><br>
			
			    <div class="menu-name">제목</div>	
			    <div><textarea name="qnaTitle" rows="1" cols="80" required></textarea></div>
		    
			    <div class="menu-name">파일첨부</div>
			    <div><input type="file" name="qnaFile" ></div>
		    
		    	<div class="menu-name">내용</div>
		    	<div><textarea name="qnaContent" rows="15" cols="80" required></textarea></div>
		    
		    <br>
		    <input type="submit" value="등록">
		</form>
	<script>
		$("#writeQnaFrm").submit(function(e){
			e.preventDefault();
			
			const form = document.getElementById("writeQnaFrm");
			const formData = new FormData(form);
			// 유효성 검사
			
			$.ajax({
				url : "/qnaWrite",
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
						location.href = "<%=request.getContextPath() %>/qna/view";
					}
				}
			})
		});
	</script>
</body>
</html>
