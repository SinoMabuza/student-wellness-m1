package com.bc.util;

import org.mindrot.jbcrypt.BCrypt;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import static com.bc.util.DatabaseUtil.getConnection;

public class BasicUtilities {

    public static boolean SetUserSession(HttpServletRequest request, String studentNumber, String email) {
        if (CheckIfUserExists(studentNumber, email)) {
            HttpSession session = request.getSession();
            session.setAttribute("email", email);
            return true;
        } else {
            return false;
        }
    }

    public static boolean DeleteUserSession(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
            return true;
        }
        return false;
    }

    public static boolean FindAndCompareUser(String email, String password) throws SQLException {
        Connection conn = null;
        PreparedStatement sqlPrepareStatement = null;
        ResultSet rs = null;
        try {
            conn = DatabaseUtil.getConnection();
            String sql_string = "SELECT password FROM users WHERE email = ?";
            sqlPrepareStatement = conn.prepareStatement(sql_string);
            sqlPrepareStatement.setString(1, email);
            rs = sqlPrepareStatement.executeQuery();

            if (rs.next()) {
                String hashedPassword = rs.getString("password");
                return BCrypt.checkpw(password, hashedPassword);
            } else {
                return false; // User not found
            }
        } finally {
            if (rs != null) rs.close();
            if (sqlPrepareStatement != null) sqlPrepareStatement.close();
            if (conn != null) conn.close();
        }
    }

    public static boolean CheckIfUserExists(String studentNumber, String email) {
        String sql_string  = "SELECT EXISTS(SELECT 1 FROM users WHERE studentnumber = ? OR email = ?)";
        try (Connection conn = getConnection(); PreparedStatement sqlPrepareStatement = conn.prepareStatement(sql_string)) {
            sqlPrepareStatement.setString(1, studentNumber);
            sqlPrepareStatement.setString(2, email);
            ResultSet rs = sqlPrepareStatement.executeQuery();
            if (rs.next()) {
                return rs.getBoolean(1);
            }
            return false;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public static String GenerateHashedPassword(String password) {
        return BCrypt.hashpw(password, BCrypt.gensalt());
    }
}
