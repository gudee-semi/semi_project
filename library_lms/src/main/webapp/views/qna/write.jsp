<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>질의응답 작성 페이지</title>
<%-- <script src="<c:url value='/resources/jquery-3.7.1.js'/>"></script> --%>
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
<!-- include 넣기 -->
	<%@ include file="/views/include/header.jsp" %>
	<div class="container">
	<h1>질의응답 작성</h1>
		<form id="writeQnaFrm">
		<table class="detail-table">
			<tr>
				<th style="width: 10%">카테고리</th>
					<td style="width: 40%">
						<select name="qnaCategory" id="qnaCategory">
						  <option value=0>--선택--</option>
						  <option value='시설'>시설</option>
						  <option value='좌석'>좌석</option>
						  <option value='환불'>환불</option>
						  <option value='기타'>기타</option>
						</select>
					</td>
				
				<th style="width: 10%">공개여부</th>
				<td style="width: 40%">
					<select name="qnaVisibility" id="qnaVisibility">
					  <option value=1>공개</option>
					  <option value=0>비공개</option>
					</select>
				</td>
			</tr>
			
			<tr>
			    <th>제목</th>	
			    <td colspan="3"><textarea class="input flexible" name="qnaTitle" rows="1" cols="100" required></textarea></td>
		    </tr>
		    <tr>
		    	<th>내용</th>
		    	<td colspan="3"><textarea class="input flexible" name="qnaContent" rows="16" cols="100" required></textarea></td>
		    </tr>
		    <tr>
			    <th>파일첨부</th>
			    <td colspan="3"><input type="file" name="qnaFile" ></td>
		    </tr>
		    <br>
		</table>
		
		    <input class="btn.blue" type="submit" value="등록">
		</form>
		
		<form action="/qna/view" method="get">
			<button class="btn.blue">목록</button>
		</form>
		</div>
	
	<script>
		$("#writeQnaFrm").submit(function(e){
			e.preventDefault();
			console.log("1: 동작");
			const category = $("#qnaCategory").val();
			const form = document.getElementById("writeQnaFrm");
			const formData = new FormData(form);
			// 유효성 검사
			console.log("2: 동작");
			if (category == 0) {
				alert("카테고리를 선택하세요.");
			}
			console.log("3: 동작");
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
					alert(data.res_msg);
					if(data.res_code == 200){
						location.href = "<%=request.getContextPath() %>/qna/view";
					}
				},
 				error : function() {
 					alert("요청 실패!");
 				}
			});
		});
	</script>
	<%@ include file="/views/include/footer.jsp" %>
</body>
</html>