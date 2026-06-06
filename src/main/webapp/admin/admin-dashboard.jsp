<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.blooddonor.model.User, com.blooddonor.model.BloodRequest, com.blooddonor.dao.RequestDAO, com.blooddonor.dao.UserDAO, java.util.List" %>
<%
    User loggedUser = (User) session.getAttribute("loggedUser");
    if (loggedUser == null || !loggedUser.getRole().equals("admin")) {
        response.sendRedirect("../login.jsp");
        return;
    }
    RequestDAO requestDAO = new RequestDAO();
    UserDAO userDAO = new UserDAO();
    List<BloodRequest> allRequests = requestDAO.getAllOpenRequests();
    List<User> allDonors = userDAO.getAllDonors();
%>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard - Blood Donor Finder</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: Arial, sans-serif; background: #f7f7f7; }
        .navbar {
            background: #922b21; color: white;
            padding: 15px 30px;
            display: flex; justify-content: space-between; align-items: center;
        }
        .navbar h1 { font-size: 22px; }
        .navbar a { color: white; text-decoration: none; margin-left: 20px; }

        /* Stats */
        .stats {
            display: flex; gap: 20px; margin: 20px; flex-wrap: wrap;
        }
        .stat-card {
            background: white; padding: 20px; border-radius: 10px;
            box-shadow: 0 0 8px rgba(0,0,0,0.1); flex: 1;
            text-align: center; min-width: 150px;
        }
        .stat-card h3 { color: #777; font-size: 13px; margin-bottom: 8px; }
        .stat-card p { font-size: 28px; font-weight: bold; color: #922b21; }

        /* Section */
        .section {
            background: white; margin: 20px; padding: 25px 30px;
            border-radius: 10px; box-shadow: 0 0 8px rgba(0,0,0,0.1);
        }
        .section h3 { color: #922b21; margin-bottom: 20px; font-size: 18px; }

        /* Table */
        table { width: 100%; border-collapse: collapse; }
        th { background: #922b21; color: white; padding: 10px; text-align: left; font-size: 14px; }
        td { padding: 10px; border-bottom: 1px solid #eee; font-size: 14px; }
        tr:hover { background: #fdf2f2; }

        /* Urgency */
        .urgency {
            padding: 4px 10px; border-radius: 12px;
            font-size: 12px; font-weight: bold;
        }
        .Critical { background: #ffebee; color: red; border: 1px solid red; }
        .Normal { background: #fff8e1; color: orange; border: 1px solid orange; }
        .Planned { background: #e8f5e9; color: green; border: 1px solid green; }

        /* Badge */
        .badge {
            background: #f39c12; color: white;
            padding: 3px 10px; border-radius: 10px; font-size: 12px;
        }
        .available { color: green; font-weight: bold; }
        .unavailable { color: red; font-weight: bold; }
    </style>
</head>
<body>

<!-- Navbar -->
<div class="navbar">
    <h1>🩸 Blood Donor Finder — Admin Panel</h1>
    <div>
        <a href="../logout">Logout</a>
    </div>
</div>

<!-- Stats -->
<div class="stats">
    <div class="stat-card">
        <h3>TOTAL DONORS</h3>
        <p><%= allDonors.size() %></p>
    </div>
    <div class="stat-card">
        <h3>OPEN REQUESTS</h3>
        <p><%= allRequests.size() %></p>
    </div>
    <div class="stat-card">
        <h3>CRITICAL REQUESTS</h3>
        <p style="color:red;">
            <%
                long critical = allRequests.stream()
                    .filter(r -> r.getUrgencyLevel().equals("Critical"))
                    .count();
                out.print(critical);
            %>
        </p>
    </div>
</div>

<!-- All Blood Requests -->
<div class="section">
    <h3>🆘 All Open Blood Requests</h3>
    <% if(allRequests.isEmpty()) { %>
        <p style="color:#999; text-align:center;">No open requests found.</p>
    <% } else { %>
    <table>
        <tr>
            <th>#</th>
            <th>Blood Group</th>
            <th>Urgency</th>
            <th>Hospital</th>
            <th>Area</th>
            <th>Status</th>
            <th>Posted On</th>
        </tr>
        <% for(BloodRequest req : allRequests) { %>
        <tr>
            <td><%= req.getRequestId() %></td>
            <td><strong><%= req.getBloodGroup() %></strong></td>
            <td>
                <span class="urgency <%= req.getUrgencyLevel() %>">
                    <%= req.getUrgencyLevel().equals("Critical") ? "🔴" : req.getUrgencyLevel().equals("Normal") ? "🟡" : "🟢" %>
                    <%= req.getUrgencyLevel() %>
                </span>
            </td>
            <td><%= req.getHospitalName() %></td>
            <td><%= req.getArea() %></td>
            <td><%= req.getStatus() %></td>
            <td><%= req.getCreatedDate() %></td>
        </tr>
        <% } %>
    </table>
    <% } %>
</div>

<!-- All Donors -->
<div class="section">
    <h3>👥 All Registered Donors</h3>
    <% if(allDonors.isEmpty()) { %>
        <p style="color:#999; text-align:center;">No donors registered yet.</p>
    <% } else { %>
    <table>
        <tr>
            <th>#</th>
            <th>Name</th>
            <th>Blood Group</th>
            <th>Area</th>
            <th>Phone</th>
            <th>Donations</th>
            <th>Badge</th>
            <th>Available</th>
        </tr>
        <% for(User donor : allDonors) { %>
        <tr>
            <td><%= donor.getUserId() %></td>
            <td><%= donor.getName() %></td>
            <td><strong><%= donor.getBloodGroup() %></strong></td>
            <td><%= donor.getArea() %></td>
            <td><%= donor.getPhone() %></td>
            <td><%= donor.getDonationCount() %></td>
            <td><span class="badge"><%= donor.getBadge() %></span></td>
            <td>
                <%
                    boolean avail = com.blooddonor.util.BadgeUtil.canDonateAgain(donor.getLastDonatedDate());
                %>
                <span class="<%= avail ? "available" : "unavailable" %>">
                    <%= avail ? "✅ Yes" : "⏳ No" %>
                </span>
            </td>
        </tr>
        <% } %>
    </table>
    <% } %>
</div>

</body>
</html>