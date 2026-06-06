package com.blooddonor.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

    private static final String URL = "jdbc:postgresql://localhost:5432/blood_donor_finder";
    private static final String USERNAME = "postgres";
    private static final String PASSWORD = "loki";

    public static Connection getConnection() throws SQLException {
        try {
            Class.forName("org.postgresql.Driver");
            Connection con = DriverManager.getConnection(URL, USERNAME, PASSWORD);
            System.out.println("✅ Database Connected Successfully!");
            return con;
        } catch (ClassNotFoundException e) {
            throw new SQLException("PostgreSQL Driver not found!", e);
        }
    }
}