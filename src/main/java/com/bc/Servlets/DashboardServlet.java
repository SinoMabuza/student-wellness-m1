package com.bc.Servlets;

import org.mindrot.jbcrypt.BCrypt;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import static com.bc.util.BasicUtilities.*;
import static com.bc.util.DatabaseUtil.getConnection;
import static com.bc.util.DatabaseUtil.printAllTables;

@WebServlet("/DashboardServlet")
public class DashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String email = session.getAttribute("email").toString();
        // Check if user is logged in
        if (email == null) {
            request.setAttribute("errorMessage", "You must be logged in to access the dashboard.");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }

        // Fetch user details from the database
        Connection conn = null;
        PreparedStatement sqlPrepareStatement = null;
        ResultSet rs = null;

        try {
            conn = getConnection();
            String sql_string = "SELECT firstname, surname, studentNumber FROM users WHERE email = ?";
            sqlPrepareStatement = conn.prepareStatement(sql_string);
            sqlPrepareStatement.setString(1, email);
            rs = sqlPrepareStatement.executeQuery();

            if (rs.next()) {
                request.setAttribute("name", rs.getString("firstname"));
                request.setAttribute("surname", rs.getString("surname"));
                request.setAttribute("studentNumber", rs.getString("studentnumber"));
                request.setAttribute("email", email);
            } else {
                request.setAttribute("errorMessage", "User not found.");
                response.sendRedirect(request.getContextPath() + "/LoginServlet");
            }
        } catch (SQLException e) {
            request.setAttribute("errorMessage", "Database error: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/LoginServlet");
        } finally {
            if (rs != null) try {
                rs.close();
            } catch (SQLException e) {
            }
            if (sqlPrepareStatement != null) try {
                sqlPrepareStatement.close();
            } catch (SQLException e) {
            }
            if (conn != null) try {
                conn.close();
            } catch (SQLException e) {
            }
        }
        // Forward to the dashboard JSP
        request.getRequestDispatcher("/dashboard.jsp").forward(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        DeleteUserSession(request);
        request.setAttribute("errorMessage", "You have been logged out successfully.");
        response.sendRedirect(request.getContextPath() + "/LoginServlet");
    }

}
