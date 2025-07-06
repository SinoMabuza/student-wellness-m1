<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>BC Student Wellness - Home</title>
    <!-- Favicon -->
    <link rel="icon" href="${pageContext.request.contextPath}/favicon.ico" type="image/x-icon">

    <!-- Basic CSS Styling -->
    <style>
        body {
            font-family: Arial, sans-serif;
            line-height: 1.6;
            margin: 0;
            padding: 20px;
            max-width: 800px;
            margin: 0 auto;
        }
        h1 {
            color: #2c3e50;
            text-align: center;
        }
        .options {
            display: flex;
            justify-content: center;
            gap: 20px;
            margin-top: 30px;
        }
        .btn {
            display: inline-block;
            padding: 12px 24px;
            background-color: #3498db;
            color: white;
            text-decoration: none;
            border-radius: 4px;
            transition: background-color 0.3s;
        }
        .btn:hover {
            background-color: #2980b9;
        }
    </style>
</head>
<body>
<h1>Welcome to BC Student Wellness</h1>

<div class="options">
    <a href="login.jsp" class="btn">Login</a>
    <a href="register.jsp" class="btn">Register</a>
</div>
</body>
</html>