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
input:-webkit-autofill:focus {
    border: 1px solid #B6D0E2 !important;
    -webkit-box-shadow: 0 0 0 1000px white inset !important;
    box-shadow: 0 0 0 1000px white inset !important;
    -webkit-text-fill-color: black !important;
}
input:-webkit-autofill {
    border: 1px solid #c5ccd2 !important;  /* 포커스 상태처럼 테두리 */
    -webkit-box-shadow: 0 0 0 1000px white inset !important;
    box-shadow: 0 0 0 1000px white inset !important;
    -webkit-text-fill-color: black !important;
}
a { 
	color: #888; 
	text-decoration: none;
}
#member_id ,#member_pw{
	display : flex;
	box-sizing: border-box;
	border-radius : 5px;
	width:300px;
	height : 50px;
	border : 1px solid #c5ccd2;
	background-color: white;
	cursor:pointer;
}
#member_id:focus, #member_pw:focus{
    border :1px solid #B6D0E2;
}
.container_login { 
	width : 400px;
	display : flex;
	
	justify-content: center;
	flex-direction: column;
	align-items: center;
	margin : 200px auto 100px;
	border : 1px solid #c5ccd2 ;
	border-radius : 5px;
}
.insert_login_data{
	margin-top:50px;
	display:flex;
	justify-content: center;
	flex-direction: column;

}
.login_btn{
	margin-top:40px;
	width:300px;
	height : 50px;
	background-color: #D8E5F4;
	color : black;
	border: none;
	border-radius:5px;
	
	
}
.login_btn:hover{
	cursor :pointer;
	background-color: #205DAC;
	color : white;
}
.search_login_data{
	display:flex;
	gap: 6px;
	align-items: center;
	margin-bottom :18px;
}
.line{
	padding : 0;
	height: 15px;
	width : 1px;
	background-color: #888;
	box-sizing: border-box;
	margin : 0 2px;
}

</style>
<body>
	<%@ include file="/views/include/header.jsp" %>
	
	<div class = "container_login">
		<div class = "insert_login_data">		
			<form id ="member_login">
			
				<c:if test="${not empty cookie.memberId}">
				    <input type="text" id ="member_id" name="member_id" placeholder="아이디 : "
				           value="${cookie.memberId.value}">
				</c:if>
				<c:if test="${empty cookie.memberId}">
				    <input type="text" id ="member_id" name="member_id" placeholder="아이디 : ">
				</c:if>
			
				<input type="password" id = "member_pw"name="member_pw" placeholder="비밀번호 : ">	
		
				<input type="submit" class="login_btn" value ="로그인">
				<p id="member_id_msg"></p>
			</form>
		</div>
		<div class = "search_login_data">
			<a href="<c:url value='/login/signup'/>" class="signup">회원가입</a>
			<div class="line"></div>
			<a href="<c:url value='/login/search?type=id'/>"class="search_id">아이디찾기</a>
			<div class="line"></div>
			<a href="<c:url value='/login/search?type=pw'/>"class="search_pw">비밀번호찾기</a>
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