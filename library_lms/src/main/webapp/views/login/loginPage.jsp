<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %> 
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
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
			
				<c:if test="${not empty cookie.memberId}">
				    <input type="text" id ="member_id" name="member_id" placeholder="아이디 : "
				           value="${cookie.memberId.value}">
				</c:if>
				<c:if test="${empty cookie.memberId}">
				    <input type="text" id ="member_id" name="member_id" placeholder="아이디 : ">
				</c:if>
			
				<input type="password" id = "member_pw"name="member_pw" placeholder="비밀번호 : ">	
				<p id="member_id_msg"></p>
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
    		
    		if(!memberId||!memberPw){
    			$("#member_id_msg").text("아이디 또는 비밀번호를 입력하세요").css("color","red");
    			
    		}else{
    			$.ajax({
    				url : "/login/view",
    				type : "post",
    				data : {memberId : memberId,
    					  member_pw : memberPw },
    				dataType : "json",
    				success : function(data){
    					if(data.checkId=="no"){
    						$("#member_id").val(memberId);
    						$("#member_pw").val("");
   							$("#member_id_msg").text("아이디 또는 비밀번호가 잘못되었습니다. 정확히 입력해주세요.").css('color','red');
    					}else{
    						
   							location.href="<%=request.getContextPath()%>/main/view";
        				}
   					}
    			});	
    		}
		});
	
		
	
	</script>
	
	
	
</body>
</html>