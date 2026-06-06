<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Register - Blood Donor Finder</title>
    <style>
        body { font-family: Arial, sans-serif; background: #f7f7f7; }
        .container { width: 450px; margin: 50px auto; background: white; padding: 30px; border-radius: 10px; box-shadow: 0 0 10px rgba(0,0,0,0.1); }
        h2 { text-align: center; color: #c0392b; }
        input, select { width: 100%; padding: 10px; margin: 8px 0; border: 1px solid #ddd; border-radius: 5px; box-sizing: border-box; }
        button { width: 100%; padding: 12px; background: #c0392b; color: white; border: none; border-radius: 5px; font-size: 16px; cursor: pointer; }
        button:hover { background: #a93226; }
        .error { color: red; text-align: center; }
        .login-link { text-align: center; margin-top: 15px; }
    </style>
</head>
<body>
<div class="container">
    <h2>🩸 Blood Donor Finder</h2>
    <h3 style="text-align:center;">Create Account</h3>

    <% if(request.getAttribute("error") != null) { %>
        <p class="error"><%= request.getAttribute("error") %></p>
    <% } %>

    <form action="register" method="post">
        <input type="text" name="name" placeholder="Full Name" required />
        <input type="email" name="email" placeholder="Email Address" required />
        <input type="password" name="password" placeholder="Password" required />
        <input type="text" name="phone" placeholder="Phone Number" required />
        <input type="text" name="city" placeholder="City" value="Chennai" required />
        <input type="text" name="area" placeholder="Area (e.g. T.Nagar, Anna Nagar)" required />

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

        <select name="role" required>
            <option value="">-- Register As --</option>
            <option value="donor">Donor</option>
            <option value="recipient">Recipient</option>
        </select>

        <button type="submit">Register</button>
    </form>

    <div class="login-link">
        Already have an account? <a href="login.jsp">Login here</a>
    </div>
</div>
</body>
</html>