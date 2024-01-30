package de.uni.servlet;

import de.uni.database.entity.ProductEntity;
import de.uni.database.repository.ProductRepo;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "addOffer", value = "/addOffer")
public class AddOfferServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String productName = req.getParameter("offerName");
        double productPrice = Double.parseDouble(req.getParameter("preis"));
        String productImageName = req.getParameter("img");
        System.out.println("req.getSession().getAttribute(\"name\") = " + req.getSession().getAttribute("name"));
        ProductEntity productEntity = new ProductEntity(
                productName,
                productPrice,
                productImageName,
                String.valueOf(req.getSession().getAttribute("name")));
        ProductRepo productRepo = new ProductRepo();
        productRepo.insertProduct(productEntity);

        resp.sendRedirect("index.jsp");
    }
}
