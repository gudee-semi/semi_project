<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>태블릿</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>

	<style>
body>div>div.container>div:nth-child(1)>img {
	translate: 0 90px;
}

.flex-container {
	display: flex;
}

.container {
	margin: 0 auto;
	translate: -150px 0;
}

.submit-btn {
	display: block;
	margin: 0 auto;
	width: 100px;
	height: 55px;
	border: none;
	background-color: #D8E5F4;
	border-radius: 6px;
	font-weight: bold;
	font-size: 20px;
	cursor: pointer;
	transition: 0.2s;
	cursor: pointer;
	translate: 0 120px;
}

.submit-btn:hover {
	background-color: #3E7AC8;
}

#useForm-1 {
	font-size: 20px;
	font-weight: bold;
}

#returnForm-1 {
	font-size: 20px;
	font-weight: bold;
}

.useform {
	background-color: #D8E5F4;
	padding: 5px 40px;
	border-radius: 5px;
	display: block;
	font-weight: bold;
	width: 180px;
	margin: 0 auto;
}

.returnform {
	background-color: #D8E5F4;
	padding: 5px 40px;
	border-radius: 5px;
	display: block;
	font-weight: bold;
	width: 210px;
	margin: 0 auto;
}

.side {
	width: 300px;
	height: 1000px;
}

.flex-container {
	display: flex;
	align-items: flex-start;
}
</style>

	<%@ include file="/views/include/header.jsp"%>

	<div class="sidebars"><%@ include file="/views/include/sidebar.jsp"%></div>
	<div class="flex-container">
		<div class="side"></div>
		<div class="container">
			<div style="text-align: center;">
				<img src="https://dbdzm869oupei.cloudfront.net/img/sticker/preview/6302.png" alt="태블릿" />
			</div>

			<div style="text-align: center; transform: translate(0, -340px);">
				<!-- 사용가능 대수 계산 -->
				<c:set var="usable" value="0" />

				<c:forEach var="t" items="${tabletList}">

					<c:if test="${t.tabletAvailable == 0}">
						<c:set var="usable" value="${usable + 1}" />
					</c:if>

				</c:forEach>


				<%-- 1. 가장 앞에서 버튼이 출력됐는지 체크하는 플래그(초기값 false) --%>
				<c:set var="btn" value="false" />

				<%-- 2. 태블릿 리스트 반복 --%>
				<c:forEach var="t" items="${tabletList}" varStatus="loop">
					<%-- 3. 아직 버튼이 한 번도 출력되지 않았다면 --%>
					<c:if test="${not btn}">

						<%-- 3-1. 내가 사용중인 태블릿이면 "사용중" 버튼 --%>
						<c:if test="${usingList[loop.index]}">
							<%-- "반납하기" 버튼: 활성화 상태! --%>
							<form id="returnForm-${t.tabletId}" action="${pageContext.request.contextPath}/tablet/return" method="post" style="display: inline;" onsubmit="return confirmReturn(${t.tabletId});">
								<input type="hidden" name="tabletId" value="${t.tabletId}" />
								<div class="returnform">
									<p>태블릿을 사용중입니다</p>
									<p>사무실에서 수령해주세요</p>
								</div>
								<button type="submit" class="submit-btn">반납하기</button>
							</form>


							<c:set var="btn" value="true" />
						</c:if>

						<%-- 3-2. 내가 사용중이 아니고, 사용 가능한 태블릿(available==0)이면 "사용하기" 버튼 --%>
						<c:if test="${not usingList[loop.index] and t.tabletAvailable == 0}">
							<form id="useForm-${t.tabletId}" action="${pageContext.request.contextPath}/tablet/use" method="post" style="display: inline;" onsubmit="return confirmUse(${t.tabletId});">
								<input type="hidden" name="tabletId" value="${t.tabletId}" />
								<div class="useform">
									<p>사용 가능 대수</p>
									<p>${usable}대</p>
								</div>
								<button type="submit" class="submit-btn">사용하기</button>
							</form>


							<c:set var="btn" value="true" />
						</c:if>

						<%-- 3-3. 둘 다 아니면 아무것도 출력하지 않음(넘어감) --%>
					</c:if>
				</c:forEach>


				<%-- 4. 반복문 끝나고도 btnPrinted가 false면(즉, 모든 태블릿이 사용중) "사용불가" 버튼 한 번만 --%>
				<c:if test="${not btn}">
					<button type="button" disabled>사용불가</button>
				</c:if>

			</div>

		</div>

	</div>



	<%@ include file="/views/include/footer.jsp"%>

	<script>
  // SweetAlert2로 "사용하기" 버튼 확인창
  function confirmUse(tabletId) {
    event.preventDefault();
    Swal.fire({
      text: '태블릿을 사용하시겠습니까?',
      icon: 'question',
      showCancelButton: true,
      confirmButtonColor: '#205DAC',
      cancelButtonColor: '#EFEFEF',
      confirmButtonText: '사용',
      cancelButtonText: '취소'
    }).then((result) => {
      if (result.isConfirmed) {
        document.getElementById("useForm-" + tabletId).submit();
      }
    });
    return false;
  }

  // SweetAlert2로 "반납하기" 버튼 확인창
  function confirmReturn(tabletId) {
    event.preventDefault();
    Swal.fire({
      text: '태블릿을 반납하시겠습니까?',
      icon: 'question',
      showCancelButton: true,
      confirmButtonColor: '#205DAC',
      cancelButtonColor: '#EFEFEF',
      confirmButtonText: '반납',
      cancelButtonText: '취소'
    }).then((result) => {
      if (result.isConfirmed) {
        document.getElementById("returnForm-" + tabletId).submit();
      }
    });
    return false;
  }
</script>

</body>
</html>