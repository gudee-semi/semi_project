package com.hy.service;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;

import jakarta.servlet.http.HttpServletResponse;

public class WeatherApiService {
	 private static final String SERVICE_KEY = "q6z0kqiLTMZD1PikyaVihlKlQkry+kYq8tmfbnJrbWhjt0LsLQfBLEQddPsRpb+qwu7YWIXT8O94h8hIdDLVyg==";
    private static final String API_URL = "http://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getVilageFcst";

    public String getWeatherData(String baseDate, String baseTime, int nx, int ny) throws IOException {
        StringBuilder urlBuilder = new StringBuilder(API_URL);

        urlBuilder.append("?serviceKey=").append(URLEncoder.encode(SERVICE_KEY, "UTF-8"));
        urlBuilder.append("&pageNo=1");
        urlBuilder.append("&numOfRows=100");
        urlBuilder.append("&dataType=JSON");
        urlBuilder.append("&base_date=").append(baseDate);
        urlBuilder.append("&base_time=").append(baseTime);
        urlBuilder.append("&nx=").append(nx);
        urlBuilder.append("&ny=").append(ny);

        URL url = new URL(urlBuilder.toString());
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");

        BufferedReader rd;
        if (conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
            rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
        } else {
            rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
        }

        StringBuilder sb = new StringBuilder();
        String line;
        while ((line = rd.readLine()) != null) {
            sb.append(line);
        }

        rd.close();
        conn.disconnect();

        return sb.toString();
    }
}
