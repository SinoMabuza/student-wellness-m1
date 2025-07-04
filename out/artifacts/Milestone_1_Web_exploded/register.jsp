<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Student Registration</title>
</head>
<body>
<h2>Register for BC Student Wellness</h2>
<form action="register" method="post">
    <label>Student Number:</label><br>
    <input type="text" name="student_number" required><br><br>

    <label>First Name:</label><br>
    <input type="text" name="name" required><br><br>

    <label>Last Name:</label><br>
    <input type="text" name="surname" required><br><br>

    <label>Email:</label><br>
    <input type="email" name="email" required><br><br>

    <label>Phone:</label><br>
    <input type="text" name="phone" required><br><br>

    <label>Password:</label><br>
    <input type="password" name="password" required><br><br>

    <input type="submit" value="Register">
</form>

<p>Already registered? <a href="login.jsp">Login here</a></p>
</body>
</html>
