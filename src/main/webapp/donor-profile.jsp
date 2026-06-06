<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.blooddonor.model.User, com.blooddonor.model.BloodRequest, com.blooddonor.dao.RequestDAO, java.util.List" %>
<%
    User loggedUser = (User) session.getAttribute("loggedUser");
    if (loggedUser == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    RequestDAO dao = new RequestDAO();
    List<BloodRequest> myRequests = dao.getRequestsByUser(loggedUser.getUserId());
%>
<!DOCTYPE html>
<html>
<head>
    <title>My Profile - Blood Donor Finder</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: Arial, sans-serif; background: #f7f7f7; }
        .navbar {
            background: #c0392b; color: white;
            padding: 15px 30px;
            display: flex; justify-content: space-between; align-items: center;
        }
        .navbar h1 { font-size: 22px; }
        .navbar a { color: white; text-decoration: none; margin-left: 20px; }

        /* Profile Card */
        .profile-card {
            background: white; margin: 20px; padding: 25px 30px;
            border-radius: 10px; box-shadow: 0 0 8px rgba(0,0,0,0.1);
            display: flex; justify-content: space-between; align-items: center;
        }
        .profile-card h2 { color: #c0392b; margin-bottom: 10px; }
        .profile-card p { color: #666; margin-top: 6px; font-size: 15px; }
        .badge-big {
            background: #f39c12; color: white;
            padding: 12px 22px; border-radius: 25px;
            font-size: 18px; font-weight: bold; text-align: center;
        }
        .badge-big p { color: white; font-size: 12px; margin-top: 4px; }

        /* Stats */
        .stats {
            display: flex; gap: 20px; margin: 0 20px 20px 20px; flex-wrap: wrap;
        }
        .stat-card {
            background: white; padding: 20px; border-radius: 10px;
            box-shadow: 0 0 8px rgba(0,0,0,0.1); flex: 1;
            text-align: center; min-width: 150px;
        }
        .stat-card h3 { color: #777; font-size: 13px; margin-bottom: 8px; }
        .stat-card p { font-size: 26px; font-weight: bold; color: #c0392b; }

        /* Requests */
        .section {
            background: white; margin: 20px; padding: 25px 30px;
            border-radius: 10px; box-shadow: 0 0 8px rgba(0,0,0,0.1);
        }
        .section h3 { color: #c0392b; margin-bottom: 20px; font-size: 18px; }

        .request-card {
            border: 1px solid #eee; border-radius: 8px;
            padding: 15px; margin-bottom: 12px;
            display: flex; justify-content: space-between; align-items: center;
        }
        .request-info h4 { color: #333; margin-bottom: 5px; }
        .request-info p { color: #777; font-size: 13px; margin-top: 3px; }

        /* Urgency badges */
        .urgency {
            padding: 5px 14px; border-radius: 15px;
            font-size: 13px; font-weight: bold; text-align: center;
        }
        .Critical { background: #ffebee; color: red; border: 1px solid red; }
        .Normal { background: #fff8e1; color: orange; border: 1px solid orange; }
        .Planned { background: #e8f5e9; color: green; border: 1px solid green; }

        /* Status */
        .status {
            padding: 4px 10px; border-radius: 10px;
            font-size: 12px; margin-top: 6px; display: inline-block;
        }
        .Open { background: #e3f2fd; color: #1565c0; }
        .Fulfilled { background: #e8f5e9; color: green; }
        .Closed { background: #fafafa; color: #999; }

        .success { color: green; text-align: center;
            background: #e8f5e9; padding: 10px;
            border-radius: 5px; margin-bottom: 15px; }
        .no-requests { text-align: center; color: #999; padding: 20px; }

        /* Can donate info */
        .donate-status {
            padding: 10px 20px; border-radius: 8px; margin-top: 10px;
            font-weight: bold;
        }
        .can { background: #e8f5e9; color: green; }
        .cannot { background: #ffebee; color: red; }
    </style>
</head>
<body>

<!-- Navbar -->
<div class="navbar">
    <h1>🩸 Blood Donor Finder</h1>
    <div>
        <a href="dashboard.jsp">Dashboard</a>
        <a href="search-donor.jsp">Find Donor</a>
        <a href="blood-request.jsp">Request Blood</a>
        <a href="logout">Logout</a>
    </div>
</div>

<!-- Profile Card -->
<div class="profile-card">
    <div>
        <h2>👤 <%= loggedUser.getName() %></h2>
        <p>📧 <%= loggedUser.getEmail() %></p>
        <p>📞 <%= loggedUser.getPhone() %></p>
        <p>📍 <%= loggedUser.getArea() %>, <%= loggedUser.getCity() %></p>
        <p>🩸 Blood Group: <strong><%= loggedUser.getBloodGroup() %></strong></p>
        <p>👥 Role: <%= loggedUser.getRole() %></p>

        <%
            boolean canDonate = com.blooddonor.util.BadgeUtil.canDonateAgain(loggedUser.getLastDonatedDate());
        %>
        <div class="donate-status <%= canDonate ? "can" : "cannot" %>">
            <%= canDonate ? "✅ You are eligible to donate!" : "⏳ Please wait 90 days before donating again" %>
        </div>
    </div>
    <div>
        <div class="badge-big">
            <%= loggedUser.getBadge() %>
            <p>Your Badge</p>
        </div>
    </div>
</div>

<!-- Stats -->
<div class="stats">
    <div class="stat-card">
        <h3>TOTAL DONATIONS</h3>
        <p><%= loggedUser.getDonationCount() %></p>
    </div>
    <div class="stat-card">
        <h3>BLOOD GROUP</h3>
        <p><%= loggedUser.getBloodGroup() %></p>
    </div>
    <div class="stat-card">
        <h3>LAST DONATED</h3>
        <p style="font-size:16px;">
            <%= loggedUser.getLastDonatedDate() != null ? loggedUser.getLastDonatedDate() : "Never" %>
        </p>
    </div>
    <div class="stat-card">
        <h3>MY REQUESTS</h3>
        <p><%= myRequests.size() %></p>
    </div>
</div>

<!-- My Blood Requests -->
<div class="section">
    <h3>🆘 My Blood Requests</h3>

    <% if(request.getParameter("msg") != null) { %>
        <p class="success">✅ <%= request.getParameter("msg") %></p>
    <% } %>

    <% if(myRequests.isEmpty()) { %>
        <div class="no-requests">
            <p>You haven't posted any blood requests yet.</p>
            <a href="blood-request.jsp" style="color:#c0392b;">Post a Request</a>
        </div>
    <% } else { %>
        <% for(BloodRequest req : myRequests) { %>
        <div class="request-card">
            <div class="request-info">
                <h4>🩸 <%= req.getBloodGroup() %> — <%= req.getHospitalName() %></h4>
                <p>📍 <%= req.getArea() %></p>
                <p>🕐 <%= req.getCreatedDate() %></p>
                <span class="status <%= req.getStatus() %>"><%= req.getStatus() %></span>
            </div>
            <div style="text-align:center;">
                <div class="urgency <%= req.getUrgencyLevel() %>">
                    <%= req.getUrgencyLevel().equals("Critical") ? "🔴" : req.getUrgencyLevel().equals("Normal") ? "🟡" : "🟢" %>
                    <%= req.getUrgencyLevel() %>
                </div>
            </div>
        </div>
        <% } %>
    <% } %>
</div>

</body>
</html>