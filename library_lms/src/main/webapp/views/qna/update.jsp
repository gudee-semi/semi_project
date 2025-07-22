<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>질의응답 수정 페이지</title>
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
		margin-bottom: 50px;
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
		width: 75px;
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
		width: 250px;
		height: 1000px;
	}
	
	.flex-container {
		display: flex;
		align-items: flex-start;
 		column-gap: 150px;
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
</style>
	
</head>
<body>
	<%@ include file="/views/include/header.jsp" %>
	<div class="flex-container">
		<div class="sidebars"><jsp:include page="/views/include/sidebar.jsp" /></div>
		<div class="container">
			<h1>질의응답 수정</h1>
			
			<div style="display: flex; justify-content: center; margin-top: 20px;">
				<form id="updateQnaFrm">
					<table class="detail-table">
						<input type="hidden" name="no" value="${ qna.qnaId }">
						<tr>
							<th style="width: 15%; height: 36px;">No</th>
							<td style="width: 35%">${qna.qnaId }</td>
					    
							<th style="width: 15%">작성자</th>
							<td style="width: 35%">${qna.memberName }</td>
				    	</tr>
						<tr>
							<th>카테고리</th>
							<td>
								<select name="qnaCategory" id="qnaCategory">
								  <option value=0>--선택--</option>
								  <option value='시설'>시설</option>
								  <option value='좌석'>좌석</option>
								  <option value='환불'>환불</option>
								  <option value='기타'>기타</option>
								</select>
							</td>
						
							<th>공개여부</th>
							<td>
								<select name="qnaVisibility" id="qnaVisibility">
								  <option value=1>공개</option>
								  <option value=0>비공개</option>
								</select>
							</td>
						</tr>
						
						<script>
							$("#qnaCategory").val("${qna.category}").attr("selected","selected");	
							$("#qnaVisibility").val("${qna.visibility}").attr("selected","selected");	
						</script>
						
						<tr>
						    <th>제목</th>	
						    <td colspan="3"><textarea class="input flexible" name="qnaTitle" rows="1" cols="100" required>${ qna.title }</textarea></td>
					    </tr>
				    	
						<tr>
					    	<th name="qnaContent" id="qnaContent">내용</th>
					    	<td colspan="3"><textarea class="input flexible" name="qnaContent" rows="16" cols="100" required>${ qna.content }</textarea></td>
					    </tr>
				    
						<tr>
							<th style="height: 36px;">파일 첨부</th>
						    <td colspan="3">
						    	<div class="file-wrapper">
								    <c:if test="${ not empty attach }">
								    	<div class="file-now" >
										    <a href="<c:url value='/fileDownload?id=${ qna.qnaId }' />">${ attach.oriName }</a>
										    <button class="file-change" type="button">X</button><br>
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
								</div>
							</td>
					    </tr>
					</table>
					
					<div style="display: flex; justify-content: flex-end; margin-top: 10px;">
						<button type="button" class="btn" onclick="location.href='/qna/view'">목록</button>
					</div>
					
					<div style="display: flex; justify-content: center; margin-top: 20px;">
						<input type="hidden" name="check" value="0" class="check">
						<input type="hidden" name="id" value="${ qna.qnaId }">
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
		
	<%@ include file="/views/include/footer.jsp" %>
</body>
</html>