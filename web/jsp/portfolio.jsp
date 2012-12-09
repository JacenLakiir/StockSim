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
        <nav>
          <ul>
            <li><a href="home.jsp">Home</a></li>
            <li><a href="../html/research.html">Research</a></li>
            <li><a href="leaderboards.jsp">Leaderboards</a></li>
          </ul>
        </nav>

<%@ page import="java.sql.SQLException, java.util.List, java.util.ArrayList, java.math.BigDecimal, db.Portfolio, db.Portfolio.Stock, db.YAPI_Reader" %>

<%-- The following locates object "db" of type "db.StockSimDB" from the
     current session.  We have created this object in the listener
     (src/listener/SessionListener.java) when the session was first
     initialized.
--%>
<jsp:useBean id="db" type="db.StockSimDB" scope="session"/>

<%  try {
      String PID = (String) request.getParameter("pid");
    String portfolioName = db.getPortfolioName(PID);
%>
        <h3 align="center"><%=portfolioName %></h3>      
<%  } catch (Exception e) { %>
    <p>
<%    
    out.println("Could not retrieve portfolio for current session.");
    out.println(e.getMessage());
%>
    </p>    
<%  } %>
        
<%  try {
      String username = (String) session.getAttribute("userID");
      String PID = (String) request.getParameter("pid");
      Portfolio portfolio = db.getStock_Holdings(PID);
      List<Stock> stockHoldings = portfolio.getStockHoldings();
      if (stockHoldings == null || stockHoldings.size() == 0) {
%>
        <p>
<%        out.println("Empty portfolio - no stocks held."); %>
      </p>
<%    }
      else {
        List<String> tickers = new ArrayList<String>();
        for (int i = 0; i < stockHoldings.size(); i++) {
          tickers.add(stockHoldings.get(i).getTicker());
        }
        List<BigDecimal> prices = YAPI_Reader.getPrices(tickers);
%>
    <div class="table">
      <table>
        <tr>
          <th>Stock</th>
          <th>Number of Shares</th>
          <th>Current Price</th>
          <th>Avg. Price Bought</th>
          <th>% Change</th>
          <th>Current Value</th>
        </tr>
<%    double totalMarketValue = 0;
    for (int i = 0; i < stockHoldings.size(); i++) {
      Stock s = stockHoldings.get(i);
%>
      <tr>
        <td class=<%=(i % 2 == 0) ? "gr1" : "gr1alt"%>>
          <%=s.getTicker() %>
        </td>
        <td class=<%=(i % 2 == 0) ? "gr1" : "gr1alt"%>>
          <%=s.getNumShares() %>
        </td>
        <td class=<%=(i % 2 == 0) ? "gr1" : "gr1alt"%>>
          $<%=String.format("%.2f", prices.get(i)) %>
        </td>
        <td class=<%=(i % 2 == 0) ? "gr1" : "gr1alt"%>>
          $<%=s.getAvgPriceBought() %>
        </td>
        <td class=<%=(i % 2 == 0) ? "gr1" : "gr1alt"%>>
<%        double roundedPrice = Double.parseDouble(String.format("%.2f", prices.get(i)));
          double avgPriceBought = s.getAvgPriceBought().doubleValue();
      double percentChange = (roundedPrice - avgPriceBought) / avgPriceBought;
%>
          <%=String.format("%.2f", percentChange*100) %>%
        </td>
        <td class=<%=(i % 2 == 0) ? "gr1" : "gr1alt"%>>
<%        double marketValue = s.getNumShares() * prices.get(i).doubleValue();
          totalMarketValue += marketValue;
%>
          $<%=String.format("%.2f", marketValue) %>
        </td>
      </tr>
<%    } %>
      </table>
    </div>
    
      <%--TODO: figure how to toggle sorts --%>        
      <p align="center">
        <label>Sort portfolio by: </label>
          <select id="sorts">
            <option value="1">stock symbol</option>
            <option value="2">num. shares</option>
            <option value="3">current value</option>
          </select>
      </p>
        
      <p align="center">
        Cash Remaining: $<%=portfolio.getCash()%><br>
        Total Market Value: $<%=String.format("%.2f", totalMarketValue + portfolio.getCash().doubleValue()) %>
      </p>
<%    }
  } catch (SQLException e) { %>
    <p>
<%    
    out.println("Could not retrieve the stock holdings for this portfolio.");
    out.println(e.getMessage());
%>
    </p>  
<%  } %>
        
<%  String PID = (String) request.getParameter("pid");%>
        <nav>
          <ul>
            <li><a href="marketplace.jsp?pid=<%=PID%>">Buy/Sell Stock</a></li>
            <li><a href="history.jsp?pid=<%=PID%>">Transaction History</a></li>
            <li><a href="performance.html">Performance</a></li>
          </ul>
        </nav>
        
      </div>
      
      <footer>
        <p>
          &copy; Copyright 2012 by Eric Mercer &amp; David Liu
        </p>
      </footer>
    </div>
  </body>
</html>
