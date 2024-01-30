package de.uni.servlet;

import de.uni.database.entity.BenutzerEntity;
import de.uni.database.repository.BenutzerRepo;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet(name = "loginServlet", value = "/login")
public class LoginServlet extends HttpServlet {
	private BenutzerRepo benutzerRepo;

	public void init() {
		benutzerRepo = new BenutzerRepo();
	}

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
		response.setContentType("text/html");
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		BenutzerEntity benutzerEntity = new BenutzerEntity(username, password);
		HttpSession session = request.getSession();
//		PrintWriter out = response.getWriter();
//		out.println("<html><body>");
//		out.println("<h1> username = " + username + "</h1>");
//		out.println("<h1> password = " + password + "</h1>");

		boolean exists = benutzerRepo.checkIfBenutzerExists(benutzerEntity);
		if (exists) {
			// redirect to success
//			out.println("<h1>Login success</h1>");
			session.setAttribute("name", benutzerEntity.getUsername());
			response.sendRedirect("success.jsp");
		} else {
			// redirect to failed
			response.sendRedirect("failed.jsp");
//			out.println("<h1>Login failed</h1>");
		}
		// Hello

//		out.println("</body></html>");
	}

	public void destroy() {
	}
}