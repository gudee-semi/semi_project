<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<p>지역: ${cityName}</p>
    <c:if test="${not empty icon}">
        <img src="http://openweathermap.org/img/wn/${icon}@2x.png" alt="날씨 아이콘" />
    </c:if>
	</p>
	<p>온도: ${temp} ℃</p>
	<p>체감온도: ${feelsLike} ℃</p>
	<p>습도: ${humidity} %</p>
	<p>풍속: ${windSpeed} m/s</p>

</body>
</html>