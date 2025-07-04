package com.bc.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

import com.bc.util.DBConnection;
import org.mindrot.jbcrypt.BCrypt;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get parameters from the form
        String studentNumber = request.getParameter("student_number");
        String name = request.getParameter("name");
        String surname = request.getParameter("surname");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String password = request.getParameter("password");

        // Hash the password
        String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        try (Connection conn = DBConnection.getConnection()) {
            // Check if email or student number already exists
            PreparedStatement checkStmt = conn.prepareStatement(
                    "SELECT * FROM users WHERE email = ? OR student_number = ?"
            );
            checkStmt.setString(1, email);
            checkStmt.setString(2, studentNumber);
            ResultSet rs = checkStmt.executeQuery();

            if (rs.next()) {
                out.println("<p>Email or student number already exists. <a href='register.jsp'>Try again</a></p>");
            } else {
                // Insert new user
                PreparedStatement ps = conn.prepareStatement(
                        "INSERT INTO users (student_number, name, surname, email, phone, password) VALUES (?, ?, ?, ?, ?, ?)"
                );
                ps.setString(1, studentNumber);
                ps.setString(2, name);
                ps.setString(3, surname);
                ps.setString(4, email);
                ps.setString(5, phone);
                ps.setString(6, hashedPassword);

                ps.executeUpdate();

                response.sendRedirect("login.jsp"); // Redirect on success
            }

        } catch (Exception e) {
            e.printStackTrace();
            out.println("<p>Registration failed. <a href='register.jsp'>Try again</a></p>");
        }
    }
}
