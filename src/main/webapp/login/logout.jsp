<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <%@include file="../includes/header.jsp" %>
</head>
<body>

<div class="container">
    <div class="card w-50 mx-auto my-5">
        <div class="card-header text-center">
            You have been successfully logout
            <br/>
            Tschüss, <%=session.getAttribute("name")%>
        </div>
    </div>
</div>

<% session.removeAttribute("name"); %>
<% response.setHeader("Refresh", "1;url=../index.jsp"); %>
<%@include file="../includes/footer.jsp" %>
</body>
</html>
