<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>질의응답 작성</title>
<script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
<!-- SweetAlert2 CDN 추가 -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<style>
	.container {
		width : 70%;
		margin-top: 50px;
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
		vertical-align: top;
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
		margin-bottom: 50px;
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
			<h1>질의응답 작성</h1>
			
			<form id="writeQnaFrm">
				<table class="detail-table">
					<tr>
						<th style="width: 15%">카테고리</th>
						<td style="width: 35%">
							<select class="category" name="qnaCategory" id="qnaCategory" required oninvalid="setCustomMessage(this, '카테고리를 선택해주세요.')" oninput="setCustomMessage(this, '')">
							  <option value=''>선택</option>
							  <option value='시설'>시설</option>
							  <option value='좌석'>좌석</option>
							  <option value='환불'>환불</option>
							  <option value='기타'>기타</option>
							</select>
						</td>
						
						<th style="width: 15%">공개여부</th>
						<td style="width: 35%">
							<select name="qnaVisibility" id="qnaVisibility">
							  <option value=1>공개</option>
							  <option value=0>비공개</option>
							</select>
						</td>
					</tr>
					
					<tr>
					    <th>제목</th>	
					    <td colspan="3"><textarea class="input flexible" name="qnaTitle" rows="1" cols="100" required oninvalid="setCustomMessage(this, '제목은 필수항목입니다.')" oninput="setCustomMessage(this, '')"></textarea></td>
				    </tr>
				    
				    <tr>
				    	<th>내용</th>
				    	<td colspan="3"><textarea class="input flexible" name="qnaContent" rows="16" cols="100" required oninvalid="setCustomMessage(this, '내용은 필수항목입니다.')" oninput="setCustomMessage(this, '')"></textarea></td>
				    </tr>
				    
				    <tr>
					    <th>첨부 파일</th>
					    <td colspan="3"><input type="file" name="qnaFile" id="file" accept=".jpg, .png"><br>
					        <span style="font-size: 13px; color: #888;">
					            ※ 첨부 가능 파일: JPG, PNG 형식만 업로드 가능합니다.
					        </span>
					    </td>
				    </tr>
				    
				</table>
				
				<div style="display: flex; justify-content: flex-end; margin-top: 10px;">
					<button type="button" class="btn" id="qnaView">목록</button>
				</div>
			
				<div style="display: flex; justify-content: center; margin-top: 20px;">
				    <button type="submit" class="btn">등록</button>
				</div>
			</form>
		</div>
	</div>
	
	<script>
		$("#qnaView").click(function() {
		    window.location.href = "/qna/view";
		});
		
		$("#writeQnaFrm").submit(function(e){
			e.preventDefault();
			const category = $("#qnaCategory").val();
			const form = document.getElementById("writeQnaFrm");
			const formData = new FormData(form);
			
			$.ajax({
				url : "/qna/write",
				type : "post",
				data : formData,
				enctype : "multipart/form-data",
				contentType : false,
				processData : false,
				cache : false,
				dataType : "json",
				success : function(data){
					if (data.res_code == 200) {
						Swal.fire({
			              text: "게시글이 등록되었습니다.",
			              icon: "success",
			              confirmButtonText: '확인',
			              confirmButtonColor: '#205DAC'
			            }).then(() => {
							location.href = "<%= request.getContextPath() %>/qna/view";			            	
			            });
					} else if (data.res_code == 500) {
						Swal.fire({
			              text: "게시글 등록에 실패했습니다.",
			              icon: "error",
			              confirmButtonText: '확인',
			              confirmButtonColor: '#205DAC'
			            }).then(() => {	            	
							location.href = "<%= request.getContextPath() %>/qna/view";
			            });
					} else {
						Swal.fire({
			              text: "허용되지 않은 확장자입니다.",
			              icon: "error",
			              confirmButtonText: '확인',
			              confirmButtonColor: '#205DAC'
			            }).then(() => {	            	
							location.href = "<%= request.getContextPath() %>/qna/write";
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