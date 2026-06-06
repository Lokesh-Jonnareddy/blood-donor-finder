<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Login - Blood Donor Finder</title>
    <style>
        body { font-family: Arial, sans-serif; background: #f7f7f7; }
        .container { width: 400px; margin: 80px auto; background: white; padding: 30px; border-radius: 10px; box-shadow: 0 0 10px rgba(0,0,0,0.1); }
        h2 { text-align: center; color: #c0392b; }
        input { width: 100%; padding: 10px; margin: 8px 0; border: 1px solid #ddd; border-radius: 5px; box-sizing: border-box; }
        button { width: 100%; padding: 12px; background: #c0392b; color: white; border: none; border-radius: 5px; font-size: 16px; cursor: pointer; }
        button:hover { background: #a93226; }
        .error { color: red; text-align: center; }
        .success { color: green; text-align: center; }
        .register-link { text-align: center; margin-top: 15px; }
    </style>
</head>
<body>
<div class="container">
    <h2>🩸 Blood Donor Finder</h2>
    <h3 style="text-align:center;">Login</h3>

    <% if(request.getAttribute("error") != null) { %>
        <p class="error"><%= request.getAttribute("error") %></p>
    <% } %>

    <% if(request.getParameter("msg") != null) { %>
        <p class="success"><%= request.getParameter("msg") %></p>
    <% } %>

    <form action="login" method="post">
        <input type="email" name="email" placeholder="Email Address" required />
        <input type="password" name="password" placeholder="Password" required />
        <button type="submit">Login</button>
    </form>

    <div class="register-link">
        New user? <a href="register.jsp">Register here</a>
    </div>
</div>
</body>
</html>