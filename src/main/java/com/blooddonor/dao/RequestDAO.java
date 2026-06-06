package com.blooddonor.dao;

import com.blooddonor.model.BloodRequest;
import com.blooddonor.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class RequestDAO {

    // ✅ CREATE new blood request
    public boolean createRequest(BloodRequest req) {
        String sql = "INSERT INTO blood_requests (recipient_id, blood_group, urgency_level, "
                   + "hospital_name, area, city, message) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, req.getRecipientId());
            ps.setString(2, req.getBloodGroup());
            ps.setString(3, req.getUrgencyLevel());
            ps.setString(4, req.getHospitalName());
            ps.setString(5, req.getArea());
            ps.setString(6, req.getCity());
            ps.setString(7, req.getMessage());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            System.out.println("❌ Create Request Error: " + e.getMessage());
            return false;
        }
    }

    // ✅ GET ALL OPEN requests
    public List<BloodRequest> getAllOpenRequests() {
        List<BloodRequest> list = new ArrayList<>();
        String sql = "SELECT * FROM blood_requests WHERE status = 'Open' "
                   + "ORDER BY CASE urgency_level "
                   + "WHEN 'Critical' THEN 1 "
                   + "WHEN 'Normal' THEN 2 "
                   + "WHEN 'Planned' THEN 3 END, created_date DESC";

        try (Connection con = DBConnection.getConnection();
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery(sql)) {

            while (rs.next()) {
                BloodRequest req = new BloodRequest();
                req.setRequestId(rs.getInt("request_id"));
                req.setRecipientId(rs.getInt("recipient_id"));
                req.setBloodGroup(rs.getString("blood_group"));
                req.setUrgencyLevel(rs.getString("urgency_level"));
                req.setHospitalName(rs.getString("hospital_name"));
                req.setArea(rs.getString("area"));
                req.setCity(rs.getString("city"));
                req.setMessage(rs.getString("message"));
                req.setStatus(rs.getString("status"));
                req.setCreatedDate(rs.getTimestamp("created_date"));
                list.add(req);
            }

        } catch (SQLException e) {
            System.out.println("❌ Get Requests Error: " + e.getMessage());
        }
        return list;
    }

    // ✅ GET requests by user
    public List<BloodRequest> getRequestsByUser(int userId) {
        List<BloodRequest> list = new ArrayList<>();
        String sql = "SELECT * FROM blood_requests WHERE recipient_id = ? ORDER BY created_date DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                BloodRequest req = new BloodRequest();
                req.setRequestId(rs.getInt("request_id"));
                req.setBloodGroup(rs.getString("blood_group"));
                req.setUrgencyLevel(rs.getString("urgency_level"));
                req.setHospitalName(rs.getString("hospital_name"));
                req.setArea(rs.getString("area"));
                req.setStatus(rs.getString("status"));
                req.setCreatedDate(rs.getTimestamp("created_date"));
                list.add(req);
            }

        } catch (SQLException e) {
            System.out.println("❌ Get User Requests Error: " + e.getMessage());
        }
        return list;
    }
}