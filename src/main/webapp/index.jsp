<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Home Page</title>

    <!-- Enhanced CSS Styling -->
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #f0f4f8, #d9e2ec);
            color: #2c3e50;
            padding: 40px 20px;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
        }

        h1 {
            font-size: 2.5rem;
            margin-bottom: 40px;
            text-align: center;
        }

        .options {
            display: flex;
            flex-direction: row;
            gap: 30px;
            flex-wrap: wrap;
            justify-content: center;
        }

        .btn {
            background-color: #3498db;
            color: #fff;
            padding: 14px 30px;
            text-decoration: none;
            border-radius: 8px;
            font-size: 1rem;
            font-weight: bold;
            transition: all 0.3s ease;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        .btn:hover {
            background-color: #2980b9;
            transform: translateY(-2px);
        }

        @media (max-width: 500px) {
            h1 {
                font-size: 2rem;
            }

            .btn {
                padding: 12px 20px;
                font-size: 0.95rem;
            }
        }
    </style>
</head>
<body>

<h1>Welcome to the Student Wellness Portal</h1>

<div class="options">
    <a href="${pageContext.request.contextPath}/login.jsp" class="btn">Login</a>
    <a href="${pageContext.request.contextPath}/register.jsp" class="btn">Register</a>
</div>

</body>
</html>
