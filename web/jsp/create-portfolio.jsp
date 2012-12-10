<html>
<head>
  <title>Portfolio Created!</title>
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

<% String portfolioName = request.getParameter("portfolioName"); %>

<%  String username = (String) session.getAttribute("userID");
    if (username == null) {
%>
        <p align="center">
<%        out.println("Could not retrieve userID for current session."); %>
        </p>
        <p align="center">
          <a href="../index.html">Please log in.</a>
        </p>    
<% }
   else if (portfolioName == null) { %>
     <p align="center">
       You need to specify a portfolio name.
     </p>
     <p align="center">
       Please <a href="../html/newPortfolio.html">try again</a>.
     </p>
<% }
   else { %>

    <h3 align="center">Create Portfolio: <%=portfolioName%></h3>
<%
    String username = (String) session.getAttribute("userID");
    BigDecimal cash = new BigDecimal(10000.00);
    if (username == null) {
%>
        <p align="center">
<%        out.println("Could not retrieve userID for current session."); %>
        </p>
        <p align="center">
          <a href="../index.html">Please log in.</a>
        </p>  
<%  } else {
%>      <p> <%
        Portfolio portfolio = new Portfolio(portfolioName, username, cash);
        try {
            db.createPortfolio(portfolio);
            out.println("New portfolio added to database.");
            response.sendRedirect("home.jsp");
        } catch (SQLException e) {
            out.println("Could not add new portfolio to database.");
            out.println(e.getMessage());
        }
%>      </p>
        <p align="center">
          <a href="home.jsp">Return to home page.</a>
        </p>
<%   }
   } %>


  </div>
  
  <footer>
    <p>
    &copy; Copyright 2012 by Eric Mercer &amp; David Liu
    </p>
  </footer>

</div>
</body>
</html>
