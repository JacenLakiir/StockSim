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
        
        <h3 align="center">Home</h3>
        
<%@ page import="java.sql.SQLException, java.util.Collections, java.util.List, java.util.ArrayList, java.math.BigDecimal, db.Portfolio, db.Stock, db.Portfolio.NameComparator, db.YAPI_Reader" %>

<%-- The following locates object "db" of type "db.StockSimDB" from the
     current session.  We have created this object in the listener
     (src/listener/SessionListener.java) when the session was first
     initialized.
--%>
<jsp:useBean id="db" type="db.StockSimDB" scope="session"/>

<%  String username = (String) session.getAttribute("userID");
	  if (username == null) {
%>
        <p align="center">
<%        out.println("Could not retrieve userID for current session."); %>
		    </p>
		    <p align="center">
		      <a href="../index.html">Please log in.</a>
		    </p>    
<%  }
    else { 
%> 
        <p align="center">
          Welcome, <%=username %>!        
        </p>
<%      try {
			    List<Portfolio> allPortfolios = db.getAllPortfolios(username);
			    Collections.sort(allPortfolios, new Portfolio.NameComparator());
%>
			    <div class="table">
			      <table>
			        <tr>
			          <th>Portfolio</th>
			          <th>Cash</th>
			          <th>Market Value</th>
			          <th>Rank</th>
			          <th>Percentile</th>
			        </tr>
<%            for (int i = 0; i < allPortfolios.size(); i++) {
	              Portfolio portfolio = allPortfolios.get(i);
				        double totalMarketValue = portfolio.getCash().doubleValue();
				        String PID = portfolio.getPID();
				        
				        List<Stock> stockHoldings = db.getStock_Holdings(PID).getStockHoldings();
				        List<String> tickers = new ArrayList<String>();
				        for (int j = 0; j < stockHoldings.size(); j++) {
				          tickers.add(stockHoldings.get(j).getTicker());
				        }
				        if (tickers.size() > 0) {
				          List<BigDecimal> prices = YAPI_Reader.getPrices(tickers);
				          for (int j = 0; j < stockHoldings.size(); j++) {
				            totalMarketValue += stockHoldings.get(j).getNumShares() * prices.get(j).doubleValue();
				          }
				        }
				        
				        List<Integer> rankStats = db.getRanking(PID);
				        int rank = rankStats.get(0);
				        int total = rankStats.get(1);
				        double percentile = ((double) total - rank) / total * 100;
%>
				      <tr>
				        <td class=<%=(i % 2 == 0) ? "gr1" : "gr1alt"%>>
				          <a href="portfolio.jsp?pid=<%=PID%>"><%=portfolio.getName()%></a>
				        </td>
				        <td class=<%=(i % 2 == 0) ? "gr1" : "gr1alt"%>>
				          $<%=portfolio.getCash() %>
				        </td>
				        <td class=<%=(i % 2 == 0) ? "gr1" : "gr1alt"%>>
				          $<%=String.format("%.2f", totalMarketValue) %>
				        </td>
				        <td class=<%=(i % 2 == 0) ? "gr1" : "gr1alt"%>>
				          <%=rank + " / " + total %>
				        </td>
				        <td class=<%=(i % 2 == 0) ? "gr1" : "gr1alt"%>>
				          <%=String.format("%.0f", percentile) %>
				        </td>
				      </tr>
<%            } %>
            </table>
          </div>
        
        <p>
          <div align="center">
            <form name="newPortfolio" action="../html/newPortfolio.html">
              <input type="submit" value="Create New Portfolio">
            </form>
          </div>
        </p>
<%      } catch (SQLException e) { %>
          <p>
<%    
				    out.println("Could not retrieve the user's portfolios.");
				    out.println(e.getMessage());
%>
          </p>  
<%      }
      }
%>
 
      </div>
      
      <footer>
        <p>
          &copy; Copyright 2012 by Eric Mercer &amp; David Liu
        </p>
      </footer>
    </div>
  </body>
</html>
