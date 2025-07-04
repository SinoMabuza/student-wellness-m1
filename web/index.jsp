<%--
  Created by IntelliJ IDEA.
  User: mabuz
  Date: 2025/07/04
  Time: 20:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>BC Student Wellness - Home</title>
    <!-- Favicon -->
    <link rel="icon" href="${pageContext.request.contextPath}/favicon.ico" type="image/x-icon">
    <!-- Basic styling -->
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
        }
        ul {
            list-style-type: none;
            padding: 0;
        }
        li {
            margin: 10px 0;
        }
        a {
            display: inline-block;
            padding: 10px 15px;
            background-color: #3498db;
            color: white;
            text-decoration: none;
            border-radius: 4px;
        }
        a:hover {
            background-color: #2980b9;
        }
    </style>
</head>
<body>
<h1>Welcome to BC Student Wellness</h1>

<p>Please choose an option below:</p>

<ul>
    <li><a href="login.jsp">Login</a></li>
    <li><a href="register.jsp">Register</a></li>
</ul>
</body>
</html>