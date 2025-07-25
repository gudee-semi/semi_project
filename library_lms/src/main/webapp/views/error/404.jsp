<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>403 Forbidden</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: 'Segoe UI', 'Pretendard', sans-serif;
            background-color: #f4f6f9;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            height: 100vh;
            color: #333;
        }

        .error-container {
            text-align: center;
            max-width: 600px;
        }

        .error-code {
            font-size: 120px;
            font-weight: bold;
            color: #ff6b6b;
            margin: 0;
        }

        .error-message {
            font-size: 24px;
            margin: 10px 0 20px;
        }

        .error-description {
            font-size: 16px;
            color: #666;
            margin-bottom: 30px;
        }

        .back-button {
            padding: 12px 24px;
            background-color: #4a90e2;
            color: white;
            border: none;
            border-radius: 6px;
            font-size: 16px;
            cursor: pointer;
            text-decoration: none;
        }

        .back-button:hover {
            background-color: #357ab8;
        }
    </style>
</head>
<body>
    <div class="error-container">
        <h1 class="error-code">404</h1>
        <div class="error-message">페이지가 존재하지 않습니다.</div>
        <div class="error-description">
            죄송합니다. 페이지가 삭제되었거나 존재하지 않습니다.
        </div>
        <a href="/main" class="back-button">홈으로 돌아가기</a>
    </div>
</body>
</html>