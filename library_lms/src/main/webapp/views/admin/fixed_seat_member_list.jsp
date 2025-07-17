<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*, com.hy.dto.seat.FixedSeatMemberView" %>

<html>
<head>
    <title>고정좌석 이용 회원</title>
    <style>
        body {
            font-family: "Noto Sans KR", sans-serif;
        }
        h2 {
        	margin-top: 200px;
            text-align: center;
        }
        table {
            width: 90%;
            margin: 30px auto;
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
        
        tr:last-child td {
			border-bottom: none;
		}
        
        select {
            padding: 5px;
        }
        .btn-container {
        	margin-top: 200px;
        	margin-left: 1200px;
        	margin-bottom: 400px;
            text-align: center;
        }
        .btn-change {
            padding: 10px 20px;
            font-size: 16px;
            background-color: #1d4ed8;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
    </style>
</head>

<body>
<h2>고정좌석 이용 회원</h2>

<!-- ✅ 여기에서 onsubmit으로 확인창 띄우기 -->
<form action="${pageContext.request.contextPath}/admin/fixed-seat-update" method="post"
      onsubmit="return confirm('정말 변경하시겠습니까?');">

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


<%
    List<String> seatUpdateWarnings = (List<String>) session.getAttribute("seatUpdateWarnings");
    if (seatUpdateWarnings != null && !seatUpdateWarnings.isEmpty()) {
        StringBuilder warningMessage = new StringBuilder("중복된 좌석이 있습니다:\\n");
        for (String warning : seatUpdateWarnings) {
            warningMessage.append(warning).append("\\n");
        }
%>
<script>
    alert("<%= warningMessage.toString() %>");
</script>
<%
        session.removeAttribute("seatUpdateWarnings");
    }
%>

</body>
</html>
