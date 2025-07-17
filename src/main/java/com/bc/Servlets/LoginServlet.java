package com.bc.Servlets;

import java.io.IOException;
import java.sql.*;

import com.bc.util.DatabaseUtil;
import org.mindrot.jbcrypt.BCrypt;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import static com.bc.util.BasicUtilities.*;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");
        try {
            if(FindAndCompareUser(email, password)) {
                // If user is found and password matches, set session attributes
                SetUserSession(request, "0", email);
                response.sendRedirect(request.getContextPath() + "/DashboardServlet");
                return;
            } else {
                // If authentication fails, redirect to login page with error message
                request.setAttribute("errorMessage", "Invalid email or password.");
                request.getRequestDispatcher("/login.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
    }



}
