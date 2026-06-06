package com.blooddonor.servlets;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.blooddonor.dao.UserDAO;
import com.blooddonor.model.User;

@WebServlet("/searchDonor")
public class SearchDonorServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String bloodGroup = request.getParameter("bloodGroup");
        String area = request.getParameter("area");

        UserDAO dao = new UserDAO();
        List<User> donors = dao.searchDonors(bloodGroup, area);

        request.setAttribute("donors", donors);
        request.setAttribute("bloodGroup", bloodGroup);
        request.setAttribute("area", area);

        request.getRequestDispatcher("search-donor.jsp").forward(request, response);
    }
}