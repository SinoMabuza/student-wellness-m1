<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page language="java" %>
<!DOCTYPE html>
<html>
<head>
  <title>Login</title>

  <!-- Enhanced CSS Styling -->
  <style>
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }

    body {
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      background: linear-gradient(135deg, #e3f2fd, #bbdefb);
      display: flex;
      justify-content: center;
      align-items: center;
      min-height: 100vh;
      padding: 20px;
    }

    .login-container {
      background-color: #ffffff;
      padding: 40px;
      border-radius: 10px;
      box-shadow: 0 8px 16px rgba(0, 0, 0, 0.1);
      max-width: 400px;
      width: 100%;
    }

    h2 {
      text-align: center;
      margin-bottom: 30px;
      color: #2c3e50;
    }

    label {
      display: block;
      margin-bottom: 8px;
      font-weight: bold;
    }

    input[type="email"],
    input[type="password"] {
      width: 100%;
      padding: 10px;
      margin-bottom: 20px;
      border: 1px solid #ccc;
      border-radius: 6px;
      font-size: 1rem;
    }

    input[type="submit"] {
      width: 100%;
      background-color: #3498db;
      color: white;
      padding: 12px;
      border: none;
      border-radius: 6px;
      font-size: 1rem;
      cursor: pointer;
      transition: background-color 0.3s ease;
    }

    input[type="submit"]:hover {
      background-color: #2980b9;
    }

    .error {
      color: #e74c3c;
      margin-bottom: 15px;
      text-align: center;
    }

    .register-link {
      text-align: center;
      margin-top: 15px;
    }

    .register-link a {
      color: #3498db;
      text-decoration: none;
    }

    .register-link a:hover {
      text-decoration: underline;
    }
  </style>
</head>
<body>

<div class="login-container">
  <h2>Login to BC Student Wellness</h2>

  <% if (request.getAttribute("error") != null) { %>
  <p class="error"><%= request.getAttribute("error") %></p>
  <% } %>

  <form action="<%= request.getContextPath() %>/login" method="post">
    <label for="email">Email:</label>
    <input type="email" id="email" name="email"
           value="<%= request.getAttribute("email") != null ? request.getAttribute("email") : "" %>"
           required>

    <label for="password">Password:</label>
    <input type="password" id="password" name="password" required>

    <input type="submit" value="Login">
  </form>

  <div class="register-link">
    <p>Don't have an account?
      <a href="<%= request.getContextPath() %>/register.jsp">Register here</a></p>
  </div>
</div>

</body>
</html>
