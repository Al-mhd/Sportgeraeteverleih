package de.uni.servlet;

import de.uni.Cart;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.ArrayList;

@WebServlet("/remove-from-cart")
public class CartServletRemove extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        int pk = Integer.parseInt(request.getParameter("pk"));
        ArrayList<Cart> cart_list = (ArrayList<Cart>) request.getSession().getAttribute("cart-list");
        if (cart_list.size() == 1) {
            cart_list.clear();
        } else {
            for (Cart c : cart_list) {
                if (c.getProductPk() == pk) {
                    cart_list.remove(c);
                }
            }
        }
        response.sendRedirect("cart.jsp");
    }
}
