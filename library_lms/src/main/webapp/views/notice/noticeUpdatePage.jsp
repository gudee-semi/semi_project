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
.detail-table {
	width: 100%;
	border-collapse: collapse;
	margin-bottom: 20px;
	table-layout: fixed;
}
.detail-table th,
.detail-table td {
	border: 1px solid #ddd;
	padding: 5px 10px;
	vertical-align: middle;
	white-space: nowrap; /* 줄바꿈 방지 */
	text-overflow: ellipsis; /* ... 처리 */
}
.detail-table th {
	background-color: #F5F5F5;
	width: 120px;
	text-align: center;
	font-weight: normal;
	vertical-align: middle;
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
input[type="text"],
select,
textarea {
	border: 1px solid #ccc; /* 연한 회색 */
	border-radius: 4px;
	padding: 8px;
	font-size: 14px;
	box-sizing: border-box;
	vertical-align: middle;
	outline: none; /* 포커스시 기본 파란 외곽선 제거 */
	transition: border-color 0.3s;
}
input[type="text"]:focus,
select:focus,
textarea:focus {
	border: 1px solid #205DAC;  /* 진한 파란색 */
	box-shadow: 0 0 4px rgba(32, 93, 172, 0.3); /* 선택 시 부드러운 그림자 효과 */
}
.file-change {
	background-color: transparent;
	border: none;
	color: #888;
	font-size: 15px;
	cursor: pointer;
	margin-left: 8px;
	transition: color 0.2s ease;
}

.file-change:hover {
	color: #d9534f; /* 빨간색 계열 hover 효과 */
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

.btn:hover {
	background-color: #3E7AC8;
}
</style>

</head>
<body>
	<%@ include file="/views/include/header.jsp" %>
	<div class="flex-container">
		<div class="sidebars"><%@ include file="/views/include/sidebar.jsp" %></div>
		<div class="container">
			<h1>공지사항 수정</h1>
			<div style="display: flex; justify-content: center; margin-top: 20px;">
				<form id="updateNoticeFrm">
					<table class="detail-table">
						<tr>
							<th style="width: 15%; height: 36px;">No</th>
							<td style="width: 35%">${notice.noticeId }</td>
					    
							<th style="width: 15%">작성자</th>
							<td style="width: 35%">관리자</td>
				    	</tr>
				    	
				    	<tr>
							<th>카테고리</th>
							<td colspan="3">
								<select name="category" id="category" required oninvalid="setCustomMessage(this, '카테고리를 선택해주세요.')" oninput="setCustomMessage(this, '')">
							  		<option value=''>선택</option>
								  	<option value='일반공지'>일반공지</option>
								  	<option value='중요공지'>중요공지</option>
								  	<option value='시설공지'>시설공지</option>
								</select>
							</td>
							
						<script>
							$("#category").val("${notice.category}").attr("selected","selected");	
						</script>
						
						<tr>
							<th>제목</th>	
							<td colspan="3"><textarea class="input flexible" name="title" rows="1" cols="100" required oninvalid="setCustomMessage(this, '제목은 필수항목입니다.')" oninput="setCustomMessage(this, '')">${ notice.title }</textarea></td>
					    </tr>
				    	
				    	<tr>
					    	<th>내용</th>	
					    	<td colspan="3"><textarea class="input flexible" name="content" rows="16" cols="100" required oninvalid="setCustomMessage(this, '내용은 필수항목입니다.')" oninput="setCustomMessage(this, '')">${ notice.content }</textarea></td>
					    </tr>
					    
					    <tr>
							<th style="height: 36px;">첨부 파일</th>
						    <td colspan="3">
						    	<div class="file-wrapper">
							   	    <c:if test="${ not empty attach }">
								    	<div class="file-now">
										    <a href="<c:url value='/notice/fileDownload?id=${ notice.noticeId }' />">${ attach.oriName }</a>
										    <button class="file-change" type="button">X</button><br>
								    	</div>
								    	<div class="file-reupload show">
								    		<div><input type="file" name="file" accept=".jpg, .png"></div>
								    	</div>
									</c:if>
									<c:if test="${ empty attach }">
										<input type="hidden" name="check" value="2" class="check">
								    	<div class="file-reupload">
								    		<div><input type="file" name="file" accept=".jpg, .png"></div>
								    	</div>
									</c:if>
							    </div>
							</td>	    
						</tr>
					</table>
					
					<div style="display: flex; justify-content: flex-end; margin-top: 10px;">
						<button type="button" class="btn" onclick="location.href='/notice/list'">목록</button>
					</div>
					
					<div style="display: flex; justify-content: center; margin-top: 20px;">
						<input type="hidden" name="check" value="0" class="check">
						<input type="hidden" name="id" value="${ notice.noticeId }">
					    <button type="submit" class="btn">수정완료</button>
					</div>
				</form>	
			</div>
		</div>
	</div>
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
					if (data.res_code == 200) {
						Swal.fire({
			              text: "성공적으로 수정되었습니다.",
			              icon: "success",
			              confirmButtonText: '확인',
			              confirmButtonColor: '#205DAC'
			            }).then(() => {
							location.href = "<%= request.getContextPath() %>/notice/list";			            	
			            });
					} else {						
						Swal.fire({
			              text: "공지사항 수정에 실패했습니다.",
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
	<script>
		function setCustomMessage(input, message) {
		  input.setCustomValidity(message);
		}
	</script>
	<%@ include file="/views/include/footer.jsp" %>
</body>
</html>