package com.bc.Servlets;

import java.io.IOException;
import java.sql.*;

import com.bc.util.DatabaseUtil;
import org.mindrot.jbcrypt.BCrypt;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String studentNumber = request.getParameter("student_number");
        String name = request.getParameter("name");
        String surname = request.getParameter("surname");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String password = request.getParameter("password");

        String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());

        try (Connection conn = DatabaseUtil.getConnection()) {

            // Check if user already exists
            PreparedStatement checkStmt = conn.prepareStatement(
                    "SELECT * FROM users WHERE email = ? OR student_number = ?"
            );
            checkStmt.setString(1, email);
            checkStmt.setString(2, studentNumber);
            ResultSet rs = checkStmt.executeQuery();

            if (rs.next()) {
                // Duplicate user
                request.setAttribute("error", "Email or student number already exists.");
                request.getRequestDispatcher("register.jsp").forward(request, response);
            } else {
                // Register new user
                PreparedStatement ps = conn.prepareStatement(
                        "INSERT INTO users (student_number, name, surname, email, phone, password) " +
                                "VALUES (?, ?, ?, ?, ?, ?)"
                );
                ps.setString(1, studentNumber);
                ps.setString(2, name);
                ps.setString(3, surname);
                ps.setString(4, email);
                ps.setString(5, phone);
                ps.setString(6, hashedPassword);
                ps.executeUpdate();

                // Create session and redirect
                HttpSession session = request.getSession();
                session.setAttribute("userName", name);
                session.setAttribute("email", email);

                response.sendRedirect("dashboard.jsp");
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Registration failed: " + e.getMessage());
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }

    // Handle GET (optional)
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("register.jsp").forward(request, response);
    }
}
