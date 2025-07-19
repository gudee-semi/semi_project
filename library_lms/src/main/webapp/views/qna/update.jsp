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
	<h1>질의응답 수정</h1>
		<form id="updateQnaFrm">
		<table class="detail-table">
			<input type="hidden" name="no" value="${ qna.qnaId }">
			<tr>
			<th style="width: 10%">No</th>
			<td style="width: 40%">${qna.qnaId }</td>
	    
			<th style="width: 10%">작성자</th>
			<td style="width: 40%">${qna.memberName }</td>
	    	
	    	</tr>
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
			
			<script>
				$("#qnaCategory").val("${qna.category}").attr("selected","selected");	
				$("#qnaVisibility").val("${qna.visibility}").attr("selected","selected");	
			</script>
			
			<tr>
			    <th>제목</th>	
			    <td colspan="3"><textarea class="input flexible" name="qnaTitle" rows="1" cols="80" required>${ qna.title }</textarea></td>
		    </tr>
	    	
			<tr>
		    	<th name="qnaContent" id="qnaContent">내용</th>
		    	<td colspan="3"><textarea class="input flexible" name="qnaContent" rows="16" cols="80" required>${ qna.content }</textarea></td>
		    </tr>
	    
			<tr>
				<th>파일 첨부</th>
			    <td colspan="3">
			    <c:if test="${ not empty attach }">
			    	<div class="file-now" >
					    <a href="<c:url value='/fileDownload?id=${ qna.qnaId }' />">${ attach.oriName }</a>
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
				</td>
		    </tr>
		    
		</table>
		
			<input type="hidden" name="check" value="0" class="check">
			<input type="hidden" name="id" value="${ qna.qnaId }">
		    <input type="submit" value="수정완료">
		</form>
		
		<form action="/qna/view" method="get">
			<button class="btn">목록</button>
		</form>
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
</body>
</html>