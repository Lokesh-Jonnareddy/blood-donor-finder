package com.blooddonor.servlets;

import com.blooddonor.dao.UserDAO;
import com.blooddonor.model.User;


import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String phone = request.getParameter("phone");
        String city = request.getParameter("city");
        String area = request.getParameter("area");
        String bloodGroup = request.getParameter("bloodGroup");
        String role = request.getParameter("role");

        UserDAO dao = new UserDAO();

        // Check if email already exists
        if (dao.emailExists(email)) {
            request.setAttribute("error", "Email already registered! Please login.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        // Create user object
        User user = new User();
        user.setName(name);
        user.setEmail(email);
        user.setPassword(password);
        user.setPhone(phone);
        user.setCity(city);
        user.setArea(area);
        user.setBloodGroup(bloodGroup);
        user.setRole(role);

        boolean success = dao.registerUser(user);

        if (success) {
            response.sendRedirect("login.jsp?msg=Registration Successful! Please Login.");
        } else {
            request.setAttribute("error", "Registration failed! Please try again.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }
}