<%@ page import="static de.uni.constants.AppConstants.ADMIN_ROLE_NAME" %>
<nav class="navbar navbar-expand-lg navbar-light bg-light">
    <div class="container">

        <a class="navbar-brand" href="index.jsp">Sportgeraeteverleih</a>
        <%
            if (session.getAttribute("name") != null) {
        %>
        <a class="navbar-brand" href="index.jsp"> - Welcome, <%=session.getAttribute("name")%>
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
					if (session.getAttribute("role").equals(ADMIN_ROLE_NAME)){
                    %>
                        <li class="nav-item"><a class="nav-link" href="users.jsp">Benutzer</a></li>
                    <%
                    } else {
                    %>
                        <li class="nav-item"><a class="nav-link" href="profile.jsp">Profile</a></li>
                        <li class="nav-item"><a class="nav-link" href="messages.jsp">Nachrichten</a></li>
                        <li class="nav-item"><a class="nav-link" href="addOffer.jsp">Angebote erstellen</a></li>
                        <li class="nav-item"><a class="nav-link" href="cart.jsp">Warenkorb</a></li>
                    <%
                    }
                    %>
                <li class="nav-item"><a class="nav-link" href="login/logout.jsp">Logout</a></li>
                <%
				}
                %>
            </ul>
        </div>
    </div>
</nav>