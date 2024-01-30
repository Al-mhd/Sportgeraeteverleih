<%--
  Created by IntelliJ IDEA.
  User: m
  Date: 19.01.24
  Time: 19:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Add offer</title>
    <%@include file="includes/header.jsp" %>
</head>
<body>
<%@include file="includes/checkLogin.jsp" %>
<%@include file="includes/navbar.jsp" %>
<div class="card w-50 mx-auto my-5">
    <div class="card-header text-center">Create offer</div>
    <div class="card-body">
        <%--            <form action="${pageContext.request.contextPath}/login" method="get">--%>
        <form action="addOffer" method="post">
            <div class="form-group">
                <label>Name</label>
                <input type="text" name="offerName" class="form-control" placeholder="offer name">
            </div>
            <div class="form-group">
                <label>Price</label>
                <input type="text" name="preis" class="form-control" placeholder="price">
            </div>
            <div class="form-group">
                <label>Image</label>
                <%--                <input type="password" name="img" class="form-control" placeholder="image name">--%>
                <input type="file" name="img" class="form-control" placeholder="upload image">
            </div>
            <div class="text-center">
                <button type="submit" class="btn btn-primary">Create offer</button>
            </div>
            <%--            <br/>--%>
            <%--            <div class="text-center">--%>
            <%--                <button type="button" class="btn btn-primary">Go back</button>--%>
            <%--            </div>--%>
        </form>
    </div>
</div>
<%@include file="includes/footer.jsp" %>

</body>
</html>
