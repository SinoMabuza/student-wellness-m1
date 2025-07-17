<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
  <title>Student Registration</title>

  <!-- Enhanced CSS Styling -->
  <style>
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }

    body {
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      background: linear-gradient(135deg, #e8f5e9, #c8e6c9);
      display: flex;
      justify-content: center;
      align-items: center;
      min-height: 100vh;
      padding: 20px;
    }

    .register-container {
      background-color: #ffffff;
      padding: 40px;
      border-radius: 10px;
      box-shadow: 0 8px 16px rgba(0, 0, 0, 0.1);
      max-width: 500px;
      width: 100%;
    }

    h2 {
      text-align: center;
      margin-bottom: 30px;
      color: #2e7d32;
    }

    label {
      display: block;
      margin-bottom: 8px;
      font-weight: bold;
    }

    input[type="text"],
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
      background-color: #4caf50;
      color: white;
      padding: 12px;
      border: none;
      border-radius: 6px;
      font-size: 1rem;
      cursor: pointer;
      transition: background-color 0.3s ease;
    }

    input[type="submit"]:hover {
      background-color: #388e3c;
    }

    .login-link {
      text-align: center;
      margin-top: 15px;
    }

    .login-link a {
      color: #2e7d32;
      text-decoration: none;
    }

    .login-link a:hover {
      text-decoration: underline;
    }
  </style>
</head>
<body>
<div class="register-container">
  <h2>Register for BC Student Wellness</h2>
  <% if (request.getAttribute("errorMessage") != null) { %>
  <p class="error"><%= request.getAttribute("errorMessage") %></p>
  <% } %>
  <form action="RegisterServlet" method="post">
    <label for="student_number">Student Number:</label>
    <input type="text" id="student_number" name="student_number" required>

    <label for="name">First Name:</label>
    <input type="text" id="name" name="name" required>

    <label for="surname">Last Name:</label>
    <input type="text" id="surname" name="surname" required>

    <label for="email">Email:</label>
    <input type="email" id="email" name="email" required>

    <label for="phone">Phone:</label>
    <input type="text" id="phone" name="phone" required>

    <label for="password">Password:</label>
    <input type="password" id="password" name="password" required>

    <input type="submit" value="Register">
  </form>

  <div class="login-link">
    <p>Already registered? <a href="login.jsp">Login here</a></p>
  </div>
</div>

</body>
</html>
