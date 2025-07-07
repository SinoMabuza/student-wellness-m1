<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page session="true" %>
<html>
<head>
    <title>Dashboard</title>
</head>
<body>
<h2>Welcome to Your Dashboard</h2>

<p>Hello, <strong><%= session.getAttribute("userName") != null ? session.getAttribute("userName") : "Guest" %></strong>!</p>

<p><a href="logout.jsp">Logout</a></p>
</body>
</html>
