<%@ page import="de.uni.database.dao.ProductDao" %>
<%@ page import="java.util.List" %>
<%@ page import="de.uni.database.entity.ProductEntity" %>
<%@ page import="de.uni.database.dao.MessageDao" %>
<%@ page import="de.uni.database.entity.MessageEntity" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="de.uni.database.entity.UserEntity" %>
<%@ page import="de.uni.database.dao.UserDao" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Profile</title>
    <%@include file="includes/header.jsp" %>
</head>
<body>
<%@include file="includes/checkLogin.jsp" %>
<%@include file="includes/navbar.jsp" %>

<%--
    TODO:
        - get this user from database by name
        - show user data in placeholders
        - by clicking on submit, update user data in database by name
--%>
<%
    String this_userName = (String) session.getAttribute("name");
    UserDao userDao = new UserDao();
    UserEntity user = userDao.getUserByName(this_userName);
%>

<div class="container">
    <div class="card w-50 mx-auto my-5">
        <div class="card-header text-center">Benutzer Daten</div>
        <div class="card-body">
            <form action="register" method="post">
                <div class="form-group">
                    <label>Username</label>
                    <input required type="text" name="username" class="form-control" placeholder="<%=user.getUsername()%>">
                </div>
                <div class="form-group">
                    <label>Password</label>
                    <input required type="password" name="password" class="form-control" placeholder="new password">
                </div>
                <div class="form-group">
                    <label>Confirm password</label>
                    <input required type="password" name="rpassword" class="form-control" placeholder="password again">
                </div>
                <% if (session.getAttribute("alert") != null) {
                    if (session.getAttribute("alert").equals("true")) {
                %>
                <script>alert("Password must be correct"); </script>
                <%
                        }
                    }
                %>
                <div class="text-center">
                    <button type="submit" class="btn btn-primary">Benutzerdaten aktualisieren</button>
                </div>
                <br/>
            </form>
        </div>
    </div>
</div>

<br/>
<div class="container">
    <div class="card-header my-3">All Products</div>
    <div class="row">
        <%
            ProductDao productDao = new ProductDao();
            List<ProductEntity> products = productDao.getAllProducts();
            if (!products.isEmpty()) {
                for (ProductEntity productEntity : products) {
                    if (!productEntity.getOwner_name().equals(session.getAttribute("name"))) { continue; }
        %>
        <div class="col-md-3 my-3">
            <div class="card w-100">
                <img class="card-img-top" src="images/<%=productEntity.getImage()%>"
                     alt="Card image cap">
                <div class="card-body">
                    <h5 class="card-title"><%=productEntity.getName()%>
                    </h5>
                    <h6 class="price">Preis: <%=productEntity.getPreis()%> $
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
<%-- messages --%>
<%
    MessageDao messageDao = new MessageDao();
    List<MessageEntity> msgs = messageDao.getAllMessagesForOneUser(this_userName);
//    UserDao userDao = new UserDao();
//    ArrayList<UserEntity> users = (ArrayList<UserEntity>) userDao.getAllUser();
    if (msgs == null) {
%>
<div class="container my-3">
    <div class="d-flex py-3">
        <h3>There is no messages</h3>
    </div>
</div>
<br/>

<%
} else {
    List<String> users = new ArrayList<>();
    for (MessageEntity messageEntity : msgs) {
        if (messageEntity.getReceiver_name().equals(this_userName)) {
            if (!users.contains(messageEntity.getSender_name())) {
                users.add(messageEntity.getSender_name());
            }
        } else {
            if (!users.contains(messageEntity.getReceiver_name())) {
                users.add(messageEntity.getReceiver_name());
            }
        }
    }
%>

<div class="container my-3">
    <table class="table table-light">
        <thead>
        <tr>
            <th scope="col">user name</th>
            <%--            <th scope="col">show offers</th>--%>
            <th scope="col">send message</th>
            <%--            <th scope="col">delete user</th>--%>
        </tr>
        </thead>
        <tbody>
        <%
            for (String userName : users) {
        %>
        <tr>
            <td>
                <%=userName%>
            </td>
            <td>
                <a class="btn btn-dark" href="message-to-user?owner_name=<%=userName%>"><svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-chat-right-text-fill" viewBox="0 0 16 16"><path d="M16 2a2 2 0 0 0-2-2H2a2 2 0 0 0-2 2v8a2 2 0 0 0 2 2h9.586a1 1 0 0 1 .707.293l2.853 2.853a.5.5 0 0 0 .854-.353zM3.5 3h9a.5.5 0 0 1 0 1h-9a.5.5 0 0 1 0-1m0 2.5h9a.5.5 0 0 1 0 1h-9a.5.5 0 0 1 0-1m0 2.5h5a.5.5 0 0 1 0 1h-5a.5.5 0 0 1 0-1"></path></svg></a>
            </td>
            <%--            <td>--%>
            <%--                <a href="remove-user?pk=<%=userEntity.getPk()%>&user_name=<%=userEntity.getUsername()%>" class="btn btn-sm btn-danger">remove</a>--%>
            <%--            </td>--%>
        </tr>
        <%
                }
            }
        %>
        </tbody>
    </table>
</div>

<%@include file="includes/footer.jsp" %>
</body>
</html>
