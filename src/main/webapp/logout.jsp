
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <%@include file="includes/header.jsp"%>

</head>
<body>
<% session.removeAttribute("name"); %>
<p>You have been successfully logout</p>
<% response.setHeader("Refresh", "1;url=index.jsp"); %>
<%@include file="includes/footer.jsp"%>
</body>
</html>
