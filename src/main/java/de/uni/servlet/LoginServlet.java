package de.uni.servlet;

import de.uni.database.dao.UserDao;
import de.uni.database.entity.UserEntity;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet(name = "loginServlet", value = "/login")
public class LoginServlet extends HttpServlet {
	private UserDao userDao;

	public void init() {
		userDao = new UserDao();
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
		response.setContentType("text/html");
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		UserEntity userEntity = new UserEntity(username, password);
		userEntity = userDao.checkIfBenutzerExists(userEntity);
		HttpSession session = request.getSession();
		if (userEntity != null) {
			// redirect to success
			session.setAttribute("name", userEntity.getUsername());
			session.setAttribute("role", userEntity.getRole());
			response.sendRedirect("login/success.jsp");
		} else {
			// redirect to failed
			response.sendRedirect("login/failed.jsp");
		}
	}

	public void destroy() {
	}
}