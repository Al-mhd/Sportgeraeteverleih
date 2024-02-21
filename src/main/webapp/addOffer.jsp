<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Add offer</title>
    <%@include file="includes/header.jsp" %>
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
        }
    </script>
</head>
<body>
<%@include file="includes/checkLogin.jsp" %>
<%@include file="includes/navbar.jsp" %>
<div class="card w-50 mx-auto my-5">
    <div class="card-header text-center">Create offer</div>
    <div class="card-body">
        <form method="post" action="UploadServlet" enctype="multipart/form-data">
            <%
                if(session.getAttribute("uploaded") == null){
            %>
            <input type="file" name="file">
            <input type="submit" value="upload">
            <%
                }else {
            %>
            <p>image uploaded</p>
            <%
                }
            %>
        </form>

        <form action="addOffer" method="post">
            <div class="form-group">
                <label>Name</label>
                <input required type="text" name="offerName" class="form-control" placeholder="offer name">
            </div>
            <div class="form-group">
                <label>Price</label>
                <input required type="text" name="preis" class="form-control" placeholder="Preis in Euro">
            </div>
<%--            <div class="form-group">--%>
<%--                <label>Image</label>--%>
<%--                <input required type="file" id="filename" name="img" class="form-control" placeholder="upload image">--%>
<%--                <input type="button" value="Upload" onclick="sendFile()">--%>
<%--            </div>--%>
            <div class="text-center">
                <button type="submit" class="btn btn-primary">Create offer</button>
            </div>
        </form>
    </div>
</div>
<%@include file="includes/footer.jsp" %>

</body>
</html>
