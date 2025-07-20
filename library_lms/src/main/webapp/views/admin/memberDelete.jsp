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
		<form method="get" action="<c:url value='/admin/member/delete'/>">
			<input type="text" name="memberName" value="${paging.memberName }">
			<button type="submit" class="material-symbols-outlined search_btn">search</button>
		</form>
	</div>
	<form action="<c:url value='/admin/member/delete'/>" method="post" id = "delete_member">
		<table class="center" style="border-collapse: collapse; width: 100%">
			<thead>
				<tr>
					<th style="width: 5%">No</th>
					<th style="width: 10%">학년</th>
					<th style="width: 20%">학교</th>
					<th style="width: 20%">이름</th>
					<th style="width: 5%">패널티</th>
					<th style="width: 5%">좌석 지정 여부</th>
					<th style="width: 5%"></th>
				</tr>
			</thead>
	
			<tbody>
				<c:forEach var="q" items="${memberList}" varStatus="t">
					<tr>
						<td>${t.count}</td>
						<td>${q.memberGrade }</td>
						<td>${q.memberSchool }</td>
						<td>${q.memberName }</td>
						<td>${q.memberPenalty }</td>
						<td>${q.memberSeat==1 ? x: "공용좌석"}</td>
						<td><input type="checkbox" name="deleteMemberNo" value="${q.memberNo}"></td>
					</tr>
				</c:forEach>
	
			</tbody>
		</table>
		<button type="submit">삭제하기</button>
	</form>
	<script>
		$("#delete_member").on("submit",function(e){
			e.preventDefault();
			  if ($("input[name='deleteMemberNo']:checked").length === 0) {
			      alert("삭제할 항목을 하나 이상 선택하세요.");
			      return;
			    }
			if(confirm("정말 삭제하시겠습니까?")){
				 this.submit();
			}
		})
	</script>

	<c:if test="${not empty memberList }">
		<div class="pageButton">
			<c:if test="${paging.prev }">
				<a
					href="<c:url value='/admin/member/delete?nowPage=${paging.pageBarStart-1}&memberName=${paging.memberName }'/>">
					&laquo; </a>
			</c:if>
			<c:forEach var="i" begin="${paging.pageBarStart }"
				end="${paging.pageBarEnd }">
				<a
					href="<c:url value='/admin/member/delete?nowPage=${i}&memberName=${paging.memberName }'/>">
					${i } </a>
			</c:forEach>
			<c:if test="${paging.next }">
				<a
					href="<c:url value='/admin/member/delete?nowPage=${paging.pageBarEnd+1}&memberName=${paging.memberName }'/>">
					&raquo; </a>
			</c:if>
		</div>
	</c:if>
	
<c:if test="${deleteResult > 0}">
	<script>
		alert("성공");
		location.href = "${pageContext.request.contextPath}/admin/member/delete";
	</script>	
</c:if>


	<%@ include file="/views/include/footer.jsp"%>

</body>
</html>