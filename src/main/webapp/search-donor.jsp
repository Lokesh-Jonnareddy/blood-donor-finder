<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.blooddonor.model.User, java.util.List" %>
<%
    User loggedUser = (User) session.getAttribute("loggedUser");
    if (loggedUser == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    List<User> donors = (List<User>) request.getAttribute("donors");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Find Donor - Blood Donor Finder</title>
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

        .search-box {
            background: white; margin: 20px; padding: 25px 30px;
            border-radius: 10px; box-shadow: 0 0 8px rgba(0,0,0,0.1);
        }
        .search-box h2 { color: #c0392b; margin-bottom: 20px; }
        .search-form { display: flex; gap: 15px; flex-wrap: wrap; align-items: flex-end; }
        select, input { padding: 10px; border: 1px solid #ddd; border-radius: 5px; font-size: 14px; }
        .search-btn {
            padding: 10px 25px; background: #c0392b; color: white;
            border: none; border-radius: 5px; cursor: pointer; font-size: 15px;
        }
        .search-btn:hover { background: #a93226; }

        .results { margin: 20px; }
        .results h3 { color: #555; margin-bottom: 15px; }

        .donor-card {
            background: white; padding: 20px; border-radius: 10px;
            box-shadow: 0 0 8px rgba(0,0,0,0.1); margin-bottom: 15px;
            display: flex; justify-content: space-between; align-items: center;
        }
        .donor-info h3 { color: #c0392b; margin-bottom: 5px; }
        .donor-info p { color: #777; font-size: 14px; margin-top: 3px; }
        .blood-group {
            font-size: 32px; font-weight: bold; color: #c0392b;
            margin: 0 20px;
        }
        .badge {
            background: #f39c12; color: white;
            padding: 5px 12px; border-radius: 15px; font-size: 13px;
        }
        .can-donate { color: green; font-weight: bold; }
        .cannot-donate { color: red; font-weight: bold; }
        .no-results {
            text-align: center; padding: 40px;
            background: white; border-radius: 10px;
            box-shadow: 0 0 8px rgba(0,0,0,0.1);
            color: #777;
        }
    </style>
</head>
<body>

<!-- Navbar -->
<div class="navbar">
    <h1>🩸 Blood Donor Finder</h1>
    <div>
        <a href="dashboard.jsp">Dashboard</a>
        <a href="blood-request.jsp">Request Blood</a>
        <a href="logout">Logout</a>
    </div>
</div>

<!-- Search Box -->
<div class="search-box">
    <h2>🔍 Find a Blood Donor</h2>
    <form action="searchDonor" method="get" class="search-form">
        <div>
            <label style="display:block; margin-bottom:5px; font-weight:bold;">Blood Group</label>
            <select name="bloodGroup" required>
                <option value="">-- Select --</option>
                <option value="A+">A+</option>
                <option value="A-">A-</option>
                <option value="B+">B+</option>
                <option value="B-">B-</option>
                <option value="O+">O+</option>
                <option value="O-">O-</option>
                <option value="AB+">AB+</option>
                <option value="AB-">AB-</option>
            </select>
        </div>
        <div>
            <label style="display:block; margin-bottom:5px; font-weight:bold;">Area (Optional)</label>
            <input type="text" name="area" placeholder="e.g. Anna Nagar, T.Nagar" style="width:220px;" />
        </div>
        <button type="submit" class="search-btn">Search Donors</button>
    </form>
</div>

<!-- Results -->
<div class="results">
<%
    if (donors != null) {
        if (donors.isEmpty()) {
%>
        <div class="no-results">
            <h3>😔 No donors found</h3>
            <p>Try searching with a different blood group or area</p>
        </div>
<%
        } else {
%>
        <h3>Found <%= donors.size() %> donor(s)</h3>
<%
            for (User donor : donors) {
                boolean canDonate = com.blooddonor.util.BadgeUtil.canDonateAgain(donor.getLastDonatedDate());
%>
        <div class="donor-card">
            <div class="donor-info">
                <h3><%= donor.getName() %></h3>
                <p>📍 <%= donor.getArea() %>, <%= donor.getCity() %></p>
                <p>📞 <%= donor.getPhone() %></p>
                <p>🏅 Donations: <%= donor.getDonationCount() %></p>
                <p>Last Donated: <%= donor.getLastDonatedDate() != null ? donor.getLastDonatedDate() : "Never" %></p>
            </div>
            <div style="text-align:center;">
                <div class="blood-group"><%= donor.getBloodGroup() %></div>
                <div class="badge"><%= donor.getBadge() %></div>
                <p style="margin-top:8px;" class="<%= canDonate ? "can-donate" : "cannot-donate" %>">
                    <%= canDonate ? "✅ Available" : "⏳ Not Available (90-day gap)" %>
                </p>
            </div>
        </div>
<%
            }
        }
    }
%>
</div>

</body>
</html>