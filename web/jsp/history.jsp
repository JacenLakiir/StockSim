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
        
        <h3 align="center">Transaction History</h3>
        
    
<%@ page import="java.sql.SQLException, java.util.List, java.math.BigDecimal, db.Transaction" %>

<%-- The following locates object "db" of type "db.StockSimDB" from the
     current session.  We have created this object in the listener
     (src/listener/SessionListener.java) when the session was first
     initialized.
--%>
<jsp:useBean id="db" type="db.StockSimDB" scope="session"/>
        
<%  try {
      String PID = (String) request.getParameter("pid");
      List<Transaction> history = db.getTransactionHistoryByNumber(PID, 5);
      if (history == null || history.size() == 0) {
%>
        <p>
<%        out.println("Empty history - no transactions performed yet."); %>
        </p>
<%    } else { %>

        <p>
        <div class="table">
          <table>
            <tr>
              <th>Timestamp</th>
              <th>Type</th>
              <th>Stock</th>
              <th>Number of Shares</th>
              <th>Price</th>
            </tr>

<%        for (int i = 0; i < history.size(); i++) { 
        Transaction t = history.get(i);
%>
            <tr>
              <td class="gr1"><%=t.getTime()%></td>
              <td class="gr1"><%=t.getType() %></td>
              <td class="gr1"><%=t.getTicker() %></td>
              <td class="gr1"><%=Math.abs(t.getNumShares()) %></td>
              <td class="gr1">$<%=t.getPrice() %></td>
            </tr>
<%      } %>
          </table>
        </div>
          
        <p>
          <div align="center">
            <fieldset align="left">
              <legend>Show: </legend>
                <input type="radio" name="filter" value="numTransactions" checked="checked">
                  <label>
                    <select>
                      <option value="1">5</option>
                      <option value="2">10</option>
                      <option value="3">25</option>
                      <option value="4">50</option>
                      <option value="5">100</option>
                    </select> most recent transactions
                  </label><br>
                <input type="radio" name="filter" value="numDays">
                  <label> past
                    <select>
                      <option value="1">week</option>
                      <option value="2">month</option>
                      <option value="3">3 months</option>
                      <option value="4">year</option>
                    </select> of transactions
                  </label>
            </fieldset>    
          </div>      
        </p>
        
<%    }
    } catch (SQLException e) { %>
    <p>
<%    
      out.println("Could not retrieve the transaction history for this portfolio.");
      out.println(e.getMessage());
%>
    </p>  
<%  } %>

<%  try {
      String PID = (String) request.getParameter("pid");
%>
      <p align="center">
        <a href="portfolio.jsp?pid=<%=PID %>">Return to portfolio.</a>
      </p>
<%  } catch (Exception e) {
	      out.println(e);
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
