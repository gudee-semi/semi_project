<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- CSS -->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/main/main.css">
<style>
.sidebars {
	width: 300px;
	height: 100vh;
}

.flex-container {
	display: flex;
	align-items: flex-start;
}

.container {
	flex: 1;
}

header {
	margin: 0 !important;
}

footer {
	margin-top: 0px !important;
}

.background-image {
	display: flex;
	align-items: flex-end;
	justify-content: center;
}

.background-image span {
	color: #ffffff;
	font-size: 20px;
	opacity: 1;
}

.link:hover {
	text-decoration: underline;
}

.weather-box {
	position: absolute;
	top: 15px;
	right: 35px;
}

.weather-wrapper {
	display: flex;
	align-items: center;
	border: 2px solid white;
	border-radius: 20px;
	padding: 10px 15px;
	color: #F5F5F5;
}

.weather-info {
	margin-left: 10px;
	font-size: 14px;
}
</style>

</head>
<body>
	<%@ include file="/views/include/header.jsp" %>
	<div class="flex-container">
		<div class="sidebars"><%@ include file="/views/include/sidebar.jsp" %></div>
		<div class="container">
			<div class="background-image" style="background-image: url('<%= request.getContextPath() %>/images/wallpaper.gif'); background-repeat: no-repeat; height: 945px">
			    <!-- 공지사항 -->
			    <div style="width: 50%; height: 230px; background-color: rgba(0, 0, 0, 0.6); padding: 20px; color: white;">
			        <div style="display: flex; justify-content: space-between; align-items: center; border-bottom: 1px solid #fff; margin-bottom: 10px;">
			            <strong style="font-size: 20px;">공지사항</strong>
			            <span style="font-size: 24px; cursor: pointer;" onclick="location.href='<c:url value="/notice/list"/>'">+</span>
			        </div>
			        <c:forEach var="notice" items="${noticeList}" varStatus="status" begin="0" end="4">
			            <div style="display: flex; justify-content: space-between; margin-bottom: 5px;">
			                <span onclick="location.href='<c:url value="/notice/detail?no=${ notice.noticeId }"/>'" style="cursor: pointer;" class="link">${notice.title}</span>
			                <span>${notice.createAt}</span>
			            </div>
			        </c:forEach>
			    </div>
			
			    <!-- 질의응답 영역 -->
			    <div style="width: 50%; height: 230px; background-color: rgba(0, 0, 0, 0.6); padding: 20px; color: white;">
			        <div style="display: flex; justify-content: space-between; align-items: center; border-bottom: 1px solid #fff; margin-bottom: 10px;">
			            <strong style="font-size: 20px;">질의응답</strong>
			            <span style="font-size: 24px; cursor: pointer;" onclick="location.href='<c:url value="/qna/view"/>'">+</span>
			        </div>
			        <c:forEach var="qna" items="${qnaList}" varStatus="status" begin="0" end="4">
			            <div style="display: flex; justify-content: space-between; margin-bottom: 5px;">
			                <span onclick="location.href='<c:url value="/qna/detail?no=${qna.qnaId }"/>'" style="cursor: pointer;" class="link">${qna.title}</span>
			                <span>${qna.regDate}</span>
			            </div>
			        </c:forEach>
			    </div>
			    
			</div>
		</div>
		
		
		<div class="weather-box">
			<div class="weather-wrapper">
        		<img id="icon" alt="날씨 아이콘" style="width: 50px; height: 50px;">
       			<div class="weather-info">
	      			<div><span id="cityName"></span></div>
					<div style="font-size: 16px">기온 <span id="temperature"></span> ℃</div>
        			<div style="font-size: 16px">습도 <span id="humidity"></span> %</div>
				</div>
    		</div>
		</div>
		
	<script>
		$(document).ready(function() {
			// 영어 도시명을 한글로 매핑
		    const cityNameMap = {
		        "Seoul": "서울",
		        "Busan": "부산",
		        "Incheon": "인천",
		        "Daegu": "대구",
		        "Gwangju": "광주",
		        "Daejeon": "대전",
		        "Ulsan": "울산"
		        // 필요 시 더 추가 가능
		    };
			
		    $.ajax({
		        url: "/weatherservlet",
		        method: "GET",
		        dataType: "json",
		        success: function(data) {
		        	 // cityName이 매핑되어 있으면 한글로, 아니면 원래 값으로 표시
		            const cityInKorean = cityNameMap[data.cityName] || data.cityName;
		        	
		            $("#cityName").text(cityInKorean);
		            $("#weather").text(data.weather);
		            $("#icon").attr("src", "https://openweathermap.org/img/wn/" + data.icon + "@2x.png");
		            $("#temperature").text(parseInt(data.temperature));
		            $("#feelsLike").text(data.feelsLike);
		            $("#humidity").text(data.humidity);
		            $("#windSpeed").text(data.windSpeed);
		        },
		        error: function() {
		            $(".weather-box").text("날씨 정보를 불러올 수 없습니다.");
		        }
		    });
		});
	</script>
		
		
        
	</div>
	<%@ include file="/views/include/footer.jsp" %>
</body>
</html>