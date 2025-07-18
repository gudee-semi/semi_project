<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>질의응답 수정</title>
<script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>

<style>
	.show {
		display: none;
	}
</style>

</head>
<body>
	<!-- 수정해보기 -->
	<h1>질의응답 수정</h1>
		<form id="updateQnaFrm">
			<input type="hidden" name="no" value="${ qna.qnaId }">
			<p>No ${qna.qnaId }</p>
	    
	    	<p>작성자 ${qna.memberId }</p>
	    	
			<div class="menu-name">카테고리</div>
				<select name="qnaCategory" id="qnaCategory">
				  <option value=0>--선택--</option>
				  <option value='시설'>시설</option>
				  <option value='좌석'>좌석</option>
				  <option value='환불'>환불</option>
				  <option value='기타'>기타</option>
				</select>
			
			<div class="menu-name">공개여부</div>
				<select name="qnaVisibility" id="qnaVisibility">
				  <option value=1>공개</option>
				  <option value=0>비공개</option>
				</select>
			
			<script>
				$("#qnaCategory").val("${qna.category}").attr("selected","selected");	
				$("#qnaVisibility").val("${qna.visibility}").attr("selected","selected");	
			</script>
			
		    <div >제목</div>	
		    <div><textarea name="qnaTitle" rows="1" cols="80" required>${ qna.title }</textarea></div>
	    	
	    	<div name="qnaContent" id="qnaContent">내용</div>
	    	<div><textarea name="qnaContent" rows="15" cols="80" required>${ qna.content }</textarea></div>
	    
	    	<br>
			<div>파일 첨부</div>
		    <br>
		    
		    <c:if test="${ not empty attach }">
		    	<div class="file-now">
				    첨부파일 <a href="<c:url value='/fileDownload?id=${ qna.qnaId }' />">${ attach.oriName }</a>
				    <button class="file-change">X</button><br>
		    	</div>
		    	<div class="file-reupload show">
		    		<div><input type="file" name="qnaFile"></div>
		    	</div>
			</c:if>
			<c:if test="${ empty attach }">
				<input type="hidden" name="check" value="2" class="check">
		    	<div class="file-reupload">
		    		<div><input type="file" name="qnaFile"></div>
		    	</div>
			</c:if>
			<input type="hidden" name="check" value="0" class="check">
			<input type="hidden" name="id" value="${ qna.qnaId }">
		    <input type="submit" value="수정완료">
		</form>
		
		<form action="/qna/view" method="get">
			<button>목록</button>
		</form>
		
		<script>
			$('.file-change').on('click', (e) => {
				e.preventDefault();
				$('.file-reupload').removeClass("show");
				$('.file-now').addClass("show");
				$('.check').val('1');
			})
		
		$('#updateQnaFrm').on('submit', (e) => {
			e.preventDefault();
			const formData = new FormData(document.getElementById('updateQnaFrm'));
			$.ajax({
				url: '/qna/update',
				type: 'post',
				data: formData,
				enctype: 'multipart/form-data',
				contentType: false,
				processData: false,
				cache: false,
				dataType: 'json',
				success: (data) => {	
					window.alert(data.res_msg);
					if (data.res_code == 200) {
						location.href = "<%= request.getContextPath() %>/qna/view";
					} else {						
						location.href = "<%= request.getContextPath() %>/qna/view";
					}
				}
			});
		});
		</script>
</body>
</html>