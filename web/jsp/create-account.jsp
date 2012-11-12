<html>
<head><title>Account Created!</title></head>

<body>

<%@ page import="java.sql.SQLException, db.User" %>

<%-- The following locates object "db" of type "my.db.BeerDB" from the
     current session.  We have created this object in the listener
     (src/my/listener/SessionListener.java) when the session was first
     initialized.
--%>
<jsp:useBean id="db" type="db.StockSimDB" scope="session"/>

<% String email = request.getParameter("email"); %>

<% if (email == null) { %>
    You need to specify an email.
    Please <a href="<%=request.getContextPath()%>/create-account.jsp">try again</a>.

<% } else { %>

    <h1>Create Account: <%=email%></h1>
    <%
    String username = request.getParameter("username");
    String password = request.getParameter("password");
    
    User user = new User(email, username, password);
    try {
        db.updateUsers(user);
        out.println("Database updated.");
    } catch (SQLException e) {
        out.println("Sorry, I cannot modify the database!");
        out.println(e.getMessage());
    }
    %>

<% } %>

</body>
</html>
