
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Login success</title>
    <%@include file="includes/header.jsp"%>
</head>
<body>

<h1><%= "successfully eingeloggt" %>
</h1>
<p>Welcome, <%=session.getAttribute("name")%>
</p>
<% response.setHeader("Refresh", "1;url=index.jsp"); %>

<%@include file="includes/footer.jsp"%>
</body>
</html>
