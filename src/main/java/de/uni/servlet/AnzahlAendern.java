package de.uni.servlet;

import de.uni.Cart;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

@WebServlet("/quantity-inc-dec")
public class AnzahlAendern extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
		throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		try (PrintWriter out = response.getWriter()) {
			String action = request.getParameter("action");
			int pk = Integer.parseInt(request.getParameter("pk"));
			ArrayList<Cart> cart_list = (ArrayList<Cart>) request.getSession().getAttribute("cart-list");

			if (action != null && pk >= 1) {
				if (action.equals("inc")) {
					for (Cart c : cart_list) {
						if (c.getProductPk() == pk) {
							c.setAnzahl(c.getAnzahl() + 1);
						}
					}
				}
				if (action.equals("dec")) {
					for (Cart c : cart_list) {
						if (c.getProductPk() == pk) {
							if (c.getAnzahl() <= 1) {
								c.setAnzahl(0);
//								cart_list.remove(c);
							} else {
								c.setAnzahl(c.getAnzahl() - 1);
							}
							break;
						}
					}
				}
			}
			response.sendRedirect("cart.jsp");
		}
	}
}
