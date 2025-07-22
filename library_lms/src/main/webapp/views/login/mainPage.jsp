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
		width: 250px;
		height: 100vh;
}

.flex-container {
	display: flex;
	align-items: flex-start;
 		column-gap: 150px;
}

.container {
	width: 70%;
}

header {
	margin: 0 !important;
}

footer {
	margin-top: 0px !important;
}

.weather-box {	
	position: absolute;
	top: 15px;
	right: 35px;
	display: flex;
	font-size: 15px;
}

#icon {
    translate: 5px -10px;
}
</style>
</head>
<body>
	<%@ include file="/views/include/header.jsp" %>
	<div class="flex-container">
		<div class="sidebars"><%@ include file="/views/include/sidebar.jsp" %></div>
		<div class="container">메인페이지</div>
	</div>
	
		<div class="container">
    메인페이지
    <div class="weather-box">
			<div>
        <img id="icon" alt="날씨 아이콘" style="vertical-align: middle;">
			</div>
	    <div>
	      <div><span id="cityName"></span></div>
				<div>기온 <span id="temperature"></span> ℃</div>

        <div>습도 <span id="humidity"></span> %</div>
	    </div>
	    

    </div>
</div>
	<%@ include file="/views/include/footer.jsp" %>
	

	
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
















</body>
</html>