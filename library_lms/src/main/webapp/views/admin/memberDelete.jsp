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
	margin-top:20px;
	position:relative;
	left:980px;
	background-color:#dc2626;
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
		<div class="sidebars"><%@ include file="/views/include/sidebar.jsp"%></div>
			<div class="container">
			<h1>회원 계정 목록</h1>
			<div class="search-row">
				<form method="get" action="<c:url value='/admin/member/delete'/>">
					<input type="text" name="memberName" value="${paging.memberName }">
					<button type="submit" class="material-symbols-outlined search_btn btn">search</button>
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
							<th style="width: 10%">좌석 지정 여부</th>
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
				<button type="submit" class="btn btn_delete">삭제하기</button>
			</form>
			<script>
			$(document).ready(function() {
				  $("#delete_member").on("submit", function(e) {
				    e.preventDefault();

				    const selectedMembers = $("input[name='deleteMemberNo']:checked").map(function() {
				      return $(this).val();
				    }).get();

				    if (selectedMembers.length === 0) {
				      Swal.fire({
				        text: "삭제할 항목을 하나 이상 선택하세요.",
				        icon: "warning",
				        confirmButtonColor: '#205DAC'
				      });
				      return;
				    }

				    Swal.fire({
				      title: "계정 삭제",
				      text: "정말로 계정을 삭제하시겠습니까?",
				      icon: "warning",
				      showCancelButton: true,
				      confirmButtonColor: "#205DAC",
				      cancelButtonColor: "#d33",
				      confirmButtonText: "삭제",
				      cancelButtonText: "취소"
				    }).then((result) => {
				      if (result.isConfirmed) {
				        $.ajax({
				          url: $(this).attr("action"),
				          type: "POST",
				          traditional: true,
				          data: { deleteMemberNo: selectedMembers },
				          dataType: "json",
				          success: function(response) {
				            if (response.deleteResult > 0) {
				              Swal.fire({
				                title: "삭제 성공",
				                text: "회원 계정이 삭제되었습니다.",
				                icon: "success",
				                confirmButtonColor: '#205DAC'
				              }).then(() => {
				                location.href = "<%=request.getContextPath()%>/admin/member/delete";
				              });
				            } else {
				              Swal.fire({
				                title: "삭제 실패",
				                text: "서버 오류입니다.",
				                icon: "warning",
				                confirmButtonColor: '#205DAC'
				              });
				            }
				          },
				          error: function() {
				            Swal.fire({
				              title: "요청 실패",
				              text: "서버와 통신할 수 없습니다.",
				              icon: "error",
				              confirmButtonColor: '#205DAC'
				            });
				          }
				        });
				      }
				    });
				  });
				});
			</script>

			<c:if test="${not empty memberList }">
				<div class="table-bottom">
				
					<div class="paging-pages">
						<c:choose>
							<c:when test="${ paging.prev }">
								<a href="<c:url value='/admin/member/delete?nowPage=${paging.pageBarStart-1}&memberName=${paging.memberName }'/>">
									<span class="material-symbols-outlined">chevron_left</span>
								</a>
							</c:when>
							<c:otherwise>
								<a href="<c:url value='/admin/member/delete?nowPage=${paging.pageBarStart-1}&memberName=${paging.memberName }'/>" class="disabled">
									<span class="material-symbols-outlined">chevron_left</span>
								</a>
							</c:otherwise>
						</c:choose>	
						
						<c:forEach var="i" begin="${paging.pageBarStart }" end="${paging.pageBarEnd }">
							<c:choose>
								<c:when test="${ i eq paging.nowPage }">
									<a href="<c:url value='/admin/member/delete?nowPage=${i}&memberName=${paging.memberName }'/>" class="current-page">
										${i}
									</a>
								</c:when>
								<c:otherwise>
									<a href="<c:url value='/admin/member/delete?nowPage=${i}&memberName=${paging.memberName }'/>">
										${i}
									</a>
								</c:otherwise>
							</c:choose>
						</c:forEach>
						
						<c:choose>
							<c:when test="${ paging.next }">
								<a href="<c:url value='/admin/member/delete?nowPage=${paging.pageBarEnd+1}&memberName=${paging.memberName }'/>">
									<span class="material-symbols-outlined">chevron_right</span>
								</a>
							</c:when>
							<c:otherwise>
								<a href="<c:url value='/admin/member/delete?nowPage=${paging.pageBarEnd+1}&memberName=${paging.memberName }'/>" class="disabled">
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
			Swal.fire({
				  title: "삭제성공",
				  text: "회원 계정이 삭제 되었습니다.",
				  icon: "success",
				  confirmButtonColor: '#205DAC'
				}).then(() => {
					location.href ="<%=request.getContextPath()%>/admin/member/delete";
				});
		</script>	
	</c:if>
	<%@ include file="/views/include/footer.jsp"%>

</body>
</html>