<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>
.container {
	padding-top: 100px;
	width: 70%;
	position: relative;
}
h1 {
	margin: 50px auto 0;
}
.search-row {
	display: flex;
	justify-content: end;
	align-items: center;
	padding-left: 15px;
	margin: 0 auto;
}
.search-row input {
	height: 40px;
	font-size: 14px;
	box-sizing: border-box;
	border: 1px solid #ccc;
	border-radius: 4px 0 0 4px;
	margin-bottom:10px;
}

table {
	width: 100%;
	border-collapse: collapse;
	table-layout: fixed;
	margin-top: 20px;
}
th, td {
	border-bottom: 1px solid #ccc;
	padding: 8px 12px;
	text-align: center;
	white-space: nowrap;
	overflow: hidden;
	text-overflow: ellipsis;
}
th {
	background: #FAFAFA;
}
td.title {
	text-align: left;
}

.center {
	width: 50vw;
	margin: 0 auto;
	text-align: center;
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
	font-size: 16px;
	transition: 0.2s;
}
.btn:hover {
	background-color: #3E7AC8;
}
.btn_delete {
	position:absolute;
	background-color:#dc2626;
	bottom :-10px; 
	right:20px;
	transition: 0.2s;
}
.btn_delete:hover{
	background-color:red;
}

.sidebar {
	width: 250px;
	height: 100vh;
	background-color: #3b82f6;
}
.sidebars {
	width: 300px;
	height: 1000px;
}

.flex-container {
	display: flex;
	align-items: flex-start;
	column-gap: 100px;
}

.table-bottom {
	display: flex;
	flex-direction: column;
	align-items: flex-end;
	margin-top: 20px;
	gap: 10px;
}
.paging-pages {
	display: flex;
	justify-content: center;
	align-self: center;
	gap: 6px;
}
.paging-pages a {
	display: inline-block;
	width: 32px;
	text-align: center;
	margin: 0 5px;
	text-decoration: none;
	color: black;
}
.paging-pages a.current-page {
	color: #205DAC;
	text-decoration: underline;
}

.material-symbols-outlined {
	display: inline-block;
	vertical-align: top;
}

.disabled {
	pointer-events: none;
	opacity: 0.2;
}

header {
	margin: 0 !important;
}
footer {
	margin-top: 100px !important;
}


</style>
<body>
	<%@ include file="/views/include/header.jsp"%>
	<div class="flex-container">
	
		<div class="sidebars"> <%@ include file="/views/include/sidebar.jsp"%></div>
			<div class="container">
				<h1>회원 목록</h1>
				<div class="search-row">
					<form method="get" action="<c:url value='/user/delete'/>">
						<input type="text" name="userName" placeholder="이름 검색" value="${paging.userName }">
						<button type="submit" class="material-symbols-outlined search_btn btn">search</button>
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
					<button type="submit" class="btn btn_delete" >삭제하기</button>
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
				
					<div class="table-bottom">
					
					<div class="paging-pages">
						<c:choose>
							<c:when test="${ paging.prev }">
								<a href="<c:url value='/user/delete?nowPage=${paging.pageBarStart-1}&userName=${paging.userName }'/>">
									<span class="material-symbols-outlined">chevron_left</span>
								</a>
							</c:when>
							<c:otherwise>
								<a href="<c:url value='/user/delete?nowPage=${paging.pageBarStart-1}&userName=${paging.userName }'/>" class="disabled">
									<span class="material-symbols-outlined">chevron_left</span>
								</a>
							</c:otherwise>
						</c:choose>	
						
						<c:forEach var="i" begin="${paging.pageBarStart }" end="${paging.pageBarEnd }">
							<c:choose>
								<c:when test="${ i eq paging.nowPage }">
									<a href="<c:url value='/user/delete?nowPage=${i}&userName=${paging.userName }'/>" class="current-page">
										${i}
									</a>
								</c:when>
								<c:otherwise>
									<a href="<c:url value='/user/delete?nowPage=${i}&userName=${paging.userName }'/>">
										${i}
									</a>
								</c:otherwise>
							</c:choose>
						</c:forEach>
						
						<c:choose>
							<c:when test="${ paging.next }">
								<a href="<c:url value='/user/delete?nowPage=${paging.pageBarEnd+1}&userName=${paging.userName }'/>">
									<span class="material-symbols-outlined">chevron_right</span>
								</a>
							</c:when>
							<c:otherwise>
								<a href="<c:url value='/user/delete?nowPage=${paging.pageBarEnd+1}&userName=${paging.userName }'/>" class="disabled">
									<span class="material-symbols-outlined">chevron_right</span>
								</a>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
			</c:if>
	</div>
</div>
<c:if test="${deleteResult > 0}">
	<script>
		alert("성공");
		location.href = "${pageContext.request.contextPath}/user/delete";
	</script>	
</c:if>


	<%@ include file="/views/include/footer.jsp"%>


</body>
</html>