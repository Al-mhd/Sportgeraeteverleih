package de.uni.chat.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "messageToUser", urlPatterns = "/message-to-user")
public class ChatServletMessage extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        String ownerName = request.getParameter("owner_name");
        request.getSession().setAttribute("owner_name", ownerName);

//        response.sendRedirect("chat.jsp");
        response.sendRedirect("chat2.jsp");
    }
}
