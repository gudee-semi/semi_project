<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>
.container_login { 

	display : flex;
	justify-content: center;
	align-content: center;
	
}
 
</style>
<body>
	<%@ include file="/views/include/header.jsp" %>
	<div style = "height : 100px;" ></div>
	
	<div class = "container_login">
	
		
		
		<div>		
			<form id ="member_login">
			
				<input type="text" name ="member_id"placeholder="아이디 : ">
				<p id="member_id_msg">
				<input type="password" name="member_pw" placeholder="비밀번호 : ">	
				<p id="member_pw_msg">
				<input type="submit" value ="로그인">
			</form>
			
			
			<br>
			
			<a href="<c:url value='/login/signup'/>">회원가입</a> <br>
			<a href="<c:url value='/login/search?type=id'/>">아이디찾기</a> <br>
			<a href="<c:url value='/login/search?type=pw'/>">비밀번호찾기</a> <br>
		
			
		</div>
		
		
	</div>
	<script>
		$("#member_login").submit(function(e){
			e.preventDefault();
			const memberId = $("#member_id").val();
    		const memberPw = $("#member_pw").val();
    		
    		if(!memberId){
    			$("#member_id_msg").text("아이디를 입력하세요").css("color","red");
    			
    		}else if(!memberPw){
    			$("#member_id_msg").text("비밀번호를 입력하세요").css("color","red");
    		}else{
    			
    			
    			
    		}
			
			
		});
	
		
	
	</script>
	
	
	
</body>
</html>