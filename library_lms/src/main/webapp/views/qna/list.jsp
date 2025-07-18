<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>질의응답 목록 페이지</title>

<style>
	.container {
    	width: 80vw;
    	padding: 10px;
    }
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
	.center {
	width: 50vw;
	margin: 0 auto;
	text-align: center;
	}
</style>

</head>
<body>
	<div class="container">

		<h1>질의응답 목록</h1>
		
		<a href="/tablet/admin">태블릿 관리자 페이지</a>
		
		<div>
			<form method="get" action="<c:url value='/qna/view'/>">
	
				<select name="keywordIn" id="keywordIn">
					<option value="구분"${paging.keywordIn == "구분" ? "selected" : "" }>구분</option>
					<option value="제목"${paging.keywordIn == "제목" ? "selected" : "" }>제목</option>
					<option value="작성자"${paging.keywordIn == "작성자" ? "selected" : "" }>작성자</option>
				</select>
				
				<input type="text" name="keyword" placeholder="검색 기준 선택" value="${paging.keyword }">
				
				<input type="submit" value="검색">
				
			</form>
		</div>
		
		<!-- <script>
			$("#keywordIn").val("${paging.keywordIn}").attr("selected","selected");	
		</script> -->
		
		<table class="center" style="border-collapse: collapse; width: 100%">
			<thead>
				<tr>
					<th style="width: 5%">No</th>
					<th style="width: 20%">분류</th>
					<th style="width: 40%">제목</th>
					<th style="width: 10%">작성자</th>
					<th style="width: 15%">작성일</th>
					<th style="width: 10%">조회수</th>			
				</tr>
			</thead>
			
			<tbody>
				<c:forEach var="q" items="${qnaList }">
					<c:if test ="${q.memberId eq loginMember.memberId}">
						<tr onclick="location.href='<c:url value="/qna/detail?no=${q.qnaId }"/>'">
							<td>${q.qnaId }</td>
							<td>${q.category }</td>
							
							<c:if test="${q.visibility == 1 }">
								<td style="text-align: left">${q.title}</td>
							</c:if>
							
							<c:if test="${q.visibility == 0 }">
								<td style="text-align: left">🔒 ${q.title }</td>
							</c:if>
							
							<td>${q.memberName }</td>
							<td>${q.regDate }</td>
							<td>${q.viewCount }</td>
						</tr>
					</c:if>
					
					<c:if test ="${q.memberId ne loginMember.memberId}">
					
						<c:if test = "${q.visibility == 1}">
							<tr onclick="location.href='<c:url value="/qna/detail?no=${q.qnaId }"/>'">
								<td>${q.qnaId }</td>
								<td>${q.category }</td>
								<td style="text-align: left">${q.title }</td>
								<td>${q.memberName }</td>
								<td>${q.regDate }</td>
								<td>${q.viewCount }</td>
							</tr>
						</c:if>
						
						<c:if test = "${q.visibility == 0}">
							<tr>
								<td>${q.qnaId }</td>
								<td>${q.category }</td>
								<td style="text-align: left">🔒비공개된 글입니다.</td>
								<td>${q.memberName }</td>
								<td>${q.regDate }</td>
								<td>${q.viewCount }</td>
							</tr>
						</c:if>
					</c:if>
				</c:forEach>
				
			</tbody>
		</table>
			
		<c:if test="${not empty qnaList }">
			<div class="pageButton">
				<c:if test="${paging.prev }">
					<a href="<c:url value='/qna/view?nowPage=${paging.pageBarStart-1}&keyword=${paging.keyword }&keywordIn=${keywordIn }'/>">
						&laquo;
					</a>
				</c:if>		
				<c:forEach var="i" begin="${paging.pageBarStart }" end="${paging.pageBarEnd }">
					<a href="<c:url value='/qna/view?nowPage=${i}&keyword=${paging.keyword }&keywordIn=${keywordIn }'/>">
						${i }
					</a>
				</c:forEach>
				<c:if test="${paging.next }">
					<a href="<c:url value='/qna/view?nowPage=${paging.pageBarEnd+1}&keyword=${paging.keyword }&keywordIn=${keywordIn }'/>">
						&raquo;
					</a>
				</c:if>
			</div>
		</c:if>
		<form action="/qna/write" method="get">
			<button>작성</button>
		</form>
	</div>
</body>
</html>
