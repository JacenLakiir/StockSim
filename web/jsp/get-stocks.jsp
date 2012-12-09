<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8" />

    <!-- Always force latest IE rendering engine (even in intranet) & Chrome Frame
    Remove this if you use the .htaccess -->
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />

    <title>StockSim</title>
    <meta name="description" content="" />
    <meta name="author" content="Eric Mercer" />
    <meta name="viewport" content="width=device-width; initial-scale=1.0" />

    <!-- Replace favicon.ico & apple-touch-icon.png in the root of your domain and delete these references -->
    <link rel="stylesheet" type="text/css" href="../css/style.css" />
    <link rel="shortcut icon" href="/favicon.ico" />
    <link rel="apple-touch-icon" href="/apple-touch-icon.png" />
  </head>

<body>
<div>
  <header>
    <h1>StockSim</h1>
  </header>

  <div class="content">
<%@ page import="java.sql.SQLException, java.util.Collections, java.util.Arrays, java.util.List, java.util.ArrayList, db.YAPI_Reader" %>

<%-- The following locates object "db" of type "db.StockSimDB" from the
     current session.  We have created this object in the listener
     (src/listener/SessionListener.java) when the session was first
     initialized.
--%>
<jsp:useBean id="db" type="db.StockSimDB" scope="session"/>

<h3 align="center">Stock Data</h3>
<%
    try {
       String stocks = request.getParameter("stocks");
       List<String> tickers = new ArrayList<String>();
       Collections.addAll(tickers, stocks.split("\\s+"));
       
       String[] attrs = request.getParameterValues("attributes");
       List<String> quotes;
       if (attrs != null) {
         List<String> attributes = new ArrayList<String>();
         attributes.add("Ticker");
    	   Collections.addAll(attributes, attrs);
    	   quotes = YAPI_Reader.getStockQuotes(tickers, attributes);
       }
       else {
         quotes = YAPI_Reader.getStockQuotes(tickers);
       }
%>
   <div class="table">
      <table>
        <tr>
<%        String[] header = quotes.get(0).split(",");
          for (int j = 0; j < header.length; j++) {
%>
            <th><%=header[j] %></th>        
<%        } %>
        </tr>
<%      for (int i = 1; i < quotes.size(); i++) {
          String row[] = quotes.get(i).split(",");
%>
        <tr>
<%        for (int j = 0; j < row.length; j++) { %>
            <td class=<%=(i % 2 == 0) ? "gr1" : "gr1alt"%>>
              <%=row[j].replaceAll("\"", "") %>
            </td>
<%        } %>
        </tr>
<%     } %>
    </table>
  </div>
<%  } catch (Exception e) { %>
<p align="center">
<%
      out.println("Stock data could not be retrieved at this time. Please try again later.");
      e.printStackTrace();
    }
%>
</p>

    <p align="center">
      <a href="../html/research.html">Continue research.</a>
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
