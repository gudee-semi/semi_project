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

<!--비밀번호 -->
<form id="updateAccount">
	<p>비밀번호 변경 </p>
	<input type="text" id="member_pw" name="member_pw" placeholder="새로운 비밀번호 입력"><br>
	<input type="text" id="member_pw_check" placeholder="비밀번호 확인"><br>
	<p id="member_pw_msg"></p>
	
	<br>
	
	<!--주소 검색  -->
	<input type="button" id = "addressBtn" value="주소검색"><br>
	<input type="text" id="member_address" name="member_address" readonly><br>
	<input type="text" id="member_address_detail" name="member_address_detail" >
	<!--주소 모달창  -->
	<div id="layer" style="display:none;background-color:white;position :absolute;overflow:hidden;
	z-index:1;border:1px solid;width:500px;height:400px;left:20px;top:200px; ">
		<div style="background-color:blue; position:relative; height:35px; z-index:2;">
	
		 <button type="button" id ="addressCloseBtn"style=" position :absolute; top:3px;
		 right:3px; z-index:2;">닫기</button>
	
	
	
		</div>
		<div id="addressWindow" style="width :100%; height : 100%;">
		</div>
	</div>
	<p id= "member_address_msg"></p>
	
	<!-- 학교 검색  -->
	<input type="button" id = "member_schul_search" value="학교검색"><br>
	<input type="text" id="member_schul" name="member_schul" readonly><br>
	<p id = "member_schul_msg">
	
	<!-- 학교 검색 모달 -->
	<div id="schul_modal">
		
		<div id = "modal_title">
		
			<button type= "button" id ="modal_close_btn">닫기</button>
		
		</div>
		<div id = "modal_content">
			<div id = "search_field"></div>
				<input id = "schul_name" type="text" placeholder="학교이름 입력" > 
				<button type= "button" id = "schul_search">검색</button>
		</div>
			<div id = "result_field">
			    <ul>
				</ul>
			</div>
	</div>
	
	<!-- 학년 입력 -->
	<select id ="member_grade" name="member_grade">
		<option value="1">1학년</option>
		<option value="2">2학년</option>
		<option value="3">3학년</option>
	</select>
	
	<!-- 프로필 이미지 첨부 -->
	<input type="file" id = "member_profile" name = "member_profile">
	<p id= "previewImg_msg">
	<p id ="member_profile_msg"></p>
	<img id="previewImg"width="200px" height="200px" hidden>
	
	<input type="submit" value="수정하기"/>
	
</form>
<form id="deleteMember" action="/delete/member" method="get">
	<input type="submit" value="계정삭제">
</form>
<a href="<c:url value='/main/view'/>">나가기</a>
	<script>
		const memberNo = ${sessionScope.loginMember.memberNo};
		const memberAccountAddress = '${sessionScope.loginMember.memberAddress}';
		const memberAccountSchool ='${sessionScope.loginMember.memberSchool}';
		const memberAccountGrade = '${sessionScope.loginMember.memberGrade}';
	</script>
	<script >
	//페이지 들어왔을 때 그 계정의 정보를 뿌려줌
		$(document).ready(function() {
		  $("#member_address").val(memberAccountAddress);
		  $("#member_schul").val(memberAccountSchool);
		  $("#member_grade").val(memberAccountGrade);
		  $.ajax({
			url : "/file/DealWith?memberNo="+memberNo,
			type : "get",
			dataType : "json",
			success : function(data){
					$("#previewImg").attr("src",'/profile/filePath?filePath='+data.path).show();
					$("#previewImg_msg").text(data.oriname);
			}
		  });
		});
		
	</script>
	<script>
 	// 변수 설정, 정규식 설정
	let pwStatus =true;
	let rrnStatus = true;
	let addressStatus = true;
	let schulStatus= true;
	let gradeStatus= true;
	let profileStatus = true;
	const pwReg = /^[a-zA-Z0-9!@#$%^&*?]{6,12}$/;
	const imgReg = /\.(jpg|png)$/i;
	let memberPw="";
	let member_pw_check="";
	let memberAddress="";
	let memberSchul="";
	let memberGrade=0;
	let memberProfile="";
</script>
	<script>
	//비밀번호 정규식 검사 , 비밀번호 재확인 
	$("#member_pw, #member_pw_check").on("input blur",function(){
		pwStatus=false;
		memberPw = $("#member_pw").val().trim();
		member_pw_check = $("#member_pw_check").val().trim();
		if(memberPw==""&&member_pw_check==""){
			pwStatus=true;
			$("#member_pw_msg").text("").css('color','red');
			return;
		}
		if (!pwReg.test(memberPw)){
			$("#member_pw_msg").text("비밀번호:6~12자의 영문 소문자,숫자 특수기호(!@#$%^&*?)만 사용가능합니다.").css('color','red');
		}else if(memberPw!==member_pw_check){
			$("#member_pw_msg").text("비밀번호가 일치하지 않습니다.").css('color','red');
		}else{
			$("#member_pw_msg").text("").css('color','red');
			pwStatus=true;
		}
	});
	</script>
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script>
	
	//주소 모달닫기
	$("#addressCloseBtn").on("click",function(){
	    document.getElementById('layer').style.display = 'none';
	});
	//주소검색 버튼 클릭
	$("#addressBtn").on("click",function(){
		let element_layer = document.getElementById('layer');
		element_layer.style.display = 'block';
	        new daum.Postcode({
	            oncomplete: function(data) {
	                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
	                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	                let addr = ''; // 주소 변수
	                let extraAddr = ''; // 참고항목 변수
	                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
	                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
	                    addr = data.roadAddress;
	                } else { // 사용자가 지번 주소를 선택했을 경우(J)
	                    addr = data.jibunAddress;
	                }

	                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
	                if(data.userSelectedType === 'R'){
	                    // 건물명이 있고, 공동주택일 경우 추가한다.
	                    if(data.buildingName !== '' && data.apartment === 'Y'){
	                        extraAddr =   data.buildingName;
	                    }
	                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
	                    if(extraAddr !== ''){
	                        extraAddr = ' (' + extraAddr + ')';
	                    }
	                } 

	                //주소 정보를 해당 필드에 넣는다.
	                memberAddress=addr+extraAddr;
	                document.getElementById("member_address").value = memberAddress;
	            	$("#member_address_msg").text("");
	                // 커서를 상세주소 필드로 이동한다.
	                document.getElementById("member_address_detail").focus();
	                element_layer.style.display = 'none';
	                
	            }
	        }).embed(document.getElementById('addressWindow'));
	});
	</script>
	
	<script>
	//서울시 학교 검색
		$("#schul_search").on("click",function(){	
			let schulName = $("#schul_name").val().trim();
			let url = "http://openapi.seoul.go.kr:8088/4f584c4c61776a6433375a44634f47/json/neisSchoolInfoHs/1/318";
			let rows=[];
			let name =[];
			let result="";
				// 1. 비동기 통신으로 서울시 학교 데이터 전부를 가져와서 rows에 저장
				// 2. rows에서 검색 키워드가 포함된 학교정보를 name에 저장
				// 3. name값을 전부 가져와서 li태그로 result_field에 뿌려줌
			if(schulName!==""){
				$.ajax({
					url : url,
					type: "get",
					dataType: "json",
					success : function(data){
				
						if(data.neisSchoolInfoHs.row){
							rows= data.neisSchoolInfoHs.row
						}
						
						
						for(const da of rows){
							if (da.SCHUL_NM.includes(schulName)) {
								name.push(da.SCHUL_NM);
						      }
						}
						
						
						if(name.length===0){
							$("#result_field").text("없는 학교입니다.");
						}else{
							for(let i = 0 ; i <name.length; i++){
								result+="<li class = 'schul_list'>"+name[i]+"</li>";
							}
							$("#result_field").html(result);
						}	
					},
					error: function(){
						alert("요청실패");
					}
				});
			}else{
				$("#result_field").html(result);
			}
				
			});
		// 클릭한 요소 뿌려주기 이때 모든 class 이름이 shcul_list이므로 그 중 하나를 선택해 값을 넘겨준다면 this를사용
		// 이벤트 위임을 사용해 동적으로 추가된 요소에 이벤트를 연결함 
		// 문서가 처음 로딩될때만 이벤트가 붙는다 하지만 schul_list는 동적으로 생기기 떄문에 이벤트가 붙지않음 그래서 그부모한테 붙여놓고  
		// 자식이 생겨났을때 자식한테 위임함
		$("#result_field").on("click",".schul_list",function(){
			const text = $(this).text();
			$("#member_schul").val(text);
			memberSchul=text;
			$("#member_schul_msg").text("");
			schulStatus=true;
			
		})
		
			
	</script>
		<script >
		//학년 선택
		$("#member_grade").on("change",function(){
			memberGrade= $("#member_grade").val();
			gradeStatus=true;
	
		});
	
	</script>
	
	<script>
		//프로필 이미지
	$("#member_profile").on("change",function(){
		profileStatus=false;
		$("#member_profile_msg").text("");
		$("#previewImg").removeAttr("src").hide();
		 $("#previewImg_msg").text("");
		const file = this.files[0];
		if(!file){
			$("#member_profile_msg").text("파일을 선택해주세요").css('color','red');
		}else if(!imgReg.test(memberProfile=file.name)){
			$("#member_profile").val("");
			$("#member_profile_msg").text("지원하지 않는 확장자입니다.(jpg ,png 파일만 첨부가능합니다)").css('color','red');
			profileStatus=true;
		}else{
			const reader = new FileReader();
			reader.onload = function(e){
				$("#previewImg").attr("src", e.target.result).show();
			};
			 reader.readAsDataURL(file);
			 profileStatus=true;
		}
	});
	</script>
	
	
	
	<script>
		$("#updateAccount").on("submit",function(e){
			e.preventDefault();
			if(pwStatus && addressStatus && schulStatus && gradeStatus &&profileStatus ){
				const form = document.getElementById("updateAccount");
				const formData = new FormData(form);
				formData.set("member_pw", memberPw);
				formData.set("member_address", memberAddress);
				formData.set("member_schul", memberSchul);
				formData.set("member_grade", memberGrade);
				formData.set("member_no", memberNo);
				
				$.ajax({
					url : "/update/member",
					type : "post",
					data : formData,
					enctype : "multipart/form-data",
					contentType : false,
					processData : false,
					cache : false,
					dataType :"json",
					success : function(data){
						if(data.res_code==500){
							alert(data.res_msg);
							location.href ="<%=request.getContextPath()%>/mypage/view";
						}else{
							 alert(data.res_msg);
							 location.href ="<%=request.getContextPath()%>/main/view";
						}					
					}
					
				});
			

			}
		
		})
		
	
	</script>

	<script>
		$("#deleteMember").on("submit",function(e){
			e.preventDefault();
			 if (confirm("정말 계정을 삭제하시겠습니까?")) {
			      this.submit(); 
			      
			    } else {
			      alert("계정 삭제가 취소되었습니다.");
			    }
		})
	
	</script>





















</body>
</html>