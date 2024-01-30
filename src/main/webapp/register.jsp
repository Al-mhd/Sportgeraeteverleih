<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <%@include file="includes/header.jsp"%>
</head>
<body>
<%@include file="includes/navbar.jsp" %>
<div class="container">
    <div class="card w-50 mx-auto my-5">
        <div class="card-header text-center">Registration</div>
        <div class="card-body">
            <%--            <form action="${pageContext.request.contextPath}/login" method="get">--%>
            <form action="register" method="get">
                <div class="form-group">
                    <label>Username</label>
                    <input type="text" name="username" class="form-control" placeholder="username">
                </div>
                <div class="form-group">
                    <label>Password</label>
                    <input type="password" name="password" class="form-control" placeholder="password">
                </div>
                <div class="form-group">
                    <label>Confirm password</label>
                    <input type="password" name="rpassword" class="form-control" placeholder="password again">
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
                    <button type="submit" class="btn btn-primary">Register</button>
                </div>
                <br/>
                <div class="text-center">
                    <%--                    <button type="button" class="btn btn-primary">Register</button>--%>
                    <a class="btn btn-primary" href="login.jsp">Login</a>
                </div>
            </form>
        </div>
    </div>
</div>
<%--<form action="${pageContext.request.contextPath}/register" method="get">--%>
<%--<form action="register" method="get">--%>
<%--    username: <input type="text" name="username">--%>
<%--    <br/>--%>
<%--    password: <input type="password" name="password">--%>
<%--    <br/>--%>
<%--    <input type="submit">--%>
<%--</form>--%>
<br/>
<%@include file="includes/footer.jsp"%>
</body>
</html>
