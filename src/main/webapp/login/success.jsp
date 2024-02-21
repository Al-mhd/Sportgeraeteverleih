<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Login success</title>
    <%@include file="../includes/header.jsp" %>
</head>
<body>
<%@include file="../includes/navbar.jsp" %>

<div class="container">
    <div class="card w-50 mx-auto my-5">
        <div class="card-header text-center">
            Successfully eingeloggt
            <br/>
            Welcome, <%=session.getAttribute("name")%>
        </div>
    </div>
</div>

<%--<% int count = 3;--%>
<%--%>--%>
<%--<%=count%>--%>
<%
    response.setHeader("Refresh", "3;url=../index.jsp");
%>

<%@include file="../includes/footer.jsp" %>
</body>
</html>
