<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항</title>
<!-- jquery -->
<script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
</head>
<body>
	<h1>게시글 등록</h1>
	
	<form id="writeNoticeFrm">
		<div class="menu-name">카테고리</div>
		<select name="category" id="category">
	  		<option value=0>--선택--</option>
		  	<option value='일반공지'>일반공지</option>
		  	<option value='중요공지'>중요공지</option>
		  	<option value='시설공지'>시설공지</option>
		</select>
		
	    <div class="menu-name">제목</div>	
	    <div><textarea name="title" rows="1" cols="80" required></textarea></div>
    
	    <div class="menu-name">파일첨부</div>
	    <div><input type="file" name="file"></div>
    
    	<div class="menu-name">내용</div>
    	<div><textarea name="content" rows="15" cols="80" required></textarea></div>
	    
	    <br>
	    <input type="submit" value="등록">
	</form>	
	
	<script>
		$('#writeNoticeFrm').on('submit', (e) => {
			e.preventDefault();
			const formData = new FormData(document.getElementById('writeNoticeFrm'));
			console.log(formData);
			$.ajax({	
				url: '/notice/write',
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