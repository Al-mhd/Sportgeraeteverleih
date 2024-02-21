<%@ page import="de.uni.database.dao.MessageDao" %>
<%@ page import="de.uni.database.entity.MessageEntity" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Chat</title>
    <style media="screen" type="text/css">

        .chat {
            width: 100%;
            height: 200px;
            border: 1px solid silver;
            overflow-y: scroll;
        }

        #msg {
            width: 99%;
        }

        h1 {
            text-align: center;
        }

    </style>
    <%
        String sender = (String) session.getAttribute("name"); // this user (logged-in user)
        String receiver = (String) session.getAttribute("owner_name"); // owner name of offer
        System.out.println("chat2.jsp: sender = " + sender + ", receiver = " + receiver);
    %>
    <script type="text/javascript">
        function sendFile() {
            let file = document.getElementById('filename').files[0];
            console.log("file image: " + file)
            let reader = new FileReader();
            let rawData = new ArrayBuffer();
            reader.loadend = function (e) {
            };
            reader.onload = function (e) {
                rawData = e.target.result;
                ws.send(rawData);
            }
            reader.readAsBinaryString(file);
            // let file = document.getElementById('filename').files[0];
            // console.log("file image: " + file)
            // let reader = new FileReader();
            // let rawData = new ArrayBuffer();
            // reader.loadend = function (e) {
            // };
            // reader.onload = function (e) {
            //     rawData = e.target.result;
            //     let byteArray = new Uint8Array(rawData);
            //     let fileByteArray = [];
            //     ws.send(byteArray.buffer);
            // }
            // reader.readAsArrayBuffer(file);
        }

        const ws = new WebSocket("ws://localhost:8080/Sportgeraeteverleih_war/chat2");
        let sender = "<%=sender%>";
        let receiver = "<%=receiver%>";
        ws.onmessage = function (event) {
            console.log("onmessage: event.data = " + event)
            console.log("onmessage: event.data = " + event.data)
            var mySpan = document.getElementById("chat");
            mySpan.innerHTML += event.data + "<br/>";
        };
        ws.onerror = function (event) {
            console.log("Error ", event)
        }

        function sendMsg() {
            console.log("sendMsg() started")
            var msg = document.getElementById("msg").value;
            console.log("msg = " + msg + ", sender = " + sender + ", receiver = " + receiver)
            if (msg) {
                let json = {
                    "msg": msg,
                    "sender_name": sender,
                    "receiver_name": receiver
                };
                console.log("json = " + json)
                ws.send(JSON.stringify(json)); // send to SERVER ( to ChatServerEndpoint.onMessage(MessageModel) )
            }
            document.getElementById("msg").value = "";
        }
    </script>
    <%@include file="includes/header.jsp" %>
    <link rel="stylesheet" href="chat/chat.css">
</head>

<body>
<%@include file="includes/checkLogin.jsp" %>
<%@include file="includes/navbar.jsp" %>
<%
    MessageDao messageDao = new MessageDao();
    List<MessageEntity> allMessages = messageDao.getAllMessages(sender, receiver);
    for (MessageEntity msg : allMessages) {
        //
        if (msg.getSender_name().equals(sender)) {
%>
<div class="container">
    <strong><%=sender%>
    </strong>
        <%
        } else {
%>
    <div class="container darker">
        <strong><%=receiver%>
        </strong>
        <%
            }
        %>
        <p><%=msg.getMsg()%>
        </p>
        <span class="time-right"><%=msg.getMsg_date()%></span>
    </div>
        <%
    }
%>
    <h1>Live Chat updates</h1>
    <div>
        <div id="chat" class="chat"></div>
        <div>
            <input type="text" name="msg" id="msg" placeholder="Enter message here"/>
            <button onclick="return sendMsg();">send</button>
        </div>
        <div>
            <input required type="file" id="filename" name="filename" class="form-control" placeholder="upload image">
            <input type="button" value="Upload" onclick="sendFile()">
        </div>
    </div>
</body>
</html>
<%--webSocket.onopen = function () {--%>
<%--let json = {--%>
<%--"msg": "connection opened",--%>
<%--"sender_name": sender,--%>
<%--"receiver_name": receiver--%>
<%--};--%>
<%--webSocket.send(JSON.stringify(json)); // send to SERVER ( to ChatServerEndpoint.onMessage(MessageModel) )--%>
<%--console.log("CLIENT: server Connected. '<%=sender%>' is successfully connected with '<%=receiver%>'")--%>
<%--};--%>