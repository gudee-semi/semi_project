<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>

	<!-- JSTL로 반복하며 사용 가능 개수 세기 -->
	<c:set var="usableCount" value="0"/>	
	<c:forEach var="t" items="${tabletList}">
	    <c:if test="${t.tabletAvailable == 1}">
	        <c:set var="usableCount" value="${usableCount + 1}"/>
	    </c:if>
	</c:forEach>
	<p>사용 가능 대수</p>
	<p>${usableCount}대</p>
	
	<!-- 버튼에 클래스, 태블릿 ID 등 부여 -->
	<c:forEach var="t" items="${tabletList}">
		<tr>
			<td>${t.tabletId}</td>
			<td><span class="tablet-status" id="status-${t.tabletId}">
					<c:choose>
						<c:when test="${t.tabletAvailable == 0}">
    					사용 가능<br>
  						</c:when>
						<c:otherwise>
    					사용 중<br>
  					</c:otherwise>
					</c:choose>
			</span></td>
		</tr>
	</c:forEach>

<!-- 	<script>
	$(function() {
		$(".use-btn").click(function() {
			var tabletId = $(this).data("id");
			$.ajax({
				url: "tablet/use",
				type: "POST",
				data: {tabletId: tabletId},
				success: fuction(result) {
					// 성공시 상태 텍스트 변경
					$("#status-"+tabletId).text("사용중");
					// 버튼 숨기기
					$("use-btn[data-id='"+ tabletId + "']").hide();
				},
				error : function() {
					alert("오류가 발생했습니다");
				}
			});
		});
	});
	</script> -->
	
	<script>
	$(function() {
		$(".use-btn").click(function() {
			var tabletId = $(this).data("id");
			$.ajax({
				url: "tablet/use",
				type: "POST",
				data: {tabletId : tabletId},
				success: 
			})
		})
	})
	</script>





</body>		
</html>