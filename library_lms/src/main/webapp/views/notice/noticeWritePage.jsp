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
	width : 70%;
}
h1 {
	margin-left: 20px;
}
select {
	height: 36px;
	padding: 5px 10px;
	font-size: 14px;
	line-height: 1.4;
	border: 1px solid #ccc;
	border-radius: 4px;
	background-color: white;
}
.category {
	width: 100px;
}
text {
	font-size: 15px;
}
textarea {
	resize: none;
	font-size: 15px;
}
.input.flexible {
	width: 100%;
}
input[type="text"],
select,
textarea {
	border: 1px solid #ccc; /* 연한 회색 */
	border-radius: 4px;
	padding: 8px;
	font-size: 14px;
	box-sizing: border-box;
	outline: none; /* 포커스시 기본 파란 외곽선 제거 */
	transition: border-color 0.3s;
}
input[type="text"]:focus,
select:focus,
textarea:focus {
	border: 1px solid #205DAC;  /* 진한 파란색 */
	box-shadow: 0 0 4px rgba(32, 93, 172, 0.3); /* 선택 시 부드러운 그림자 효과 */
}
.detail-table {
	width: 100%;
	border-collapse: collapse;
	margin-bottom: 20px;
	table-layout: fixed;
}
.detail-table th,
.detail-table td {
	border: 1px solid #ddd;
	padding: 10px 12px;
	vertical-align: middle;
	white-space: nowrap; /* 줄바꿈 방지 */
	overflow: hidden;    /* 넘치는 텍스트 숨김 */
	text-overflow: ellipsis; /* ... 처리 */
}
.detail-table th {
	background-color: #F5F5F5;
	width: 120px;
	text-align: center;
	font-weight: normal;
	vertical-align: middle;
}
.content {
	height: 250px;
}
.content-cell {
	vertical-align: top !important;
	white-space: normal !important; /* 줄바꿈 허용 */
}
.btn {
	border: none;
	background-color: #205DAC;
	color: #fff;
	border-radius: 6px;
	cursor: pointer;
	height: 40px;
	width: 90px;
   	margin-right: 10px;
   	transition: .2s;
   	font-size: 16px;
}

.btn:hover {
	background-color: #3E7AC8;
}

/*  하...   */
.sidebars {
	width: 300px;
	height: 1000px;
}

.flex-container {
	display: flex;
	align-items: flex-start;
	column-gap: 100px;
}

.container {
	width: 70%;
}

header {
	margin: 0 !important;
}

h1 {
	margin-top: 50px;
}

footer {
	margin-top: 0px !important;
}

.nav-item {
	padding: 5px;
}
</style>
</head>
<body>
	<%@ include file="/views/include/header.jsp" %>
	<div class="flex-container">
		<div class="sidebars"><%@ include file="/views/include/sidebar.jsp" %></div>
		<div class="container">
			<h1>공지사항</h1>
			
			<form id="writeNoticeFrm">
				<table class="detail-table">
					<tr>
						<th style="width: 15%">카테고리</th>
						<td style="width: 35%">
							<select class="category" name="category" id="category">
						  		<option value=0>선택</option>
							  	<option value='일반공지'>일반공지</option>
							  	<option value='중요공지'>중요공지</option>
							  	<option value='시설공지'>시설공지</option>
							</select>
						</td>
						
						<th style="width: 15%">작성자</th>
						<td style="width: 35%">관리자</td>
					</tr>
					
					<tr>
					    <th>제목</th>	
					    <td colspan="3"><textarea class="input flexible" name="title" rows="1" cols="80" required></textarea></td>
			    	</tr>
			    	
			    	<tr>
				    	<th>내용</th>
				    	<td colspan="3"><textarea class="input flexible" name="content" rows="15" cols="80" required></textarea></td>
			    	</tr>
			    	
			    	<tr>
						<th>파일첨부</th>
						<td colspan="3"><input type="file" name="file"></td>
				    </tr>
				</table>
				    
			    <div style="display: flex; justify-content: flex-end; margin-top: 10px;">
				<button type="button" class="btn" id="noticeList">목록</button>
				</div>
			
				<div style="display: flex; justify-content: center; margin-top: 20px;">
				    <button type="submit" class="btn">등록</button>
				</div>
			</form>	
		</div>
	</div>
	
	<script>
		$("#noticeList").click(function() {
		    window.location.href = "/notice/list";
		});
	
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
					if (data.res_code == 200) {
						Swal.fire({
			              title: " ",
			              text: "공지사항이 작성되었습니다.",
			              icon: "success",
			              confirmButtonText: '확인',
			              confirmButtonColor: '#205DAC'
			            }).then(() => {
							location.href = "<%= request.getContextPath() %>/notice/list";			            	
			            });
					} else {
						Swal.fire({
			              title: " ",
			              text: "공지사항 작성에 실패했습니다.",
			              icon: "error",
			              confirmButtonText: '확인',
			              confirmButtonColor: '#205DAC'
			            }).then(() => {	            	
							location.href = "<%= request.getContextPath() %>/notice/list";
			            });
					}
				}
			});
		});
	</script>
	<%@ include file="/views/include/footer.jsp" %>
</body>
</html>