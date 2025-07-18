package com.hy.controller.weather;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/weatherservlet")
public class WeatherServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public WeatherServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	// 1. 도시명과 API 키 지정
	String city = "Seoul"; // 또는 request.getParameter("city") 등으로 받기
		
    // 2. OpenWeatherMap API 키 입력
    String apiKey = "a5734c7567afe401a5c7d6ee351aacec"; // 본인 API 키 입력
    
	// 2. 날씨 API URL 조립 (필요한 옵션 파라미터 추가)
	// - q=도시명 : 도시명 (영문/한글 모두 가능)
	// - appid=API키 : 본인 API키
	// - units=metric : 섭씨(Celsius)로 온도 단위 변환
	// - lang=kr : 한국어 설명 받기
	String apiUrl = "https://api.openweathermap.org/data/2.5/weather?q=" + city + "&appid=" + apiKey + "&units=metric" + "&lang=kr";

    // 4. URL 객체 생성
    URL url = new URL(apiUrl);

    // 5. HTTP 연결 객체 생성
    HttpURLConnection conn = (HttpURLConnection) url.openConnection();

    // 6. GET 방식으로 요청 설정
    conn.setRequestMethod("GET");

    // 7. 응답 코드 확인
    int responseCode = conn.getResponseCode();

    // 8. 응답 읽기용 버퍼 생성
    BufferedReader br;
    if (responseCode == 200) { // 성공 시
        br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
    } else { // 에러 시
        br = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
    }

    // 9. 응답 데이터(한 줄씩 읽어오기)
    StringBuilder sb = new StringBuilder();
    String line;
    while ((line = br.readLine()) != null) {
        sb.append(line);
    }

    // 10. 버퍼 닫기
    br.close();

    // 11. JSON 문자열 파싱 (Gson 사용)
    JsonObject jsonObject = JsonParser.parseString(sb.toString()).getAsJsonObject();
    
    // 요청 파라미터에서 도시명 받기 (없으면 기본값 Seoul)
    String cityName = request.getParameter("city");
    if (cityName == null || cityName.trim().equals("")) {
        cityName = "Seoul";
    }
    
    // weather 정보
    String weatherDesc = jsonObject.getAsJsonArray("weather").get(0).getAsJsonObject().get("description").getAsString();
    String icon = jsonObject.getAsJsonArray("weather").get(0).getAsJsonObject().get("icon").getAsString();

    // main 정보
    double temp = jsonObject.getAsJsonObject("main").get("temp").getAsDouble();
    double feelsLike = jsonObject.getAsJsonObject("main").get("feels_like").getAsDouble();
    double tempMin = jsonObject.getAsJsonObject("main").get("temp_min").getAsDouble();
    double tempMax = jsonObject.getAsJsonObject("main").get("temp_max").getAsDouble();
    int humidity = jsonObject.getAsJsonObject("main").get("humidity").getAsInt();
    int pressure = jsonObject.getAsJsonObject("main").get("pressure").getAsInt();

    // wind 정보
    double windSpeed = jsonObject.getAsJsonObject("wind").get("speed").getAsDouble();
    int windDeg = jsonObject.getAsJsonObject("wind").get("deg").getAsInt();



    // 날씨 설명, 온도
    request.setAttribute("weather", weatherDesc);
    request.setAttribute("temp", temp);
    request.setAttribute("icon", icon);
    // 체감온도, 습도, 풍속 등
    request.setAttribute("feelsLike", feelsLike);
    request.setAttribute("humidity", humidity);
    request.setAttribute("windSpeed", windSpeed);
    // 도시명
    request.setAttribute("cityName", cityName);

    // 14. JSP로 포워딩
    request.getRequestDispatcher("/views/weather/weather.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
