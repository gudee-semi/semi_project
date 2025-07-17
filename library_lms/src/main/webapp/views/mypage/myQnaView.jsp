<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>qna</title>
</head>
<body>
<%@ include file="/views/include/header.jsp" %>
<%@ include file="/views/include/sidebar.jsp" %>
<style>
	.container {
    	width: 80vw;
    	padding: 10px;
    }
    .searchBox {
    	
    }
    .listhead {
    	background-color: lightblue;
    }
    .row {
      
    	background-color: ;
     	width: 1100px;
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
    	position: relative;
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
    .new_reply{
    	
    	text-align :center;
    	width : 50px;
    	display: inline-block;
    	position:absolute;
    	right:10px;
    	color : Green;
    }
</style>

	<div class="row listhead">
		<div class="no">No</div>
		<div class="category">분류</div>
		<div class="title">제목</div>
		<div class="writer">작성자</div>
		<div class="regDate">작성일</div>
		<div class="count">조회수</div>
	</div>
	<c:set var="i" value="0"/>
	<c:forEach var="q" items="${qnaList }">
	<div  class="row" onclick="location.href='<c:url value="/qna/detail?no=${q.qnaId }"/>'">
		<c:set var="i" value="${i + 1}" />
		<div class="no">${i}</div>
		<div class="category">${q.category }</div>
		
		<div class="title">${q.title }
		
			<c:forEach var = "r" items= "${qnaReply}">
				<c:if test="${q.qnaId eq r.qnaId and r.replyCheck eq 0}">
		
					<div class ="new_reply ${q.qnaId}">N</div>
				</c:if>
			</c:forEach>
		</div>
		
		<div class="writer">${q.memberName }</div>
		<div class="regDate">${q.regDate }</div>
		<div class="count">${q.viewCount }</div>
	</div>
	
	
	</c:forEach>
	
	<c:if test="${not empty qnaList }">
		<div class="pageButton">
			<c:if test="${paging.prev }">
				<a href="<c:url value='/qna/view?nowPage=${paging.pageBarStart-1}'/>">
					&laquo;
				</a>
			</c:if>		
			<c:forEach var="i" begin="${paging.pageBarStart }" end="${paging.pageBarEnd }">
				<a href="<c:url value='/qna/view?nowPage=${i}'/>">
					${i }
				</a>
			</c:forEach>
			<c:if test="${paging.next }">
				<a href="<c:url value='/qna/view?nowPage=${paging.pageBarEnd+1}'/>">
					&raquo;
				</a>
			</c:if>
		</div>
	</c:if>

</body>
</html>