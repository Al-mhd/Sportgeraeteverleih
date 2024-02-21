package de.uni.servlet;

import de.uni.database.dao.ProductDao;
import de.uni.database.entity.ProductEntity;
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
        String productImageName = (String) req.getSession().getAttribute("uploaded");
//        System.out.println("req.getSession().getAttribute(\"name\") = " + req.getSession().getAttribute("name"));
        ProductEntity productEntity = new ProductEntity(
                productName,
                productPrice,
                productImageName,
                String.valueOf(req.getSession().getAttribute("name")));
        ProductDao productDao = new ProductDao();
        productDao.insertProduct(productEntity);

        resp.sendRedirect("index.jsp");
    }
}
