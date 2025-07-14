package com.bc.Servlets;

import java.io.IOException;
import java.sql.*;

import com.bc.util.DatabaseUtil;
import org.mindrot.jbcrypt.BCrypt;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try (Connection conn = DatabaseUtil.getConnection()) {
            String sql = "SELECT name, password FROM users WHERE email = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                String dbHashedPassword = rs.getString("password");
                String name = rs.getString("name");

                if (BCrypt.checkpw(password, dbHashedPassword)) {
                    // ✅ Login successful
                    HttpSession session = request.getSession();
                    session.setAttribute("userName", name);
                    session.setAttribute("email", email);

                    response.sendRedirect("dashboard.jsp");  // ✅ Redirects to dashboard


                } else {
                    // ❌ Incorrect password
                    request.setAttribute("error", "Invalid email or password.");
                    request.setAttribute("email", email); // retain entered email
                    request.getRequestDispatcher("/login.jsp").forward(request, response);
                }

            } else {
                // ❌ No such user
                request.setAttribute("error", "Account not found.");
                request.setAttribute("email", email);
                request.getRequestDispatcher("/login.jsp").forward(request, response);
            }

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Login failed due to a server error.");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        // ✅ Redirect to login page respecting the context path
        response.sendRedirect(request.getContextPath() + "/login.jsp");
    }
}
