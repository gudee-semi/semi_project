<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.hy.dto.seat.FixedSeatMemberView" %>

<!DOCTYPE html>
<html>
<head>
    <title>고정좌석 이용 회원</title>
    <style>
        body {
            font-family: "Noto Sans KR", sans-serif;
        }
        .h2 {
        	margin-top: 100px;
            text-align: center;
            transform: translate(-40px,-40px);
        }
        
        table {
            width: 100%;
            margin: 10px auto;
            border-collapse: collapse;
        }
        th, td {
            border: none;
            border-bottom: 1px solid #cccccc;
            padding: 8px 12px;
            text-align: center;
        }
        th{
        	border-top: 2px solid #666666;
	        border-bottom: 2px solid #666666;
			background: #fafafa;
        }
        
        select {
            padding: 5px;
        }
        .btn-container {
        	margin-top: 100px;
        	margin-left: 1200px;
        	margin-bottom: 400px;
            text-align: center;
        }
        .btn-change {
             display: block;
			  margin: 40px auto;
			  padding: 10px 22px;
			  border: none;
			  background-color: #205DAC;
			  color: #fff;
			  border-radius: 6px;
			  font-size: 15px;
			  cursor: pointer;
			  transition: 0.2s;
        }
        .btn-change:hover {
		  	  background-color: #3E7AC8;
		}
		.flex{
			display:flex;
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

.box {
	width: 70%;
}

.logout-text {
	height:24px !important;
}

.profile {
	height: 150.94px !important;
}
    </style>
</head>

<body>
<%@ include file="/views/include/header.jsp" %>
<div class="flex-container">
	<div class="sidebars">
		<%@ include file="/views/include/sidebar.jsp" %>
	</div>
	
	<div class="box">
		<h1 class="h2">고정좌석 이용 회원</h1>
		<!-- ✅ 확인창 띄우는 form -->
		<form id="seatForm" action="${pageContext.request.contextPath}/admin/fixed-seat-update" method="post">
		
		    <table>
		        <thead>
		            <tr>
		                <th>No</th>
		                <th>학년</th>
		                <th>학교</th>
		                <th>이름</th>
		                <th>패널티</th>
		                <th>좌석번호</th>
		            </tr>
		        </thead>
		        <tbody>
		        <%
		            List<FixedSeatMemberView> list = (List<FixedSeatMemberView>) request.getAttribute("list");
		            int index = 1;
		            if (list != null) {
		                for (FixedSeatMemberView m : list) {
		                    if (m != null) {
		        %>
		        <tr>
		            <td><%= index++ %></td>
		            <td><%= m.getMemberGrade() %>학년</td>
		            <td><%= m.getMemberSchool() %></td>
		            <td><%= m.getMemberName() %></td>
		            <td><%= m.getMemberPenalty() %></td>
		            <td>
		                <select name="seat_<%= m.getMemberNo() %>">
		                    <option value="">미지정</option>
		                    <% for (int i = 1; i <= 10; i++) { %>
		                        <option value="<%= i %>" <%= (m.getSeatNo() != null && m.getSeatNo() == i) ? "selected" : "" %>><%= i %></option>
		                    <% } %>
		                </select>
		            </td>
		        </tr>
		        <%
		                    } // null check
		                }
		            }
		        %>
		        </tbody>
		    </table>
		
		    <div class="btn-container">
		        <button type="submit" class="btn-change">변경하기</button>
		    </div>
		</form>
	</div>	
</div>


<!-- ✅ 중복 경고 메시지 alert -->
<%
    List<String> seatUpdateWarnings = (List<String>) session.getAttribute("seatUpdateWarnings");
    if (seatUpdateWarnings != null && !seatUpdateWarnings.isEmpty()) {
        StringBuilder warningMessage = new StringBuilder("중복된 좌석이 있습니다:\\n");
        for (String warning : seatUpdateWarnings) {
            warningMessage.append(warning).append("\\n");
        }
%>
<script>
Swal.fire({
    icon: "error",
    html: `<%= warningMessage.toString().replaceAll("\\\\n", "<br>") %>`,
    confirmButtonColor:'#205DAC',
    footer: "각 회원의 좌석이 겹치지 않도록 다시 선택해주세요."
});
</script>
<%
        session.removeAttribute("seatUpdateWarnings");
    }
%>

<!-- ✅ 좌석 변경 성공 메시지 alert -->
<%
    Boolean seatUpdateSuccess = (Boolean) session.getAttribute("seatUpdateSuccess");
    if (seatUpdateSuccess != null && seatUpdateSuccess) {
%>
<script>
Swal.fire({
	  text: "좌석 변경을 성공했습니다.",
	  icon: "success",
	  draggable: true,
	  confirmButtonColor:'#205DAC'
	});
</script>
<%
        session.removeAttribute("seatUpdateSuccess");
    }
%>
<script>
document.querySelector('.btn-change').addEventListener('click', function (event) {
    event.preventDefault(); // 기본 제출 막기

    Swal.fire({
        text: "변경하시겠습니까?",
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#205DAC',
        confirmButtonText: '변경하기',
        cancelButtonText: '취소'
    }).then((result) => {
        if (result.isConfirmed) {
            document.getElementById('seatForm').submit();
        }
    });
});
</script>
<%@ include file="/views/include/footer.jsp" %>
</body>
</html>
