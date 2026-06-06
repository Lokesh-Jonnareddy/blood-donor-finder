package com.blooddonor.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.blooddonor.model.User;
import com.blooddonor.util.BadgeUtil;
import com.blooddonor.util.DBConnection;

public class UserDAO {

    // ✅ REGISTER - Insert new user into database
    public boolean registerUser(User user) {
        String sql = "INSERT INTO users (name, email, password, phone, city, area, blood_group, role) "
                   + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, user.getName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPassword());
            ps.setString(4, user.getPhone());
            ps.setString(5, user.getCity());
            ps.setString(6, user.getArea());
            ps.setString(7, user.getBloodGroup());
            ps.setString(8, user.getRole());

            int rows = ps.executeUpdate();
            return rows > 0;

        } catch (SQLException e) {
            System.out.println("❌ Register Error: " + e.getMessage());
            return false;
        }
    }

    // ✅ LOGIN - Check email and password
    public User loginUser(String email, String password) {
        String sql = "SELECT * FROM users WHERE email = ? AND password = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, email);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                User user = new User();
                user.setUserId(rs.getInt("user_id"));
                user.setName(rs.getString("name"));
                user.setEmail(rs.getString("email"));
                user.setPhone(rs.getString("phone"));
                user.setCity(rs.getString("city"));
                user.setArea(rs.getString("area"));
                user.setBloodGroup(rs.getString("blood_group"));
                user.setRole(rs.getString("role"));
                user.setBadge(rs.getString("badge"));
                user.setDonationCount(rs.getInt("donation_count"));
                user.setLastDonatedDate(rs.getDate("last_donated_date"));
                return user;
            }

        } catch (SQLException e) {
            System.out.println("❌ Login Error: " + e.getMessage());
        }
        return null;
    }

    // ✅ CHECK EMAIL EXISTS - Prevent duplicate registration
    public boolean emailExists(String email) {
        String sql = "SELECT user_id FROM users WHERE email = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            return rs.next();

        } catch (SQLException e) {
            System.out.println("❌ Email Check Error: " + e.getMessage());
            return false;
        }
    }

    // ✅ GET USER BY ID
    public User getUserById(int userId) {
        String sql = "SELECT * FROM users WHERE user_id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                User user = new User();
                user.setUserId(rs.getInt("user_id"));
                user.setName(rs.getString("name"));
                user.setEmail(rs.getString("email"));
                user.setPhone(rs.getString("phone"));
                user.setCity(rs.getString("city"));
                user.setArea(rs.getString("area"));
                user.setBloodGroup(rs.getString("blood_group"));
                user.setRole(rs.getString("role"));
                user.setBadge(rs.getString("badge"));
                user.setDonationCount(rs.getInt("donation_count"));
                user.setLastDonatedDate(rs.getDate("last_donated_date"));
                return user;
            }

        } catch (SQLException e) {
            System.out.println("❌ Get User Error: " + e.getMessage());
        }
        return null;
    }

    // ✅ UPDATE BADGE after donation
    public void updateBadgeAndCount(int userId, int newCount) {
        String newBadge = BadgeUtil.getBadge(newCount);
        String sql = "UPDATE users SET donation_count = ?, badge = ?, last_donated_date = CURRENT_DATE "
                   + "WHERE user_id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, newCount);
            ps.setString(2, newBadge);
            ps.setInt(3, userId);
            ps.executeUpdate();
            System.out.println("✅ Badge updated to: " + newBadge);

        } catch (SQLException e) {
            System.out.println("❌ Badge Update Error: " + e.getMessage());
        }
    }
 // ✅ SEARCH DONORS by blood group and area
    public List<User> searchDonors(String bloodGroup, String area) {
        List<User> donors = new ArrayList<>();

        String sql = "SELECT * FROM users WHERE role = 'donor' AND blood_group = ?";

        if (area != null && !area.trim().isEmpty()) {
            sql += " AND LOWER(area) LIKE LOWER(?)";
        }

        sql += " ORDER BY donation_count DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, bloodGroup);

            if (area != null && !area.trim().isEmpty()) {
                ps.setString(2, "%" + area + "%");
            }

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                User user = new User();
                user.setUserId(rs.getInt("user_id"));
                user.setName(rs.getString("name"));
                user.setPhone(rs.getString("phone"));
                user.setArea(rs.getString("area"));
                user.setCity(rs.getString("city"));
                user.setBloodGroup(rs.getString("blood_group"));
                user.setBadge(rs.getString("badge"));
                user.setDonationCount(rs.getInt("donation_count"));
                user.setLastDonatedDate(rs.getDate("last_donated_date"));
                donors.add(user);
            }

        } catch (SQLException e) {
            System.out.println("❌ Search Error: " + e.getMessage());
        }
        return donors;
    }
 // ✅ GET ALL DONORS for admin
    public List<User> getAllDonors() {
        List<User> donors = new ArrayList<>();
        String sql = "SELECT * FROM users WHERE role = 'donor' ORDER BY donation_count DESC";

        try (Connection con = DBConnection.getConnection();
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery(sql)) {

            while (rs.next()) {
                User user = new User();
                user.setUserId(rs.getInt("user_id"));
                user.setName(rs.getString("name"));
                user.setPhone(rs.getString("phone"));
                user.setArea(rs.getString("area"));
                user.setCity(rs.getString("city"));
                user.setBloodGroup(rs.getString("blood_group"));
                user.setBadge(rs.getString("badge"));
                user.setDonationCount(rs.getInt("donation_count"));
                user.setLastDonatedDate(rs.getDate("last_donated_date"));
                donors.add(user);
            }

        } catch (SQLException e) {
            System.out.println("❌ Get All Donors Error: " + e.getMessage());
        }
        return donors;
    }
}