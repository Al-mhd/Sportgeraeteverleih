<%@ page import="de.uni.Cart" %>
<%@ page import="de.uni.database.repository.ProductRepo" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="de.uni.database.entity.ProductEntity" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.LinkedHashMap" %>
<%@ page import="java.util.TreeMap" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Cart</title>
    <%@include file="includes/header.jsp" %>

    <style type="text/css">

        .table tbody td {
            vertical-align: middle;
        }

        .btn-incre, .btn-decre {
            box-shadow: none;
            font-size: 25px;
        }
    </style>
</head>
<body>
<%@include file="includes/checkLogin.jsp" %>
<%@include file="includes/navbar.jsp" %>
<%
    DecimalFormat dcf = new DecimalFormat("#.##");
    request.setAttribute("dcf", dcf);
    ProductRepo productRepo = new ProductRepo();
    ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");
    double total_price = 0;
    if (cart_list == null) {
//        out.println("There is no products in cart");
%>
<div class="container my-3">
    <div class="d-flex py-3">
        <h3>There is no products in cart</h3>
    </div>
</div>
<br/>

<%
} else {
    Map<ProductEntity, Integer> products = productRepo.getCartProducts(cart_list);
    // TODO: sort products using productEntity.getPk()
%>
<div class="container my-3">

    <table class="table table-light">
        <thead>
        <tr>
            <th scope="col">Name</th>
            <th scope="col">Price</th>
            <%--            <th scope="col">count</th>--%>
            <th scope="col">Cancel</th>
        </tr>
        </thead>
        <tbody>
        <%
            if (products != null) {
                for (Map.Entry<ProductEntity, Integer> product : products.entrySet()) {
                    total_price += product.getValue() * product.getKey().getPreis();
        %>
        <tr>
            <td><%=product.getKey().getName()%>
            </td>
            <td><%= dcf.format(product.getKey().getPreis())%>
            </td>
            <td>
                <form action="order-now" method="post" class="form-inline">
                    <input type="hidden" name="id" value="<%= product.getKey().getPk()%>" class="form-input">
                    <div class="form-group d-flex justify-content-between">
                        <a class="btn bnt-sm btn-incre"
                           href="quantity-inc-dec?action=inc&pk=<%=product.getKey().getPk()%>">
                            <%--                            <i class="fas fa-plus-square"></i>--%>
                            <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor"
                                 class="bi bi-plus-circle" viewBox="0 0 16 16">
                                <path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14m0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16"/>
                                <path d="M8 4a.5.5 0 0 1 .5.5v3h3a.5.5 0 0 1 0 1h-3v3a.5.5 0 0 1-1 0v-3h-3a.5.5 0 0 1 0-1h3v-3A.5.5 0 0 1 8 4"/>
                            </svg>
                        </a>
                        <input type="text" name="quantity" class="form-control" value="<%=product.getValue()%>"
                               readonly>
                        <a class="btn btn-sm btn-decre"
                           href="quantity-inc-dec?action=dec&pk=<%=product.getKey().getPk()%>">
                            <%--                            <i class="fas fa-minus-square"></i>--%>
                            <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor"
                                 class="bi bi-dash-circle" viewBox="0 0 16 16">
                                <path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14m0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16"/>
                                <path d="M4 8a.5.5 0 0 1 .5-.5h7a.5.5 0 0 1 0 1h-7A.5.5 0 0 1 4 8"/>
                            </svg>
                        </a>
                    </div>
                    <%--                    <button type="submit" class="btn btn-primary btn-sm">Buy</button>--%>
                </form>
            </td>
            <td><a href="remove-from-cart?pk=<%=product.getKey().getPk() %>" class="btn btn-sm btn-danger">Remove</a>
            </td>
        </tr>
        <%
                }
            }
        %>
        </tbody>
    </table>
    <div class="d-flex py-3">
        <h3>Total Price:  <%= dcf.format(total_price)%> $</h3>
        <a class="mx-3 btn btn-primary" href="cart-check-out">Check Out</a>
    </div>
</div>
<%
    }
%>
<%@include file="includes/footer.jsp" %>
</body>
</html>
<%--        // TODO https://www.youtube.com/watch?v=Iut0z6AQzZI&list=PLF7Fmglq6SPD9jVwDt-mbYiaewF-pPYZS&index=7--%>
