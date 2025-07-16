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
            text-align: center;
            margin-top: 40px;
        }
        table {
            width: 90%;
            margin: 30px auto;
            border-collapse: collapse;
        }
        th, td {
            border: 1px solid #ccc;
            padding: 12px;
            text-align: center;
        }
        select {
            padding: 5px;
        }
        .btn-container {
            text-align: center;
            margin: 20px;
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
<script>
<%
List<FixedSeatMemberView> list = (List<FixedSeatMemberView>) request.getAttribute("list");
out.println("리스트 null 여부: " + (list == null));
out.println("리스트 사이즈: " + (list != null ? list.size() : 0));
%>
</script>
<h2>고정좌석 이용 회원</h2>

<form action="${pageContext.request.contextPath}/admin/fixed-seat-update" method="post">
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
    list = (List<FixedSeatMemberView>) request.getAttribute("list");
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
            } // null check end
        }
    }
%>

        </tbody>
    </table>

    <div class="btn-container">
        <button type="submit" class="btn-change">변경하기</button>
    </div>
</form>

</body>
</html>
