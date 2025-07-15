<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
<%@ include file="/views/include/header.jsp" %>
<%@ include file="/views/include/sidebar.jsp" %>

<c:if test="${type == 'id'}">
	<form id = "search_id">
		<input type= "text" id= "search_name" name = "search_name">
		<input type= "text" id = "search_phone" name= "search_phone">
		<input type= "submit" value= "아이디 찾기">
	</form>
    <p id="search_name_msg"></p>
</c:if>

<c:if test="${type == 'pw'}">
    <form id = "search_pw">
		<input type= "text" id= "search_id" name = "search_id">
		<input type= "text" id = "search_phone" name= "search_phone">
		<input type= "submit" value= "비밀번호 찾기">
	</form>
    <p id="search_id_msg"></p>
</c:if>
<div id= "result_container"></div>

<script>
	$("#search_id").on("submit",function(e){
		e.preventDefault();
		const memberName = $("#search_name").val();
		const memberPhone = $("#search_phone").val();
		
		if(!memberName||!memberPhone){
			$("#search_name_msg").text("이름 또는 전화번호를 입력하세요").css("color","red");
			
		}else{
			$.ajax({
				url : "/login/search",
				type: "post",
				data : {memberName : memberName,
						memberPhone : memberPhone},
				dataType : "json",
				success : function(data){
						if(data.id === "no"){
							$("#search_name_msg").text("일치하는 정보가 없습니다");
						}else{
							$("#search_name_msg").text("아이디 : "+data.id).css("color","green");
						}
				}
			});
		}
	});

	$("#search_pw").on("submit", function(e) {
	    e.preventDefault();
	    const memberId = $("#search_id").val();
	    const memberPhone = $("#search_phone").val();

	    if (!memberId || !memberPhone) {
	        $("#search_id_msg").text("아이디 또는 전화번호를 입력하세요").css("color", "red");
	    } else {
	        $.ajax({
	            url: "/login/search",
	            type: "post",
	            data: {
	                memberId: memberId,
	                memberPhone: memberPhone
	            },
	            dataType: "json",
	            success: function(data) {
	                if (data.pw === "no") {
	                    $("#search_id_msg").text("일치하는 정보가 없습니다.").css("color", "red");
	                } else{
	                	location.href="<%=request.getContextPath()%>/login/changePw/view?memberId="+data.pw;
	                }
	            }
	        });
	    }
	});




</script>
</body>
</html>