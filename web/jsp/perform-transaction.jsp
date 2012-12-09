<html>
<head>
  <title>Transaction Performed!</title>
  <link rel="stylesheet" type="text/css" href="../css/style.css" />
</head>

<body>
<div>
  <header>
    <h1>StockSim</h1>
  </header>

  <div class="content">
<%@ page import="java.sql.SQLException, java.math.BigDecimal, db.YAPI_Reader" %>

<%-- The following locates object "db" of type "db.StockSimDB" from the
     current session.  We have created this object in the listener
     (src/listener/SessionListener.java) when the session was first
     initialized.
--%>
<jsp:useBean id="db" type="db.StockSimDB" scope="session"/>

<% 
   String PID = request.getParameter("pid");
   String type = (String) request.getParameter("type");
   int numShares = Integer.parseInt(request.getParameter("numShares"));
   String ticker = (String) request.getParameter("ticker");
%>

<h3 align="center">Perform Transaction: <%=type + " " + numShares + " of " + ticker %></h3>
<p align="center">
<%
    try {
    	  if (type.equals("Sell")) {
    		  numShares *= -1;
    		}
        BigDecimal price = db.performTransaction(PID, type, numShares, ticker);
        
        boolean isPlural = (Math.abs(numShares) > 1);
        StringBuilder message = new StringBuilder("Transaction performed. ");
        message.append(Math.abs(numShares));
        message.append(" ");
        message.append(isPlural ? "shares" : "share");
        message.append(" of ");
        message.append(ticker);
        message.append(isPlural ? " have " : " has ");
        message.append("been ");
        message.append((type.equals("Buy") ? "purchased" : "sold"));
        message.append(" at $");
        message.append(String.format("%.2f", price.doubleValue()));
        message.append(" per share.");
        
        out.println(message.toString());
    } catch (SQLException e) {
      BigDecimal price = YAPI_Reader.getPrice(ticker);
      String error = e.getMessage();
      
      StringBuilder message = new StringBuilder("Could not perform transaction. ");
      if (error.contains("CASH")) {
        message.append("Would require $");
        message.append(String.format("%.2f", numShares * price.doubleValue()));
        message.append(" to purchase ");
        message.append(numShares);
        message.append(" share(s) of ");
        message.append(ticker);
        message.append(".");
      }
      else if (error.contains("SHARES")) {
        message.append("You don't own enough shares to sell ");
        message.append(Math.abs(numShares));
        message.append(" shares of ");
        message.append(ticker);
        message.append(".");
      }
      
      out.println(message.toString());
    }
%>
</p>

<p align="center">
  <a href="portfolio.jsp?pid=<%=PID %>">Return to portfolio.</a>
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