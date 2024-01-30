package de.uni.servlet;

import de.uni.database.entity.BenutzerEntity;
import de.uni.database.repository.BenutzerRepo;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "registerServlet", value = "/register")
public class RegisterServlet extends HttpServlet {
	private BenutzerRepo benutzerRepo;

	public void init() {
		benutzerRepo = new BenutzerRepo();
	}

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
		request.getSession().setAttribute("alert", "false");
		response.setContentType("text/html");
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String rpassword = request.getParameter("rpassword");
		if (!password.equals(rpassword)){
			request.getSession().setAttribute("alert", "true");
			response.sendRedirect("register.jsp");
		} else {
			BenutzerEntity benutzerEntity = new BenutzerEntity(username, password);
			benutzerRepo.insertBenutzer(benutzerEntity);
			request.getSession().setAttribute("name", benutzerEntity.getUsername());
			response.sendRedirect("success.jsp");
		}
	}
}
