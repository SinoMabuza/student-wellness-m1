<%@ page contentType="text/html;charset=UTF-8" language="java" session="true" %>
<%
  String name = (String) session.getAttribute("userName");

  if (name == null) {
    response.sendRedirect("login.jsp");
    return;
  }
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>Dashboard</title>
  <link rel="icon" href="${pageContext.request.contextPath}/favicon.ico" type="image/x-icon">
  <style>
    body {
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      background: linear-gradient(135deg, #e8f0fe, #d0e1ff);
      padding: 40px;
      text-align: center;
      color: #2c3e50;
    }

    h1 {
      font-size: 2.5rem;
      margin-bottom: 30px;
    }

    .logout-btn {
      background-color: #e74c3c;
      color: white;
      padding: 12px 24px;
      font-size: 1rem;
      border: none;
      border-radius: 6px;
      cursor: pointer;
      transition: background-color 0.3s ease;
    }

    .logout-btn:hover {
      background-color: #c0392b;
    }
  </style>
</head>
<body>

<h1>Welcome, <%= name %>!</h1>

<form action="${pageContext.request.contextPath}/logout" method="post">
  <input type="submit" class="logout-btn" value="Logout">
</form>

</body>
</html>
