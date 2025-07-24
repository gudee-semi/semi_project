<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>강제퇴실</title>
<script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
<style>
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

/*  하...   */
.sidebars {
	width: 300px;
	height: 1000px;
}

.flex-container {
	display: flex;
	align-items: flex-start;
 	column-gap: 100px;
}

.container {
	width: 70%;
}

header {
	margin: 0 !important;
}

h1 {
	margin-top: 50px;
}

footer {
	margin-top: 0px !important;
}

.nav-item {
	padding: 5px;
}

.flex-input {
	margin-top: 20px;
	display: flex;
	justify-content: flex-end;
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
	transition: .2s;
	font-size: 16px;
}

.btn:hover {
	background-color: #3E7AC8;
}

input[type="checkbox"] {
  accent-color: #205DAC;
}

.selectAllContainer {
	margin-bottom: 20px;
}
</style>
</head>
<body>
	<jsp:include page="/views/include/header.jsp" />
	<div class="flex-container">
		<div class="sidebars"><jsp:include page="/views/include/sidebar.jsp" /></div>
		<div class="container">
			<h1>강제 퇴실</h1>
			<c:if test="${ empty list }">
				<div>현재 독서실을 이용중인 회원이 없습니다.</div>
			</c:if>
			<c:if test="${ not empty list }">
				<div class="selectAllContainer">
					<label for="selectAll">전체 선택</label>
					<input type="checkbox" id="selectAll">			
				</div>
				<form id="memberAbortFrm">
					<table style="border-collapse: collapse; width: 100%">
						<thead>
							<tr>
								<th style="width: 10%">No</th>
								<th style="width: 10%">학년</th>
								<th style="width: 30%">학교</th>
								<th style="width: 20%">이름</th>
								<th style="width: 10%">상태</th>
								<th style="width: 10%">퇴실 조치</th>
								<th style="width: 10%">페널티 부여</th>
							</tr>
						</thead>			
					    <tbody>
						    <c:forEach var="member" items="${ list }" varStatus="status">
						    	<tr>
						    		<td>${ status.index + 1 }</td>
						    		<td>${ member.memberGrade }</td>
						    		<td>${ member.memberSchool }</td>
						    		<td>${ member.memberName }</td>
						    		<td>${ member.statusDisplay }</td>
						    		<td><input type="checkbox" name="memberId" value="${ member.memberNo }"></td>
						    		<td><input type="checkbox" name="memberPenaltyId" value="${ member.memberNo }"></td>
						    	</tr>
						    </c:forEach>
					    </tbody>
					</table>
					<div class="flex-input">
						<input type="submit" value="퇴실 조치" class="btn">
					</div>
				</form>
			</c:if>
		</div>
	</div>
	<jsp:include page="/views/include/footer.jsp" />
	
	<script>
		$('#memberAbortFrm').on('submit', (e) => {
			e.preventDefault();
			let arr = [];
			let arrPen = [];
			$('input[name="memberId"]:checked').each(function() {
				arr.push($(this).val());
			});
			$('input[name="memberPenaltyId"]:checked').each(function() {
				arrPen.push($(this).val());
			});
			for (const itemPen of arrPen) {
				let counter = 0;
				for (const item of arr) {
					if (itemPen !== item) {
						counter++;
					}
				}
				if (counter === arr.length) {
					Swal.fire({
						  icon: "error",
					      text: '퇴실 처리가 안된 회원은 페널티를 부여할 수 없습니다.',
					      confirmButtonText: '확인',
			              confirmButtonColor: '#205DAC'
						}).then(() => {
							return;
						})
				}
			}
			if (arr.length > 0) {
				Swal.fire({
				  icon: "warning",
			      title: ' ',
			      text: '퇴실 조치를 하시겠습니까?',
				  showCancelButton: true,
				  confirmButtonText: "퇴실 조치",
				  cancelButtonText: `취소`,
				  confirmButtonColor: '#205DAC'
				}).then((result) => {
					if (result.isConfirmed) {
						$.ajax({
							url: '/admin/abort',
							type: 'post',
							data: { 
								list: arr,
								listPen: arrPen
							},
							dataType: 'json',
							success: (data) => {
								if (data.res_code === '200') {
									Swal.fire({
						              title: " ",
						              text: "퇴실 조치가 완료되었습니다.",
						              icon: "success",
						              confirmButtonText: '확인',
						              confirmButtonColor: '#205DAC'
						            }).then(() => {
										location.href = "<%= request.getContextPath() %>/admin/abort";						            	
						            })
								}
							}
						});
					}
				});			
			}
		});
	</script>
	<script>
		let chkList = $('input[name="memberId"]');
		$("#selectAll").click(function() {
			if ($(this).is(":checked")){
				chkList.prop("checked", true);
			} else
				chkList.prop("checked", false);
			});
	</script>
</body>
</html>