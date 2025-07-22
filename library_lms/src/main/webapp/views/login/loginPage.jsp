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
a { 
	color: #888; 
	text-decoration: none;
}
input:-webkit-autofill ,
input:-webkit-autofill:focus {
  -webkit-box-shadow: 0 0 0px 1000px white inset !important; /* 배경 제거 */
  box-shadow: 0 0 0px 1000px white inset !important;
  -webkit-text-fill-color: black !important; /* 텍스트 색상 */
  background-color: white !important;
  border: none !important; /* 테두리 제거 */
  transition: background-color 5000s ease-in-out 0s !important; /* 크롬 자동완성 페이드 제거 */
}

input {
 	border: none;
 	outline: none;
 	box-shadow: none;
	width:95%;
	height: 20px;
 	line-height: 20px;
 	padding: 0;
 	position:relative;
 	top:20px;
 	box-sizing :border-box;
 	margin-bottom : 3px;
 	cursor: pointer;
}
.input_pw ,.input_id{
	display : flex;
	position:relative;
	box-sizing: border-box;
	border-radius : 5px;
	width:300px;
	height : 50px;
	border : 1px solid #c5ccd2;
	background-color: white;

	padding : 5px;
}
.input_id{
	margin-bottom : 12px;

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
	margin:20px 0 20px;
	width:300px;
	height : 50px;
	background-color: #D8E5F4;
	color : black;
	border: none;
	border-radius:5px;
	transition: background-color 0.3s;
	cursor :pointer;
}
.login_btn:hover{
	background-color: #205DAC;
	color : white;
}
.search_login_data{
	display:flex;
	margin-top:20px;
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
.pre_text{
	position:absolute;
	top:12px;
	color:#888;
	display:flex;
	transition: all 0.3s cubic-bezier(.4,0,.2,1);
}
.pre_text_trans{
	top:2px;
	font-size:12px;
}
#member_id_msg{
 margin: 8px 0 0 0;
 padding-left:3px;
  color: red;
  font-size: 14px;
  width:300px;
  }
</style>
<body>
	<%@ include file="/views/include/header.jsp" %>
	<div class = "container_login">
		<div class = "insert_login_data">		
			<form id ="member_login" >
				<div class="input_id" >
					<c:if test="${not empty cookie.memberId}">
					    <input type="text" id ="member_id" name="member_id"
					           value="${cookie.memberId.value}">
					</c:if>
					<c:if test="${empty cookie.memberId}">
					    <input type="text" id ="member_id" name="member_id" >
					</c:if>
					<label class="pre_text pre_text_id" for="member_id">아이디</label>
				</div>
				
				<div class= "input_pw" >
					<input type="password" id = "member_pw"name="member_pw"  >	
					<label for="member_pw"class="pre_text pre_text_pw">비밀번호</label>
				</div>
				<p id="member_id_msg"></p>
				<input type="submit" class="login_btn" value ="로그인">
			
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
	function updateInputState() {
		  $('input').each(function() {
		    const $input = $(this);
		    const $label = $input.siblings('.pre_text'); // input과 같은 부모 안의 label
		    if ($input.is(':focus') ||$input.val().trim() !== '') {
		    	$label.addClass('pre_text_trans');
		    }else{
		    	 $label.removeClass('pre_text_trans');
		    } 
		  });
		}

		$(document).ready(function() {
		  updateInputState(); // 페이지 로딩 시 체크

		  // 사용자 이벤트 대응
		  $('input').on('focus blur input', updateInputState);
		  $(window).on('load', updateInputState);
		});
	
	</script>
	
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
    						
   							location.href="<%=request.getContextPath()%>/main";
        				}
   					}
    			});	
    		}
		});
	
		
	
	</script>
	
	
	

</body>
</html>