<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- jquery -->
<script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>

<style>
	.show {
		display: none;
	}
</style>
</head>
<body>
	<h1>게시글 수정</h1>
	
	<form id="updateNoticeFrm">
		<div class="menu-name">카테고리</div>
		<select name="category" id="category">
	  		<option value=0>--선택--</option>
		  	<option value='일반공지'>일반공지</option>
		  	<option value='중요공지'>중요공지</option>
		  	<option value='시설공지'>시설공지</option>
		</select>
		
		<script>
			$("#category").val("${notice.category}").attr("selected","selected");	
		</script>
		
	    <div class="menu-name">제목</div>	
	    <div><textarea name="title" rows="1" cols="80" required>${ notice.title }</textarea></div>
    
    	<div class="menu-name">내용</div>
    	<div><textarea name="content" rows="15" cols="80" required>${ notice.content }</textarea></div>
	    
	    <br>
		<div>파일 첨부</div>
	    <br>
	    
   	    <c:if test="${ not empty attach }">
	    	<div class="file-now">
			    첨부파일 <a href="<c:url value='/notice/fileDownload?id=${ notice.noticeId }' />">${ attach.oriName }</a>
			    <button class="file-change">X</button><br>
	    	</div>
	    	<div class="file-reupload show">
	    		<div><input type="file" name="file"></div>
	    	</div>
		</c:if>
		<c:if test="${ empty attach }">
			<input type="hidden" name="check" value="2" class="check">
	    	<div class="file-reupload">
	    		<div><input type="file" name="file"></div>
	    	</div>
		</c:if>
		<input type="hidden" name="check" value="0" class="check">
		<input type="hidden" name="id" value="${ notice.noticeId }">
	    <input type="submit" value="수정">
	</form>	
	
	<script>
		$('.file-change').on('click', (e) => {
			e.preventDefault();
			$('.file-reupload').removeClass("show");
			$('.file-now').addClass("show");
			$('.check').val('1');
		})
	</script>
	
	<script>
		$('#updateNoticeFrm').on('submit', (e) => {
			e.preventDefault();
			const formData = new FormData(document.getElementById('updateNoticeFrm'));
			$.ajax({	
				url: '/notice/update',
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
						location.href = "<%= request.getContextPath() %>/notice/list";
					} else {						
						location.href = "<%= request.getContextPath() %>/notice/list";
					}
				}
			});
		});
	</script>
	
</body>
</html>