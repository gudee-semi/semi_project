<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 질의응답 목록 페이지</title>

<style>
	.container {
    	width: 80vw;
    	padding: 10px;
    }
    .searchBox {
    	
    }
    .row {
    	background-color: ;
     	width: 900px;
    	padding: 10px;
    	margin: 1px;
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
</style>

</head>
<body>
	<div class="container">
	<h1>질의응답 목록</h1>
	
	<div class="searchBox">
		<form method="get" action="<c:url value='/qna/view'/>">
			<select name="keywordIn" id="keywordIn">
				<option value="">구분</option>
				<option value="제목">제목</option>
				<option value="작성자">작성자</option>
			</select>
			<input type="text" name="keyword" placeholder="검색 기준 선택" value="${paging.keyword }">
			<input type="submit" value="검색">
		</form>
	</div>
	
	<script>
		$("#keywordIn").val("${paging.keywordIn}").attr("selected","selected");	
	</script>
	
	<div class="row">
		<div class="no">No</div>
		<div class="category">분류</div>
		<div class="title">제목</div>
		<div class="reply">답변</div>
		<div class="writer">작성자</div>
		<div class="count">조회수</div>
		<div class="regDate">작성일</div>
	</div>
	
	<c:forEach var="q" items="${qnaList }">
		<div  class="row" onclick="location.href='<c:url value="/qna/detail?no=${q.qnaId }"/>'">
			<div class="no">${q.qnaId }</div>
			<div class="category">${q.category }</div>
			<div class="title">${q.title }</div>
			<div class="answerStatus">${q.answerStatus }</div>
			<div class="writer">관리자</div>
			<div class="count">${q.viewCount }</div>
			<div class="regDate">${q.regDate }</div>
		</div>
	</c:forEach>
		
	<c:if test="${not empty qnaList }">
		<div>
			<c:if test="${paging.prev }">
				<a href="<c:url value='/qna/view?nowPage=${paging.pageBarStart-1}&keyword=${paging.keyword }'/>">
					&laquo;
				</a>
			</c:if>		
			<c:forEach var="i" begin="${paging.pageBarStart }" end="${paging.pageBarEnd }">
				<a href="<c:url value='/qna/view?nowPage=${i}&keyword=${paging.keyword }'/>">
					${i }
				</a>
			</c:forEach>
			<c:if test="${paging.next }">
				<a href="<c:url value='/qna/view?nowPage=${paging.pageBarEnd+1}&keyword=${paging.keyword }'/>">
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
