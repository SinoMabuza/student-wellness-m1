package com.bc.util;

import java.sql.*;

public class DatabaseUtil {
    private static final String URL = "jdbc:postgresql://localhost:5432/postgres";
    private static final String USER = "postgres";
    private static final String PASSWORD = "azra";

    public static Connection getConnection() throws SQLException {
        try {
            Class.forName("org.postgresql.Driver");
        } catch (ClassNotFoundException e) {
            throw new SQLException("PostgreSQL JDBC Driver not found.", e);
        }
        Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
        conn.setSchema("wellnessdb"); // Replace with your schema
        return conn;
    }

    public static void printAllTables() throws SQLException {
        try (Connection conn = getConnection()) {
            DatabaseMetaData metaData = conn.getMetaData();
            ResultSet tables = metaData.getTables(null, null, "%", new String[] {"TABLE"});
            while (tables.next()) {
                System.out.println(tables.getString("TABLE_NAME"));
            }
        }
    }
}
