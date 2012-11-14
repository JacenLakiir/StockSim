<html>
<head>
  <title>Account Created!</title>
  <link rel="stylesheet" type="text/css" href="../css/style.css" />
</head>

<body>
<div>
  <header>
    <h1>StockSim</h1>
  </header>

  <div class="content">
<%@ page import="java.sql.SQLException, db.Users" %>

<%-- The following locates object "db" of type "db.StockSimDB" from the
     current session.  We have created this object in the listener
     (src/listener/SessionListener.java) when the session was first
     initialized.
--%>
<jsp:useBean id="db" type="db.StockSimDB" scope="session"/>

<% String email = request.getParameter("email"); %>

<p>
<% if (email == null) { %>
    You need to specify an email.
    Please <a href="../html/newAccount.html">try again</a>.
<% } else { %>

    <h3 align="center">Create Account: <%=email%></h3>
    <%
    String username = request.getParameter("username");
    String password = request.getParameter("password");
    
    Users user = new Users(username, password, email);
    try {
        db.CreateUser(user);
        out.println("New user added to database.");
    } catch (SQLException e) {
        out.println("Could not add new user to database.");
        out.println(e.getMessage());
    }
    %>
    
<% } %>
</p>

  </div>
  
  <footer>
    <p>
    &copy; Copyright 2012 by Eric Mercer &amp; David Liu
    </p>
  </footer>

</div>
</body>
</html>
