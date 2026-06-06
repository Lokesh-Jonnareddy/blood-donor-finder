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
    <title>Request Blood - Blood Donor Finder</title>
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

        .container {
            width: 550px; margin: 40px auto; background: white;
            padding: 30px; border-radius: 10px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        h2 { color: #c0392b; margin-bottom: 20px; }
        label { font-weight: bold; color: #555; display: block; margin-top: 15px; margin-bottom: 5px; }
        input, select, textarea {
            width: 100%; padding: 10px; border: 1px solid #ddd;
            border-radius: 5px; font-size: 14px;
        }
        textarea { height: 80px; resize: vertical; }

        /* Urgency color highlight */
        .urgency-critical { border: 2px solid red !important; }
        .urgency-normal { border: 2px solid orange !important; }
        .urgency-planned { border: 2px solid green !important; }

        .urgency-info {
            display: flex; gap: 15px; margin-top: 8px; flex-wrap: wrap;
        }
        .urgency-tag {
            padding: 5px 12px; border-radius: 15px;
            font-size: 12px; font-weight: bold;
        }
        .critical-tag { background: #ffebee; color: red; border: 1px solid red; }
        .normal-tag { background: #fff8e1; color: orange; border: 1px solid orange; }
        .planned-tag { background: #e8f5e9; color: green; border: 1px solid green; }

        .submit-btn {
            width: 100%; padding: 12px; background: #c0392b;
            color: white; border: none; border-radius: 5px;
            font-size: 16px; cursor: pointer; margin-top: 20px;
        }
        .submit-btn:hover { background: #a93226; }
        .error { color: red; text-align: center; margin-bottom: 10px; }
    </style>
</head>
<body>

<div class="navbar">
    <h1>🩸 Blood Donor Finder</h1>
    <div>
        <a href="dashboard.jsp">Dashboard</a>
        <a href="search-donor.jsp">Find Donor</a>
        <a href="logout">Logout</a>
    </div>
</div>

<div class="container">
    <h2>🆘 Post a Blood Request</h2>

    <% if(request.getAttribute("error") != null) { %>
        <p class="error"><%= request.getAttribute("error") %></p>
    <% } %>

    <form action="bloodRequest" method="post">

        <label>Blood Group Needed</label>
        <select name="bloodGroup" required>
            <option value="">-- Select Blood Group --</option>
            <option value="A+">A+</option>
            <option value="A-">A-</option>
            <option value="B+">B+</option>
            <option value="B-">B-</option>
            <option value="O+">O+</option>
            <option value="O-">O-</option>
            <option value="AB+">AB+</option>
            <option value="AB-">AB-</option>
        </select>

        <label>Urgency Level</label>
        <select name="urgencyLevel" required id="urgencySelect">
            <option value="">-- Select Urgency --</option>
            <option value="Critical">🔴 Critical — Needed immediately</option>
            <option value="Normal">🟡 Normal — Needed within a few days</option>
            <option value="Planned">🟢 Planned — Scheduled surgery/procedure</option>
        </select>
        <div class="urgency-info">
            <span class="urgency-tag critical-tag">🔴 Critical</span>
            <span class="urgency-tag normal-tag">🟡 Normal</span>
            <span class="urgency-tag planned-tag">🟢 Planned</span>
        </div>

        <label>Hospital Name</label>
        <input type="text" name="hospitalName" placeholder="e.g. Apollo Hospital, Chennai" required />

        <label>Area</label>
        <input type="text" name="area" placeholder="e.g. T.Nagar, Anna Nagar" required />

        <label>City</label>
        <input type="text" name="city" placeholder="Chennai" value="Chennai" required />

        <label>Additional Message (Optional)</label>
        <textarea name="message" placeholder="Any additional details about the patient or request..."></textarea>

        <button type="submit" class="submit-btn">Post Blood Request</button>
    </form>
</div>

</body>
</html>