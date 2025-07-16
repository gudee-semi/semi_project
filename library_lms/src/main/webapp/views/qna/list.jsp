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
    .searchBox {
    	
    }
    .row {
    	border: 0.5px solid black;
    	width: 900px;
    	padding: 10px;
    	margin: 2px;
    }
    .no {
    	text-align: center;
    	width: 40px;
    	display: inline-block;
    }
    .category {
    	text-align: center;
    	width: 110px;
    	display: inline-block;
    }
    .title {
    	text-align: center;
    	width: 400px;
    	display: inline-block;
    }
    .writer {
    	text-align: center;
    	width: 120px;
    	display: inline-block;
    }
    .count {
    	text-align: center;
    	width: 70px;
    	display: inline-block;
    }
    .regDate {
    	text-align: center;
    	width: 130px;
    	display: inline-block;
    .listhead {
    	background-color: lightblue;
    }
    .row {
    	background-color: ;
     	width: 900px;
    	padding: 10px;
    }
    .no {
    	text-align: center;
    	width: 40px;
    	display: inline-block;
    }
    .category {
    	text-align: center;
    	width: 110px;
    	display: inline-block;
    }
    .title {
    	text-align: center;
    	width: 400px;
    	display: inline-block;
    }
    .writer {
    	text-align: center;
    	width: 120px;
    	display: inline-block;
    }
    .count {
    	text-align: center;
    	width: 70px;
    	display: inline-block;
    }
    .regDate {
    	text-align: center;
    	width: 130px;
    	display: inline-block;
    }
    .pageButton a {
    	text-decoration: none;
    }
</style>

</head>
<body>
	<div class="container">
	<h1>질의응답 목록</h1>
	
	<div class="searchBox">
		<form method="get" action="<c:url value='/qna/view'/>">
			<select name="keywordFor">
				<option value="">구분</option>
				<option value="제목">제목</option>
				<option value="작성자">작성자</option>
			<select name="keywordIn" id="keywordIn">
				<option value="구분"${paging.keywordIn == "구분" ? "selected" : "" }>구분</option>
				<option value="제목"${paging.keywordIn == "제목" ? "selected" : "" }>제목</option>
				<option value="작성자"${paging.keywordIn == "작성자" ? "selected" : "" }>작성자</option>
			</select>
			<input type="text" name="keyword" placeholder="검색 기준 선택" value="${paging.keyword }">
			<input type="submit" value="검색">
		</form>
	</div>
	
			<div class="row">
				<div class="no">No</div>
				<div class="category">분류</div>
				<div class="title">제목</div>
				<div class="writer">작성자</div>
				<div class="count">조회수</div>
				<div class="regDate">작성일</div>
			</div>
			<c:forEach var="q" items="${qnaList }">
				<div  class="row" onclick="location.href='<c:url value="/qna/detail?no=${q.qnaId }"/>'">
					<div class="no">${q.qnaId }</div>
					<div class="category">${q.category }</div>
					<div class="title">${q.title }</div>
					<div class="writer">${q.memberId }</div>
					<div class="count">${q.viewCount }</div>
					<div class="regDate">${q.regDate }</div>
				</div>
			</c:forEach>
	<c:if test="${not empty qnaList }">
		<div>
	<!-- <script>
		$("#keywordIn").val("${paging.keywordIn}").attr("selected","selected");	
	</script> -->
	
	<div class="row listhead">
		<div class="no">No</div>
		<div class="category">분류</div>
		<div class="title">제목</div>
		<div class="writer">작성자</div>
		<div class="regDate">작성일</div>
		<div class="count">조회수</div>
	</div>
	
	<c:forEach var="q" items="${qnaList }">
		<c:if test ="${q.memberId eq loginMember.memberId}">
			<div  class="row" onclick="location.href='<c:url value="/qna/detail?no=${q.qnaId }"/>'">
				<div class="no">${q.qnaId }</div>
				<div class="category">${q.category }</div>
				<c:if test="${q.visibility == 1 }">
					<div class="title">${q.title}</div>
				</c:if>
				<c:if test="${q.visibility == 0 }">
					<div class="title">🔒 ${q.title }</div>
				</c:if>
				<div class="writer">${q.memberName }</div>
				<div class="regDate">${q.regDate }</div>
				<div class="count">${q.viewCount }</div>
			</div>
		</c:if>
		
		<c:if test ="${q.memberId ne loginMember.memberId}">
			<c:if test = "${q.visibility == 1}">
				<div  class="row" onclick="location.href='<c:url value="/qna/detail?no=${q.qnaId }"/>'">
					<div class="no">${q.qnaId }</div>
					<div class="category">${q.category }</div>
					<div class="title">${q.title }</div>
					<div class="writer">${q.memberName }</div>
					<div class="regDate">${q.regDate }</div>
					<div class="count">${q.viewCount }</div>
				</div>
			</c:if>
			<c:if test = "${q.visibility == 0}">
				<div  class="row">
					<div class="no">${q.qnaId }</div>
					<div class="category">${q.category }</div>
					<div class="title">🔒비공개된 글입니다.</div>
					<div class="writer">${q.memberName }</div>
					<div class="regDate">${q.regDate }</div>
					<div class="count">${q.viewCount }</div>
				</div>
			</c:if>
		</c:if>
	</c:forEach>
		
	<c:if test="${not empty qnaList }">
		<div class="pageButton">
			<c:if test="${paging.prev }">
				<a href="<c:url value='/qna/view?nowPage=$&keyword=${paging.keyword }'/>">
				<a href="<c:url value='/qna/view?nowPage=${paging.pageBarStart-1}&keyword=${paging.keyword }&keywordIn=${keywordIn }'/>">
					&laquo;
				</a>
			</c:if>		
			<c:forEach var="i" begin="${paging.pageBarStart }" end="${paging.pageBarEnd }">
				<a href="<c:url value='/qna/view?nowPage=${i }&keyword=${paging.keyword }'/>">
				<a href="<c:url value='/qna/view?nowPage=${i}&keyword=${paging.keyword }&keywordIn=${keywordIn }'/>">
					${i }
				</a>
			</c:forEach>
			<c:if test="${paging.next }">
				<a href="<c:url value='/qna/view?nowPage=${paging.pageBarEnd+1}&keyword=${paging.keyword }'/>">
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
