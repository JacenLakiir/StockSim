<html>
<head>
  <title>Portfolio Deleted!</title>
  <link rel="stylesheet" type="text/css" href="../css/style.css" />
</head>

<body>
<div>
  <header>
    <h1>StockSim</h1>
  </header>

  <div class="content">
<%@ page import="java.sql.SQLException, java.math.BigDecimal, db.Portfolio" %>

<%-- The following locates object "db" of type "db.StockSimDB" from the
     current session.  We have created this object in the listener
     (src/listener/SessionListener.java) when the session was first
     initialized.
--%>
<jsp:useBean id="db" type="db.StockSimDB" scope="session"/>

<%  String username = (String) session.getAttribute("userID");
    String portfolioName = request.getParameter("portfolioName");
    if (username == null) {
%>
        <h3 align="center">Delete Portfolio</h3>
        <p align="center">
<%        out.println("Could not retrieve userID for current session."); %>
        </p>
        <p align="center">
          <a href="../index.html">Please log in.</a>
        </p>    
<% }
   else if (portfolioName == null) { %>
     <h3 align="center">Delete Portfolio</h3>
     <p align="center">
       You need to specify a portfolio name.
     </p>
     <p align="center">
       Please <a href="../html/deletePortfolio.html">try again</a>.
     </p>
<% }
   else { %>
      <h3 align="center">Delete Portfolio: <%=portfolioName%></h3>
<%     try {
           db.deletePortfolio(username, portfolioName);
           out.println("Portfolio deleted from database.");
           response.sendRedirect("home.jsp");
       } catch (SQLException e) {
           out.println("Could not delete portfolio from database.");
           out.println(e.getMessage());
       }
%>     </p>
       <p align="center">
         <a href="home.jsp">Return to home page.</a>
       </p>
<%  } %>

  </div>
  
  <footer>
    <p>
    &copy; Copyright 2012 by Eric Mercer &amp; David Liu
    </p>
  </footer>

</div>
</body>
</html>
