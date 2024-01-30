<nav class="navbar navbar-expand-lg navbar-light bg-light">
    <div class="container">

        <a class="navbar-brand" href="index.jsp">Sportgeraeteverleih</a>
        <%
            if (session.getAttribute("name") != null) {
        %>
        <a class="navbar-brand" href="#"> - Welcome, <%=session.getAttribute("name")%>
        </a>
        <%
            }
        %>
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav ml-auto">
                <%--                <li class="nav-item active">--%>
                <%--                    <a class="nav-link" href="#">Home <span class="sr-only">(current)</span></a>--%>
                <%--                </li>--%>
                <% if (session.getAttribute("name") == null) { %>
                <li class="nav-item"><a class="nav-link" href="login.jsp">Login</a></li>
                <%
                } else {
                %>
                <%--                <li class="nav-item"><a class="nav-link" href="#">Welcome, <%=session.getAttribute("name")%></a></li>--%>
                <li class="nav-item"><a class="nav-link" href="profile.jsp">my profile</a></li>
                <li class="nav-item"><a class="nav-link" href="addOffer.jsp">create offer</a></li>
                <li class="nav-item"><a class="nav-link" href="cart.jsp">Cart</a></li>
                <li class="nav-item"><a class="nav-link" href="logout.jsp">Logout</a></li>
                <%
                    }
                %>
            </ul>
        </div>
    </div>
</nav>