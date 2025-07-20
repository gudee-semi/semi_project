<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%@ include file="/views/include/header.jsp"%>
	<%@ include file="/views/include/sidebar.jsp"%>

	<div>
		<form method="get" action="<c:url value='/user/delete'/>">
			<input type="text" name="userName" value="${paging.userName }">
			<button type="submit" class="material-symbols-outlined search_btn">search</button>
		</form>
	</div>
	<form action="<c:url value='/user/delete'/>" method="post" id = "delete_user">
		<table class="center" style="border-collapse: collapse; width: 100%">
			<thead>
				<tr>
					<th style="width: 5%">No</th>
					<th style="width: 25%">이름</th>
					<th style="width: 30%">생년월일</th>
					<th style="width: 30%">좌석 종류</th>
					<th style="width: 10%"></th>
				</tr>
			</thead>
	
			<tbody>
				<c:forEach var="q" items="${userList}" varStatus="t">
					<tr>
						<td>${t.count}</td>
						<td>${q.userName }</td>
						<td>${q.userRrn }</td>
						<td>${q.userSeat==1 ? "지정좌석": "공용좌석"}</td>
						<td><input type="checkbox" name="deleteUserNo" value="${q.userNo}"></td>
					</tr>
				</c:forEach>
	
			</tbody>
		</table>
		<button type="submit">삭제하기</button>
	</form>
	<script>
		$("#delete_user").on("submit",function(e){
			e.preventDefault();
			  if ($("input[name='deleteUserNo']:checked").length === 0) {
			      alert("삭제할 항목을 하나 이상 선택하세요.");
			      return;
			    }
			if(confirm("정말 삭제하시겠습니까?")){
				 this.submit();
			}
		})
	</script>

	<c:if test="${not empty userList }">
		<div class="pageButton">
			<c:if test="${paging.prev }">
				<a
					href="<c:url value='/user/delete?nowPage=${paging.pageBarStart-1}&userName=${paging.userName }'/>">
					&laquo; </a>
			</c:if>
			<c:forEach var="i" begin="${paging.pageBarStart }"
				end="${paging.pageBarEnd }">
				<a
					href="<c:url value='/user/delete?nowPage=${i}&userName=${paging.userName }'/>">
					${i } </a>
			</c:forEach>
			<c:if test="${paging.next }">
				<a
					href="<c:url value='/user/delete?nowPage=${paging.pageBarEnd+1}&userName=${paging.userName }'/>">
					&raquo; </a>
			</c:if>
		</div>
	</c:if>
	
<c:if test="${deleteResult > 0}">
	<script>
		alert("성공");
		location.href = "${pageContext.request.contextPath}/user/delete";
	</script>	
</c:if>


	<%@ include file="/views/include/footer.jsp"%>


</body>
</html>