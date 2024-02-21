<%@ page import="java.util.ArrayList" %>
<%@ page import="de.uni.database.dao.MessageDao" %>
<%@ page import="de.uni.database.entity.MessageEntity" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Messages</title>
    <%@include file="includes/header.jsp" %>
</head>
<body>
<%@include file="includes/checkLogin.jsp" %>
<%@include file="includes/navbar.jsp" %>


<%
    String this_userName = (String) session.getAttribute("name");
    MessageDao messageDao = new MessageDao();
    List<MessageEntity> msgs = messageDao.getAllMessagesForOneUser(this_userName);
//    UserDao userDao = new UserDao();
//    ArrayList<UserEntity> users = (ArrayList<UserEntity>) userDao.getAllUser();
    if (msgs == null) {
%>
<div class="container my-3">
    <div class="d-flex py-3">
        <h3>There is no messages</h3>
    </div>
</div>
<br/>

<%
} else {
    List<String> users = new ArrayList<>();
    for (MessageEntity messageEntity : msgs) {
        if (messageEntity.getReceiver_name().equals(this_userName)) {
            if (!users.contains(messageEntity.getSender_name())) {
                users.add(messageEntity.getSender_name());
            }
        } else {
            if (!users.contains(messageEntity.getReceiver_name())) {
                users.add(messageEntity.getReceiver_name());
            }
        }
    }
%>

<div class="container my-3">
    <table class="table table-light">
        <thead>
        <tr>
            <th scope="col">user name</th>
            <%--            <th scope="col">show offers</th>--%>
            <th scope="col">send message</th>
<%--            <th scope="col">delete user</th>--%>
        </tr>
        </thead>
        <tbody>
        <%
            for (String userName : users) {
        %>
        <tr>
            <td>
                <%=userName%>
            </td>
            <td>
                <a class="btn btn-dark" href="message-to-user?owner_name=<%=userName%>"><svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-chat-right-text-fill" viewBox="0 0 16 16"><path d="M16 2a2 2 0 0 0-2-2H2a2 2 0 0 0-2 2v8a2 2 0 0 0 2 2h9.586a1 1 0 0 1 .707.293l2.853 2.853a.5.5 0 0 0 .854-.353zM3.5 3h9a.5.5 0 0 1 0 1h-9a.5.5 0 0 1 0-1m0 2.5h9a.5.5 0 0 1 0 1h-9a.5.5 0 0 1 0-1m0 2.5h5a.5.5 0 0 1 0 1h-5a.5.5 0 0 1 0-1"></path></svg></a>
            </td>
<%--            <td>--%>
<%--                <a href="remove-user?pk=<%=userEntity.getPk()%>&user_name=<%=userEntity.getUsername()%>" class="btn btn-sm btn-danger">remove</a>--%>
<%--            </td>--%>
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
