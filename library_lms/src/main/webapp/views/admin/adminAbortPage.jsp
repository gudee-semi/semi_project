<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>태블릿 사용현황</title>
<script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
<style>
table {
	border-collapse: collapse;
}
th, td {
	border: none;
	border-bottom: 1px solid #CCCCCC;
	padding: 8px 12px;
	text-align: center;
}
th {
	border-bottom: 2px solid #666666;
	background: #FAFAFA;
}
tr:last-child td {
	border-bottom: none;
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
	<jsp:include page="/views/include/header.jsp" />
	<div class="flex-container">
		<div class="sidebars"><jsp:include page="/views/include/sidebar.jsp" /></div>
		<div class="container">
			<h1>강제 퇴실</h1>
			<c:if test="${ empty list }">
				<div>현재 독서실을 이용중인 회원이 없습니다.</div>
			</c:if>
			<c:if test="${ not empty list }">			
				<form id="memberAbortFrm">
					<table style="border-collapse: collapse; width: 100%">
						<thead>
							<tr>
								<th style="width: 10%">사용자 번호</th>
								<th style="width: 40%">사용자</th>
								<th style="width: 40%">상태</th>
								<th style="width: 10%">퇴실 조치</th>
							</tr>
						</thead>			
					    <tbody>
						    <c:forEach var="member" items="${ list }">
						    	<tr>
						    		<td>${ member.memberNo }</td>
						    		<td>${ member.memberName }</td>
						    		<td>${ member.statusDisplay }</td>
						    		<td><input type="checkbox" name="memberId" value="${ member.memberNo }"></td>
						    	</tr>
						    </c:forEach>
					    </tbody>
					</table>
					<input type="submit" value="강제 퇴실">
				</form>
			</c:if>
		</div>
	</div>
	<jsp:include page="/views/include/footer.jsp" />
	
	<script>
		$('#memberAbortFrm').on('submit', (e) => {
			e.preventDefault();
			let arr = [];
			$('input[name="memberId"]:checked').each(function() {
				arr.push($(this).val());
			});
			if (arr.length > 0) {
				$.ajax({
					url: '/admin/abort',
					type: 'post',
					data: { list: arr },
					dataType: 'json',
					success: (data) => {
						if (data.res_code === '200') {
							window.alert(data.res_msg);
							location.href = "<%= request.getContextPath() %>/admin/abort";
						}
					}
				});				
			}
		});
	</script>
</body>
</html>