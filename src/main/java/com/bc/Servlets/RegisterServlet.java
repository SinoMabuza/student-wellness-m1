package com.bc.Servlets;

import java.io.IOException;
import java.sql.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import static com.bc.util.BasicUtilities.*;
import static com.bc.util.DatabaseUtil.*;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String studentNumber = request.getParameter("student_number");
        String email = request.getParameter("email");
        if (CheckIfUserExists(studentNumber, email)) {
            request.setAttribute("errorMessage", "User already exists with this student number or email.");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }
        String name = request.getParameter("name");
        String surname = request.getParameter("surname");
        String phone = request.getParameter("phone");
        String password = request.getParameter("password");
        try {
            if (RegisterUser(studentNumber, name, surname, email, phone, password)) {
                if (SetUserSession(request, studentNumber, email)) {
                    response.sendRedirect(request.getContextPath() + "/DashboardServlet");
                } else {
                    request.setAttribute("errorMessage", "Failed to set user session.");
                    request.getRequestDispatcher("/register.jsp").forward(request, response);
                }
            } else {
                request.setAttribute("errorMessage", "Registration failed. Please try again.");
                request.getRequestDispatcher("/register.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/register.jsp").forward(request, response);
    }




    private boolean RegisterUser(String studentNumber, String name, String surname, String email, String phone, String password) throws SQLException {
        String sql_prep = "INSERT INTO users (studentnumber, firstname, surname, email, phone, password) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = getConnection()) {
            PreparedStatement sqlPrepareStatement = conn.prepareStatement(sql_prep);
            sqlPrepareStatement.setString(1, studentNumber);
            sqlPrepareStatement.setString(2, name);
            sqlPrepareStatement.setString(3, surname);
            sqlPrepareStatement.setString(4, email);
            sqlPrepareStatement.setString(5, phone);
            sqlPrepareStatement.setString(6, GenerateHashedPassword(password));
            sqlPrepareStatement.execute();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }



}
