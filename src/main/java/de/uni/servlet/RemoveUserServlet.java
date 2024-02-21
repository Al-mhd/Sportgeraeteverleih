package de.uni.servlet;

import de.uni.database.dao.ProductDao;
import de.uni.database.dao.UserDao;
import de.uni.database.entity.ProductEntity;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "removeUserServlet", value = "/remove-user")
public class RemoveUserServlet extends HttpServlet {
	private UserDao userDao;
	private ProductDao productDao;

	public void init() {
		userDao = new UserDao();
		productDao = new ProductDao();
	}

	public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		Integer pk = Integer.valueOf(req.getParameter("pk"));
		userDao.deleteUserByPk(pk);

		String userName = req.getParameter("user_name");
		List<ProductEntity> products = productDao.getAllProducts();
		for (ProductEntity productEntity : products) {
			if (productEntity.getOwner_name().equals(userName)) {
				productDao.deleteProductByPk(productEntity.getPk());
			}
		}

		resp.sendRedirect("users.jsp");
	}
}
