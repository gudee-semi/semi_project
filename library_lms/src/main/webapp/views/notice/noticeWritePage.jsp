<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항</title>
<!-- jquery -->
<script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
<style>
	.container {
		width : 80vw;
		margin : 0 auto;	
	}
	.content {
		background-color: #fff;
	}
	textarea {
    	resize: none;
    }
    .input.flexible {
    	width: 100%;
	}
	.detail-table {
		width: 70%;
		border-collapse: collapse;
		margin-bottom: 20px;
		table-layout: fixed;
	}
	.detail-table th,
	.detail-table td {
		border: 1px solid #ddd;
		padding: 10px 12px;
		vertical-align: top;
		word-wrap: break-word;
	}
	.detail-table th {
		background-color: #F5F5F5;
		width: 120px;
		text-align: center;
		font-weight: normal;
		vertical-align: middle;
	}
</style>
</head>
<body>
	
	<div class="container">		
		<h1>게시글 등록</h1>		
		<form id="writeNoticeFrm">
		
			<table>
				<tr>
					<th style="width: 20%">카테고리</th>
					<td style="width: 80%">
						<select name="category" id="category">
					  		<option value=0>--선택--</option>
						  	<option value='일반공지'>일반공지</option>
						  	<option value='중요공지'>중요공지</option>
						  	<option value='시설공지'>시설공지</option>
						</select>						
					</td>
				</tr>
				<tr>
					<th>제목</th>
					<td colspan="3"><textarea class="input flexible" name="title" rows="1" cols="100" required></textarea></td>
				</tr>
				<tr>
					<th>파일첨부</th>
					<td colspan="3"><input type="file" name="file"></td>
				</tr>
				<tr>
					<th>내용</th>
					<td colspan="3"><textarea class="input flexible" name="content" rows="16" cols="100" required></textarea></td>
				</tr>
			</table>
		    
		    <br>
		    <input type="submit" value="등록">
		</form>	
	</div>
	
	
	<script>
		$('#writeNoticeFrm').on('submit', (e) => {
			e.preventDefault();
			const formData = new FormData(document.getElementById('writeNoticeFrm'));
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