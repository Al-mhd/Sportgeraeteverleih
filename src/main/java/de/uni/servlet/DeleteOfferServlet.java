package de.uni.servlet;

import de.uni.database.dao.ProductDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "deleteOffer", value = "/deleteOffer")
public class DeleteOfferServlet extends HttpServlet {
	private ProductDao productDao;

	public void init() {
		productDao = new ProductDao();
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		Integer pk = Integer.valueOf(req.getParameter("pk"));
		productDao.deleteProductByPk(pk);

		resp.sendRedirect("index.jsp");
	}
}
