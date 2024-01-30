<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Login failed</title>
    <%@include file="includes/header.jsp" %>
</head>
<body>
<%@include file="includes/navbar.jsp" %>

<div class="container">
    <div class="card w-50 mx-auto my-5">
        <div class="card-header text-center">Login failed</div>
<%--        <div class="card-body">--%>
<%--            <form action="login" method="get">--%>
<%--                <div class="text-center">--%>
<%--                    <button type="submit" class="btn btn-primary">Login</button>--%>
<%--                </div>--%>
<%--                <br/>--%>
<%--                <div class="text-center">--%>
<%--                    &lt;%&ndash;                    <button type="button" class="btn btn-primary">Register</button>&ndash;%&gt;--%>
<%--                    <a class="btn btn-primary" href="register.jsp">Register</a>--%>
<%--                </div>--%>
<%--            </form>--%>
<%--        </div>--%>
    </div>
</div>

<% response.setHeader("Refresh", "2;url=index.jsp"); %>


<%--<a href="login.jsp">Login</a>--%>
<%--<br/>--%>
<%--<a href="register.jsp">Register</a>--%>

<%@include file="includes/footer.jsp" %>
</body>
</html>
