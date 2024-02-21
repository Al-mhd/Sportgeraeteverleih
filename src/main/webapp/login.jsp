<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>JSP - Hello World</title>
    <%@include file="includes/header.jsp" %>
</head>
<body>

<%@include file="includes/navbar.jsp" %>
</h1>
<div class="container">
    <div class="card w-50 mx-auto my-5">
        <div class="card-header text-center">User Login</div>
        <div class="card-body">
            <%--            <form action="${pageContext.request.contextPath}/login" method="get">--%>
            <form action="login" method="post">
                <div class="form-group">
                    <label>Username</label>
                    <input type="text" name="username" class="form-control" placeholder="username">
                </div>
                <div class="form-group">
                    <label>Password</label>
                    <input type="password" name="password" class="form-control" placeholder="password">
                </div>
                <div class="text-center">
                    <button type="submit" class="btn btn-primary">Login</button>
                </div>
                <br/>
                <div class="text-center">
                    <%--                    <button type="button" class="btn btn-primary">Register</button>--%>
                    <a class="btn btn-primary" href="register.jsp">Register</a>
                </div>
            </form>
        </div>
    </div>
</div>
<%--<form action="${pageContext.request.contextPath}/login" method="get">--%>
<%--  username: <input type="text" name="username">--%>
<%--  <br/>--%>
<%--  password: <input type="password" name="password">--%>
<%--  <br/>--%>
<%--  <input type="submit">--%>
<%--</form>--%>
<br/>
<%@include file="includes/footer.jsp" %>
</body>
</html>