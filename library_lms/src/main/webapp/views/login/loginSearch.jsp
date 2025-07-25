<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<style>
    .container_login_search {
      border: 1px solid #c5ccd2;
      border-radius: 8px;
      padding: 30px 40px;
      background-color: #fff;
      width: 400px;
      box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
      margin: 200px auto 100px;
	  box-sizing :border-box;
    }
 	.insert_search_data {
 	  margin:20px auto 0;
   	  width:300px;
      box-sizing: border-box;
    }

    .insert_search_data form {
      display: flex;
      flex-direction: column;
      gap: 15px;
    }

    input[type="text"] ,input[type="password"]{
      padding: 12px;
      border: 1px solid #ccc;
      border-radius: 5px;
      font-size: 14px;
      width:300px;
      height:50px;
      box-sizing: border-box;
    }

    input[type="submit"] {
      background-color: #D8E5F4;
      color: black;
      padding: 12px;
      border: none;
      border-radius: 5px;
      cursor: pointer;
      transition: background-color 0.3s;
      width:300px;
      height:50px;
      box-sizing: border-box;
      margin-top:0;
    }

    input[type="submit"]:hover {
      background-color: #205DAC;
      color:white;
    }

    p {
      font-size: 13px;
      margin-top: 8px;
    }

    #search_name_msg,
    #search_id_msg {
      color: red;
      padding-left: 3px;
    }
 
    #result_container {
      margin-top: 15px;
      text-align: center;
      font-size: 20px;
    }
  </style>
<body>
  <%@ include file="/views/include/header.jsp" %>
  <div class="container_login_search">
    <div class="insert_search_data">
      <c:if test="${type == 'id'}">
        <form id="search_id">
          <input type="text" id="search_name" name="search_name" placeholder="이름">
          <input type="password" id="search_rrn" name="search_rrn" placeholder="주민등록번호">
        <p id="search_name_msg"></p>
          <input type="submit" value="아이디 찾기">
        </form>
        <p id="result_container"></p>
      </c:if>

      <c:if test="${type == 'pw'}">
        <form id="search_pw">
          <input type="text" id="search_id" name="search_id" placeholder="아이디">
          <input type="password" id="search_rrn" name="search_rrn" placeholder="주민등록번호">
        <p id="search_id_msg"></p>
          <input type="submit" value="비밀번호 찾기">
        </form>
      </c:if>
    </div>
  </div>

<script>
const rrnReg = /^\d{2}(0[1-9]|1[0-2])(0[1-9]|[12]\d|3[01])[1-4]\d{6}$/;
	let rrnStatus=false;
$("#search_rrn").on("input blur",function(){
	rrnStatus=false;
	searchRrn = $("#search_rrn").val().trim();
	if (!rrnReg.test(searchRrn)){
		$("#search_id_msg").text("주민등록번호 형식이 잘못되었습니다.(-제외 13자리의 숫자)").css('color','red');
		$("#search_name_msg").text("주민등록번호 형식이 잘못되었습니다.(-제외 13자리의 숫자)").css('color','red');
		
	}
	else{
		$("#search_id_msg").text("").css('color','red');
		$("#search_name_msg").text("").css('color','red');
		rrnStatus=true;
	}
});



</script>


<script>
	$("#search_id").on("submit",function(e){
		e.preventDefault();
		const memberName = $("#search_name").val();
		const memberRrn = $("#search_rrn").val();
		
		if(!memberName||!memberRrn){
			$("#search_name_msg").text("이름 또는 주민등록번호를 입력하세요").css("color","red");
			return;
		}
		if(rrnStatus){
		
			$.ajax({
				url : "/login/search",
				type: "post",
				data : {memberName : memberName,
						member_rrn : memberRrn},
				dataType : "json",
				success : function(data){
						if(data.id === "no"){
							$("#search_name_msg").text("일치하는 정보가 없습니다");
						}else{
							$("#result_container").text("아이디 : "+data.id).css("color","green");
							$("#search_name_msg").text("");
						}
				}
			});
		}
	});

	$("#search_pw").on("submit", function(e) {
	    e.preventDefault();
	    const memberId = $("#search_id").val();
	    const memberRrn = $("#search_rrn").val();

	    if (!memberId || !memberRrn) {
	        $("#search_id_msg").text("아이디 또는 주민등록번호를 입력하세요").css("color", "red");
	    } if(rrnStatus){
	        $.ajax({
	            url: "/login/search",
	            type: "post",
	            data: {
	                memberId: memberId,
	                member_rrn : memberRrn
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