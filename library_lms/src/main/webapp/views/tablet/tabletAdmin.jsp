<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>태블릿 사용현황</title>

<style>
	table {
		border-collapse: collapse;
		width: 100%;
		max-width: 1000px;
		table-layout: fixed;
	}
	th, td {
		border-bottom: 1px solid #CCCCCC;
		padding: 10px;
		text-align: center;
		white-space: nowrap;
		overflow: hidden;
		text-overflow: ellipsis;
	}
	th {
		border-bottom: 1px solid #CCCCCC;
		background: #FAFAFA;
	}
	th:nth-child(1), td:nth-child(1) {
		width: 20%;
	}
	
	th:nth-child(2), td:nth-child(2) {
		width: 50%;
	}
	
	th:nth-child(3), td:nth-child(3) {
		width: 30%;
	}
	.button-container .btn {
		border: none;
		background-color: #205DAC;
		color: #fff;
		border-radius: 6px;
		cursor: pointer;
		height: 40px;
		width: 90px;
		margin-right: 25px;
		transition: .2s;
		font-size: 16px;
	}
	/* 반납 버튼 우측 정렬 */
	.button-container {
		width: 100%;
		max-width: 1000px;
		display: flex;
		justify-content: flex-end;
		margin-top: 30px;
	}
	
	/*  하...   */
	.sidebars {
		width: 250px;
		height: 1000px;
	}
	
	.flex-container {
		display: flex;
		align-items: flex-start;
		column-gap: 250px;
	}
	
	.container {
		display: flex;
		flex-direction: column;
		align-items: center; /* 중앙 정렬 */
	}
	header {
		margin: 0 !important;
	}
	
	h1 {
		margin-top: 50px;
		margin-bottom: 50px;
		width: 100%;
	}
	
	footer {
		margin-top: 0px !important;
	}
</style>
</style>

</head>
<body>
	<%@ include file="/views/include/header.jsp" %>
	<div class="flex-container">
		<div class="sidebars"><jsp:include page="/views/include/sidebar.jsp" /></div>
		<div class="container">
			<h1>태블릿 사용현황</h1>
			<form action="/admin/tablet" method="post">
				<table style="border-collapse: collapse; width: 100%">
					<thead>
						<tr>
							<th>태블릿 No</th>
							<th>사용자</th>
							<th></th>
						</tr>
					</thead>
					
				    <tbody>
						<tr>
				        <c:forEach var="t" items="${tabletList }">
							<td style="width: 20%">${t.tabletId}</td>
							<c:if test="${t.tabletAvailable eq '1' }">
								<c:forEach var="tm" items="${tabletListm }">
									<c:if test="${t.memberNo eq tm.memberNo }">
										<td style="width: 40%">${tm.memberName}</td>
										<td style="width: 20%"><input type="checkbox" name="penalty" value="${tm.memberNo},${tm.tabletId}"></td>
										</tr>
									</c:if>
								</c:forEach>
							</c:if>
							<c:if test="${t.tabletAvailable eq '0'}">
								<td>-</td>
								<td><input type="checkbox" disabled></td>
								</tr>
							</c:if>
						</c:forEach>
				    </tbody>
				</table>
				
				<!-- 버튼을 테이블 기준 오른쪽 정렬 -->
				<div class="button-container">
					<button class="btn" type="submit">반납하기</button>
				</div>
			</form>
		</div>
	</div>
	<%@ include file="/views/include/footer.jsp" %>
</body>
</html>