<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.blooddonor.model.User" %>
<%
    User loggedUser = (User) session.getAttribute("loggedUser");
    if (loggedUser == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Dashboard - Blood Donor Finder</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: Arial, sans-serif; background: #f7f7f7; }

        /* Navbar */
        .navbar {
            background: #c0392b; color: white;
            padding: 15px 30px;
            display: flex; justify-content: space-between; align-items: center;
        }
        .navbar h1 { font-size: 22px; }
        .navbar a { color: white; text-decoration: none; margin-left: 20px; font-size: 15px; }
        .navbar a:hover { text-decoration: underline; }

        /* Welcome Banner */
        .welcome {
            background: white; margin: 20px; padding: 20px 30px;
            border-radius: 10px; box-shadow: 0 0 8px rgba(0,0,0,0.1);
            display: flex; justify-content: space-between; align-items: center;
        }
        .welcome h2 { color: #c0392b; }
        .badge {
            background: #f39c12; color: white;
            padding: 8px 16px; border-radius: 20px; font-weight: bold;
        }

        /* Info Cards */
        .cards {
            display: flex; gap: 20px; margin: 20px; flex-wrap: wrap;
        }
        .card {
            background: white; padding: 20px; border-radius: 10px;
            box-shadow: 0 0 8px rgba(0,0,0,0.1); flex: 1; min-width: 200px;
            text-align: center;
        }
        .card h3 { color: #777; font-size: 14px; margin-bottom: 10px; }
        .card p { font-size: 28px; font-weight: bold; color: #c0392b; }

        /* Action Buttons */
        .actions {
            display: flex; gap: 20px; margin: 20px; flex-wrap: wrap;
        }
        .action-btn {
            flex: 1; min-width: 200px; padding: 20px;
            background: white; border-radius: 10px;
            box-shadow: 0 0 8px rgba(0,0,0,0.1);
            text-align: center; text-decoration: none; color: #333;
            transition: transform 0.2s;
        }
        .action-btn:hover { transform: scale(1.03); background: #fdf2f2; }
        .action-btn .icon { font-size: 36px; }
        .action-btn h3 { margin-top: 10px; color: #c0392b; }
        .action-btn p { font-size: 13px; color: #777; margin-top: 5px; }

        /* User Info */
        .user-info {
            background: white; margin: 20px; padding: 20px 30px;
            border-radius: 10px; box-shadow: 0 0 8px rgba(0,0,0,0.1);
        }
        .user-info h3 { color: #c0392b; margin-bottom: 15px; }
        .info-row { display: flex; gap: 10px; margin-bottom: 10px; }
        .info-label { font-weight: bold; width: 150px; color: #555; }
    </style>
</head>
<body>

<!-- Navbar -->
<div class="navbar">
    <h1>🩸 Blood Donor Finder</h1>
    <div>
        <a href="search-donor.jsp">Find Donor</a>
        <a href="blood-request.jsp">Request Blood</a>
        <a href="donor-profile.jsp">My Profile</a>
        <a href="logout">Logout</a>
    </div>
</div>

<!-- Welcome Banner -->
<div class="welcome">
    <div>
        <h2>Welcome, <%= loggedUser.getName() %>! 👋</h2>
        <p style="color:#777; margin-top:5px;">
            <%= loggedUser.getBloodGroup() %> &nbsp;|&nbsp;
            <%= loggedUser.getArea() %>, <%= loggedUser.getCity() %>
        </p>
    </div>
    <div class="badge"><%= loggedUser.getBadge() %></div>
</div>

<!-- Info Cards -->
<div class="cards">
    <div class="card">
        <h3>BLOOD GROUP</h3>
        <p><%= loggedUser.getBloodGroup() %></p>
    </div>
    <div class="card">
        <h3>TOTAL DONATIONS</h3>
        <p><%= loggedUser.getDonationCount() %></p>
    </div>
    <div class="card">
        <h3>LAST DONATED</h3>
        <p style="font-size:18px;">
            <%= loggedUser.getLastDonatedDate() != null ? loggedUser.getLastDonatedDate() : "Never" %>
        </p>
    </div>
    <div class="card">
        <h3>YOUR BADGE</h3>
        <p style="font-size:18px;"><%= loggedUser.getBadge() %></p>
    </div>
</div>

<!-- Action Buttons -->
<div class="actions">
    <a href="search-donor.jsp" class="action-btn">
        <div class="icon">🔍</div>
        <h3>Find a Donor</h3>
        <p>Search donors by blood group and area</p>
    </a>
    <a href="blood-request.jsp" class="action-btn">
        <div class="icon">🆘</div>
        <h3>Request Blood</h3>
        <p>Post an urgent or planned blood request</p>
    </a>
    <a href="donor-profile.jsp" class="action-btn">
        <div class="icon">👤</div>
        <h3>My Profile</h3>
        <p>View your donation history and badge</p>
    </a>
</div>

<!-- User Info -->
<div class="user-info">
    <h3>Your Details</h3>
    <div class="info-row">
        <span class="info-label">Name:</span>
        <span><%= loggedUser.getName() %></span>
    </div>
    <div class="info-row">
        <span class="info-label">Email:</span>
        <span><%= loggedUser.getEmail() %></span>
    </div>
    <div class="info-row">
        <span class="info-label">Phone:</span>
        <span><%= loggedUser.getPhone() %></span>
    </div>
    <div class="info-row">
        <span class="info-label">Area:</span>
        <span><%= loggedUser.getArea() %>, <%= loggedUser.getCity() %></span>
    </div>
    <div class="info-row">
        <span class="info-label">Role:</span>
        <span><%= loggedUser.getRole() %></span>
    </div>
</div>

</body>
</html>