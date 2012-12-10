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

<% if (username == null) { %>
    <p align="center">
	    You need to specify a username.
	  </p>
    <p align="center">
	    Please <a href="../index.html">try again.</a>.
	  </p>
<% } else if (password == null) { %>
    <p align="center">
	    You need to specify a password.
	  </p>
    <p align="center">
	    Please <a href="../index.html">try again.</a>.
	  </p>
<% } else { %>

    <h3 align="center">Logging In: <%=username%></h3>
<%
    try {
      boolean isVerified = db.authenticateLogin(username, password);
        if (isVerified) {
%>        
          <p align="center">
            User credentials verified. Logging in.
          </p>
<%
          session.setAttribute("userID", username);
          response.sendRedirect("home.jsp");
        }
        else {
%>        
          <p align="center">
            Credentials do not match those of any known users. Login failed.
          </p>
          <p align="center">
            Please <a href="../index.html">try again.</a>
          </p>
<%      }
    } catch (SQLException e) {
%>        <p>
            Database could not be accessed.
<%          out.println(e.getMessage()); %>
          </p>
<%  }
   } %>
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
