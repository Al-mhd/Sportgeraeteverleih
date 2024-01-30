<%
    if (session.getAttribute("name") == null) {
        response.sendRedirect("login.jsp");
    }
%>