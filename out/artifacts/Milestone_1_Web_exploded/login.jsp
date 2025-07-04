<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Login</title>
    <!-- Add favicon link -->
    <link rel="icon" href="${pageContext.request.contextPath}/favicon.ico">
</head>
<body>

<h2>Login to BC Student Wellness</h2>

<!-- Display login error -->
<% if (request.getAttribute("error") != null) { %>
<p style="color:red;"><%= request.getAttribute("error") %></p>
<% } %>

<form action="login" method="post">
    <label>Email:</label><br>
    <input type="email" name="email" required><br><br>

    <label>Password:</label><br>
    <input type="password" name="password" required><br><br>

    <input type="submit" value="Login">
</form>

<p>Don't have an account? <a href="register.jsp">Register here</a></p>

</body>
</html>