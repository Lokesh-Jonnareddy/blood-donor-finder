package com.blooddonor.servlets;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.blooddonor.dao.RequestDAO;
import com.blooddonor.model.BloodRequest;
import com.blooddonor.model.User;

@WebServlet("/bloodRequest")
public class BloodRequestServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User loggedUser = (User) session.getAttribute("loggedUser");

        if (loggedUser == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String bloodGroup = request.getParameter("bloodGroup");
        String urgencyLevel = request.getParameter("urgencyLevel");
        String hospitalName = request.getParameter("hospitalName");
        String area = request.getParameter("area");
        String city = request.getParameter("city");
        String message = request.getParameter("message");

        BloodRequest req = new BloodRequest();
        req.setRecipientId(loggedUser.getUserId());
        req.setBloodGroup(bloodGroup);
        req.setUrgencyLevel(urgencyLevel);
        req.setHospitalName(hospitalName);
        req.setArea(area);
        req.setCity(city);
        req.setMessage(message);

        RequestDAO dao = new RequestDAO();
        boolean success = dao.createRequest(req);

        if (success) {
            response.sendRedirect("donor-profile.jsp?msg=Blood request posted successfully!");
        } else {
            request.setAttribute("error", "Failed to post request. Try again!");
            request.getRequestDispatcher("blood-request.jsp").forward(request, response);
        }
    }
}