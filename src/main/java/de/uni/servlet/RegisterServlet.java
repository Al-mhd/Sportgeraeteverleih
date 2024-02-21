package de.uni.servlet;

import de.uni.database.dao.UserDao;
import de.uni.database.entity.UserEntity;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet(name = "registerServlet", value = "/register")
public class RegisterServlet extends HttpServlet {
    private UserDao userDao;

    public void init() {
        userDao = new UserDao();
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String rpassword = request.getParameter("rpassword");
        System.out.println("log: Register new user started (username="+username+", password="+password+")");
        HttpSession session = request.getSession();
        request.getSession().setAttribute("alert", "false");
        response.setContentType("text/html");
        UserEntity userEntity = new UserEntity(username, password);
        userEntity = userDao.checkIfBenutzerExists(userEntity);
        if (userEntity != null) {
            if (!password.equals(rpassword)) {
                request.getSession().setAttribute("alert", "true");
            } else {
                userDao.updateUser(userEntity);
                session.setAttribute("name", userEntity.getUsername());
                session.setAttribute("role", userEntity.getRole());
            }
            response.sendRedirect("profile.jsp");
        } else {
            if (!password.equals(rpassword) || username.isEmpty() || password.isEmpty()) {
                request.getSession().setAttribute("alert", "true");
                response.sendRedirect("register.jsp");
            } else {
                userEntity = new UserEntity(username, password);
                userDao.insertBenutzer(userEntity);
                request.getSession().setAttribute("name", userEntity.getUsername());
                session.setAttribute("role", "user");
                response.sendRedirect("login/success.jsp");
            }
        }
    }
}
