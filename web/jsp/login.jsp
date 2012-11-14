<html>
<head>
  <title>Logging In...</title>
  <link rel="stylesheet" type="text/css" href="../css/style.css" />
</head>

<body>
<div>
  <header>
    <h1>StockSim</h1>
  </header>

  <div class="content">
<%@ page import="java.sql.SQLException" %>

<%-- The following locates object "db" of type "db.StockSimDB" from the
     current session.  We have created this object in the listener
     (src/listener/SessionListener.java) when the session was first
     initialized.
--%>
<jsp:useBean id="db" type="db.StockSimDB" scope="session"/>

<% String username = request.getParameter("username"); 
   String password = request.getParameter("password");
%>

<p>
<% if (username == null) { %>
    You need to specify a username.
    Please <a href="<%=request.getContextPath()%>/login.jsp">try again</a>.
<% } else if (password == null) { %>
    You need to specify a password.
    Please <a href="<%=request.getContextPath()%>/login.jsp">try again</a>.
<% } else { %>

    <h3 align="center">Logging In: <%=username%></h3>
    <%
    try {
      boolean isAuthorized = db.AuthLogin(username, password);
        if (isAuthorized) {
          out.println("User credentials verified. Logging in.");
          session.setAttribute("userID", username);
          response.sendRedirect("../html/home.html");
        }
        else {
          out.println("Credentials do not match those of any known users. Login failed.");
        }
    } catch (SQLException e) {
        out.println("Database could not be accessed.");
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
