<%@ page import="java.util.List" %>
<%@ page import="de.uni.database.entity.MessageEntity" %>
<%@ page import="de.uni.database.dao.MessageDao" %>
<%@ page import="de.uni.database.dao.MessageDao" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Chat</title>
    <%@include file="includes/header.jsp" %>
    <link rel="stylesheet" href="chat/chat.css">
</head>
<body>
<%@include file="includes/checkLogin.jsp" %>
<%@include file="includes/navbar.jsp" %>

<%
    String sender = (String) session.getAttribute("name"); // this user (logged-in user)
    String receiver = (String) session.getAttribute("owner_name"); // owner name of offer
    MessageDao messageDao = new MessageDao();
    List<MessageEntity> allMessages = messageDao.getAllMessages(sender, receiver);
    for (MessageEntity msg : allMessages) {
        //
        if (msg.getSender_name().equals(sender)) {
%>
    <div class="container">
        <strong><%=sender%></strong>
<%
        } else {
%>
    <div class="container darker">
        <strong><%=receiver%></strong>
<%
        }
%>
        <p><%=msg.getMsg()%></p>
        <span class="time-right"><%=msg.getMsg_date()%></span>
    </div>
<%
    }
%>

        <form id="form_id">
            <input type="text" name="new_message" id="textMessage">
            <input type="button" value="send message" onclick="sendMessage()">
<%--        </form>--%>
<%--        <form action="send-image" method="post">--%>
            <div class="form-group">
                <label>Image</label>
                <input type="file" name="img" class="form-control" placeholder="upload image">
            </div>
            <input type="button" name="image_path" value="send image" onclick="sendImage()">
<%--            <div class="text-center">--%>
<%--                <button type="submit" class="btn btn-primary">send image</button>--%>
<%--            </div>--%>
        </form>
<script type="text/javascript">
    let textMessage = document.getElementById("textMessage");
    // open connection
    const webSocket = new WebSocket("ws://localhost:8080/Sportgeraeteverleih_war/chat");
    webSocket.onopen = function () {
        console.log("CLIENT: server Connected. '<%=sender%>' is successfully connected with '<%=receiver%>'")
    };
    webSocket.onmessage = (event) => { // receive message from server (event.data = message as String)
        if (!(event.data === "success")) {
            console.log("CLIENT: internal server error '" + event.data + "'")
        }
    };

    function sendImage() {
        let file = document.getElementById('image_path');
        let reader = new FileReader();
        let rawData = new ArrayBuffer();
        reader.loadend = function (e) {
        };
        reader.onload = function (e) {
            let rawData = e.target.result;
            let byteArray = new Uint8Array(rawData);
            let fileByteArray = [];
            webSocket.send(byteArray.buffer);
        }
        reader.readAsArrayBuffer(file);
    }

    function sendMessage() {
        console.log("CLIENT: sendMessage")
        <%--webSocket.send("<%=sender%>,<%=receiver%>," + textMessage.value); // send to SERVER ( to ChatServerEndpoint.onMessage(String) )--%>
        let sender = "<%=sender%>";
        let receiver = "<%=receiver%>";
        let msg = textMessage.value;
        let json = {
            "msg": msg,
            "sender_name": sender,
            "receiver_name": receiver
        };
        webSocket.send(JSON.stringify(json)); // send to SERVER ( to ChatServerEndpoint.onMessage(MessageModel) )
        // TODO: add div for sender
        let div_sender = document.createElement('div')
        div_sender.className = "container"
        // "yyyy.MM.dd HH:mm:ss"
        let d = new Date()
        let y = d.getFullYear()
        let m = d.getMonth()
        if (m < 10) { m = "0" + m; }
        let day = d.getDay()
        if (day < 10) { day = "0" + day; }
        let hour = d.getHours()
        if (hour < 10) { hour = "0" + hour; }
        let min = d.getMinutes()
        if (min < 10) { min = "0" + min; }
        let sec = d.getSeconds()
        if (sec < 10) { sec = "0" + sec; }
        let date_to_show = y + "." + m + "." + day + " " + hour + ":" + min + ":" + sec
        div_sender.innerHTML += "<strong><%=sender%></strong><p>" + textMessage.value + "</p><span class='time-right'>" + date_to_show + "</span>"
        let form_node = document.getElementById('form_id')
        // document.body.appendChild(div_sender)
        document.body.insertBefore(div_sender, form_node)
        console.log("msg = " + textMessage.value)
        textMessage.value = "";
    }

    webSocket.onclose = function () {
        console.log("CLIENT: connection closed")
    };
    webSocket.onerror = function (event) {
        console.log("CLIENT: error ( " + event.data + " )")
        webSocket.send("client disconnected");
    };
</script>
</body>
</html>
