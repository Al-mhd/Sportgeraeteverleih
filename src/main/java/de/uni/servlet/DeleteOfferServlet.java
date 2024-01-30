package de.uni.servlet;

import de.uni.database.repository.ProductRepo;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "deleteOffer", value = "/deleteOffer")
public class DeleteOfferServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Integer pk = Integer.valueOf(req.getParameter("pk"));
        ProductRepo productRepo = new ProductRepo();
        productRepo.deleteProductByPk(pk);

        resp.sendRedirect("index.jsp");
    }
}
