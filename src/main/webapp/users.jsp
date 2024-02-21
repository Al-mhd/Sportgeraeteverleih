<%@ page import="de.uni.database.entity.UserEntity" %>
<%@ page import="de.uni.database.dao.UserDao" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Users</title>
    <%@include file="includes/header.jsp" %>

    <style type="text/css">

        .table tbody td {
            vertical-align: middle;
        }

        .btn-incre, .btn-decre {
            box-shadow: none;
            font-size: 25px;
        }
    </style>
</head>
<body>
<%@include file="includes/checkLogin.jsp" %>
<%@include file="includes/navbar.jsp" %>

<%
    UserDao userDao = new UserDao();
    ArrayList<UserEntity> users = (ArrayList<UserEntity>) userDao.getAllUser();
    if (users == null) {
%>
<div class="container my-3">
    <div class="d-flex py-3">
        <h3>There is no users</h3>
    </div>
</div>
<br/>

<%
} else {
%>

<div class="container my-3">

    <form action="message-to-all-users" method="post">
        send message to all users:<br>
        <input type="text" name="message_to_all" size="5000"><br><br>
        <input type="submit" value="send">
    </form>
<%--    <p>send message to all users</p>--%>
<%--    <a href="message-to-all-users<%=0%>" class="btn btn-sm btn-danger">remove</a>--%>
<%--    <form id="form_id">--%>
<%--        <input type="text" name="new_message" id="textMessage">--%>
<%--        <input type="button" value="Send" onclick="sendMessage()">--%>
<%--    </form>--%>
    <table class="table table-light">
        <thead>
        <tr>
            <th scope="col">user name</th>
            <%--            <th scope="col">show offers</th>--%>
            <th scope="col">send message</th>
            <th scope="col">delete user</th>
        </tr>
        </thead>
        <tbody>
        <%
            for (UserEntity userEntity : users) {
                if (userEntity.getRole().equals(ADMIN_ROLE_NAME)) { continue; }
        %>
        <tr>
            <td>
                <%=userEntity.getUsername()%>
            </td>
            <td>
                <a class="btn btn-dark" href="message-to-user?owner_name=<%=userEntity.getUsername()%>"><svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-chat-right-text-fill" viewBox="0 0 16 16"><path d="M16 2a2 2 0 0 0-2-2H2a2 2 0 0 0-2 2v8a2 2 0 0 0 2 2h9.586a1 1 0 0 1 .707.293l2.853 2.853a.5.5 0 0 0 .854-.353zM3.5 3h9a.5.5 0 0 1 0 1h-9a.5.5 0 0 1 0-1m0 2.5h9a.5.5 0 0 1 0 1h-9a.5.5 0 0 1 0-1m0 2.5h5a.5.5 0 0 1 0 1h-5a.5.5 0 0 1 0-1"></path></svg></a>
            </td>
            <td>
                <a href="remove-user?pk=<%=userEntity.getPk()%>&user_name=<%=userEntity.getUsername()%>" class="btn btn-sm btn-danger">remove</a>
            </td>
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
