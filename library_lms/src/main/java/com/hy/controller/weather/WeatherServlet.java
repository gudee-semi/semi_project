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
        String city = request.getParameter("city");
        if (city == null || city.trim().isEmpty()) city = "Seoul";
        String apiKey = "36754930324ec0dcf8ae1a9a82ab0be7"; // 본인 API 키
        String apiUrl = "https://api.openweathermap.org/data/2.5/weather?q=" + city
                + "&appid=" + apiKey
                + "&units=metric"
                + "&lang=kr";

        // 2. OpenWeatherMap API 호출
        URL url = new URL(apiUrl);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
        int responseCode = conn.getResponseCode();

        BufferedReader br;
        if (responseCode == 200) {
            br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
        } else {
            br = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
        }

        StringBuilder sb = new StringBuilder();
        String line;
        while ((line = br.readLine()) != null) {
            sb.append(line);
        }
        br.close();

        // 3. JSON 파싱
        JsonObject jsonObject = JsonParser.parseString(sb.toString()).getAsJsonObject();

        // 4. 필요한 값 추출
        String weatherDesc = jsonObject.getAsJsonArray("weather").get(0).getAsJsonObject().get("description").getAsString();
        String icon = jsonObject.getAsJsonArray("weather").get(0).getAsJsonObject().get("icon").getAsString();
        double temp = jsonObject.getAsJsonObject("main").get("temp").getAsDouble();
        double feelsLike = jsonObject.getAsJsonObject("main").get("feels_like").getAsDouble();
        int humidity = jsonObject.getAsJsonObject("main").get("humidity").getAsInt();
        double windSpeed = jsonObject.getAsJsonObject("wind").get("speed").getAsDouble();
        String cityName = jsonObject.get("name").getAsString();

        // 5. JSON 객체로 응답 만들기
        JsonObject resObj = new JsonObject();
        resObj.addProperty("cityName", cityName);
        resObj.addProperty("weather", weatherDesc);
        resObj.addProperty("icon", icon);
        resObj.addProperty("temperature", temp);
        resObj.addProperty("feelsLike", feelsLike);
        resObj.addProperty("humidity", humidity);
        resObj.addProperty("windSpeed", windSpeed);

        // 6. 응답 타입 지정 및 JSON 반환
        response.setContentType("application/json; charset=UTF-8");
        response.getWriter().write(resObj.toString());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
