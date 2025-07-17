package com.hy.controller.qna;

import java.io.IOException;

import com.hy.service.WeatherApiService;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/weather/view")
public class WeatherViewServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private final WeatherApiService weatherApiService = new WeatherApiService();
       
    public WeatherViewServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String baseDate = "20250717";
        String baseTime = "0500";
        int nx = 60;
        int ny = 127;

        String jsonResult = weatherApiService.getWeatherData(baseDate, baseTime, nx, ny);
        System.out.println(jsonResult);
        // JSP로 데이터 전달
        request.setAttribute("weatherData", jsonResult);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/views/include/header.jsp");
        dispatcher.forward(request, response);
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
