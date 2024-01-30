package de.uni.servlet;

import de.uni.Cart;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.ArrayList;

@WebServlet(name = "addToCartServlet", urlPatterns = "/add-to-cart")
public class CartServletAdd extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");

		int pk = Integer.parseInt(request.getParameter("pk"));
		Cart cart = new Cart();
		cart.setProductPk(pk);
		cart.setAnzahl(1);

		HttpSession session = request.getSession();
		ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");

		ArrayList<Cart> cartList = new ArrayList<>();
		if (cart_list == null || cart_list.isEmpty()) {
			cartList.add(cart);
			session.setAttribute("cart-list", cartList);
		} else {
			cartList = cart_list;

			boolean exist = false;
			for (Cart c : cart_list) {
				if (c.getProductPk() == pk) {
					exist = true;
					c.setAnzahl(c.getAnzahl() + 1);
				}
			}
			if (!exist) {
				cartList.add(cart);
			}
		}
		response.sendRedirect("cart.jsp");
	}
}
