<%@ page import="de.uni.database.dao.ProductDao" %>
<%@ page import="java.util.List" %>
<%@ page import="de.uni.database.entity.ProductEntity" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Offers</title>
    <%@include file="includes/header.jsp" %>
</head>
<body>
<%@include file="includes/checkLogin.jsp" %>
<%@include file="includes/navbar.jsp" %>

<%--
    - IMPORTANT: create image using yEd for presentation
    - IMPORTANT: (bug: absolut path of database files)
    2 - IMPORTANT: send and receive image in messaging
    - UML diagram (offer types, entities & repos & dao)
    - organize project structure
    3 - in geraeteausleihe.jsp: ausgeliehen Geräte müssen nicht mehr in Produkte gezeigt werden.
    - html-css for messages must be improved
    5 - edit offer from owner (add edit-button, show edit offer page)
    - logging system
    - english to german
    - bcrypt
    - create databases if not exists (bug: absolut path in app-db-path-contants)

    x - Admin role:
            x - delete user
            x - delete offer
            x - send message to all users
            x - show all users with options (delete user, ...)
    x - sequence diagram for login
    x - messages button in navebar to show all messages with other.users
    x - use bootstrap in:
        x - success.jsp
        x - logout.jsp
    x - user profile
        x - show all this.user informaition
        x - edit all this.user informaition
        x - show all offers from this.user
        x - show all messages with other.users
--%>

<br/>
<div class="container">
    <div class="card-header my-3">All Products</div>
    <div class="row">
        <%
            ProductDao productDao = new ProductDao();
            List<ProductEntity> products = productDao.getAllProducts();
            if (!products.isEmpty()) {
                for (ProductEntity productEntity : products) {
        %>
        <div class="col-md-3 my-3">
            <div class="card w-100">
                <img class="card-img-top" src="images/<%=productEntity.getImage()%>" alt="Card image cap">
                <div class="card-body">
                    <h5 class="card-title"><%=productEntity.getName()%>
                    </h5>
                    <h6 class="price">Preis: <%=productEntity.getPreis()%> Euro
                    </h6>
                    <h6 class="price">Besitzer: <%=productEntity.getOwner_name()%>
                    </h6>
                    <div class="mt-3 d-flex justify-content-between">
                        <%
                            if (session.getAttribute("role") != null && session.getAttribute("role").equals(ADMIN_ROLE_NAME)) { // admin
                        %>
                                <%-- message to user --%>
                                <a class="btn btn-dark" href="message-to-user?owner_name=<%=productEntity.getOwner_name()%>"><svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-chat-right-text-fill" viewBox="0 0 16 16"><path d="M16 2a2 2 0 0 0-2-2H2a2 2 0 0 0-2 2v8a2 2 0 0 0 2 2h9.586a1 1 0 0 1 .707.293l2.853 2.853a.5.5 0 0 0 .854-.353zM3.5 3h9a.5.5 0 0 1 0 1h-9a.5.5 0 0 1 0-1m0 2.5h9a.5.5 0 0 1 0 1h-9a.5.5 0 0 1 0-1m0 2.5h5a.5.5 0 0 1 0 1h-5a.5.5 0 0 1 0-1"></path></svg></a>
                                <%-- delete offer --%>
                                <a class="btn btn-primary" href="deleteOffer?pk=<%=productEntity.getPk()%>"><svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-trash3-fill" viewBox="0 0 16 16"><path d="M11 1.5v1h3.5a.5.5 0 0 1 0 1h-.538l-.853 10.66A2 2 0 0 1 11.115 16h-6.23a2 2 0 0 1-1.994-1.84L2.038 3.5H1.5a.5.5 0 0 1 0-1H5v-1A1.5 1.5 0 0 1 6.5 0h3A1.5 1.5 0 0 1 11 1.5m-5 0v1h4v-1a.5.5 0 0 0-.5-.5h-3a.5.5 0 0 0-.5.5M4.5 5.029l.5 8.5a.5.5 0 1 0 .998-.06l-.5-8.5a.5.5 0 1 0-.998.06m6.53-.528a.5.5 0 0 0-.528.47l-.5 8.5a.5.5 0 0 0 .998.058l.5-8.5a.5.5 0 0 0-.47-.528M8 4.5a.5.5 0 0 0-.5.5v8.5a.5.5 0 0 0 1 0V5a.5.5 0 0 0-.5-.5"></path></svg></a>
                        <%
                            } else if (!productEntity.getOwner_name().equals(session.getAttribute("name"))) { // Angebot von anderem Benutzer
                        %>
                                <%-- Add to Cart --%>
                                <a class="btn btn-dark" href="add-to-cart?pk=<%=productEntity.getPk()%>"><svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-cart-plus" viewBox="0 0 16 16"><path d="M9 5.5a.5.5 0 0 0-1 0V7H6.5a.5.5 0 0 0 0 1H8v1.5a.5.5 0 0 0 1 0V8h1.5a.5.5 0 0 0 0-1H9z"></path><path d="M.5 1a.5.5 0 0 0 0 1h1.11l.401 1.607 1.498 7.985A.5.5 0 0 0 4 12h1a2 2 0 1 0 0 4 2 2 0 0 0 0-4h7a2 2 0 1 0 0 4 2 2 0 0 0 0-4h1a.5.5 0 0 0 .491-.408l1.5-8A.5.5 0 0 0 14.5 3H2.89l-.405-1.621A.5.5 0 0 0 2 1zm3.915 10L3.102 4h10.796l-1.313 7zM6 14a1 1 0 1 1-2 0 1 1 0 0 1 2 0m7 0a1 1 0 1 1-2 0 1 1 0 0 1 2 0"></path></svg></a>
                                <%-- message to user --%>
                                <a class="btn btn-dark" href="message-to-user?owner_name=<%=productEntity.getOwner_name()%>"><svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-chat-right-text-fill" viewBox="0 0 16 16"><path d="M16 2a2 2 0 0 0-2-2H2a2 2 0 0 0-2 2v8a2 2 0 0 0 2 2h9.586a1 1 0 0 1 .707.293l2.853 2.853a.5.5 0 0 0 .854-.353zM3.5 3h9a.5.5 0 0 1 0 1h-9a.5.5 0 0 1 0-1m0 2.5h9a.5.5 0 0 1 0 1h-9a.5.5 0 0 1 0-1m0 2.5h5a.5.5 0 0 1 0 1h-5a.5.5 0 0 1 0-1"></path></svg></a>
                        <%
                            } else { // Angebot von this Benutzer
                        %>
                                <%-- delete offer--%>
                                <a class="btn btn-primary" href="deleteOffer?pk=<%=productEntity.getPk()%>"><svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-trash3-fill" viewBox="0 0 16 16"><path d="M11 1.5v1h3.5a.5.5 0 0 1 0 1h-.538l-.853 10.66A2 2 0 0 1 11.115 16h-6.23a2 2 0 0 1-1.994-1.84L2.038 3.5H1.5a.5.5 0 0 1 0-1H5v-1A1.5 1.5 0 0 1 6.5 0h3A1.5 1.5 0 0 1 11 1.5m-5 0v1h4v-1a.5.5 0 0 0-.5-.5h-3a.5.5 0 0 0-.5.5M4.5 5.029l.5 8.5a.5.5 0 1 0 .998-.06l-.5-8.5a.5.5 0 1 0-.998.06m6.53-.528a.5.5 0 0 0-.528.47l-.5 8.5a.5.5 0 0 0 .998.058l.5-8.5a.5.5 0 0 0-.47-.528M8 4.5a.5.5 0 0 0-.5.5v8.5a.5.5 0 0 0 1 0V5a.5.5 0 0 0-.5-.5"></path></svg></a>
                        <%
							}
                        %>
                    </div>
                </div>
            </div>
        </div>
        <%
                }
            } else {
                out.println("There is no proucts");
            }
        %>

    </div>
</div>

<br/>
<%@include file="includes/footer.jsp" %>
</body>
</html>
