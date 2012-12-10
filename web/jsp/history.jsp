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
            <li><a href="logout.jsp">Sign Out</a></li>
          </ul>
        </nav>
        
        <h3 align="center">Transaction History</h3>
        
    
<%@ page import="java.sql.SQLException, java.util.List, java.util.ArrayList, java.math.BigDecimal, db.Transaction" %>

<%-- The following locates object "db" of type "db.StockSimDB" from the
     current session.  We have created this object in the listener
     (src/listener/SessionListener.java) when the session was first
     initialized.
--%>
<jsp:useBean id="db" type="db.StockSimDB" scope="session"/>
        
<%  try {
      String username = (String) session.getAttribute("userID");
      String PID = request.getParameter("pid");
      
      if (username == null) {
%>
        <p align="center">
<%        out.println("Could not retrieve userID for current session."); %>
        </p>  
        <p align="center">
          <a href="../index.html">Please log in.</a>
        </p>  
<%    }
      else if (!db.isAuthorized(username, PID)) {
%>
        <p align="center">
<%        out.println("Access Denied - You do not own this portfolio."); %>
        </p>    
<%    } 
      else {
        try {
          String filter = request.getParameter("filter");
          String numTransactions = request.getParameter("numTransactions");
          String timeframe = request.getParameter("timeframe");
          
          List<Transaction> history = new ArrayList<Transaction>();
          if (filter == null) {
            history = db.getTransactionHistoryByNumber(PID, 5);
%>
            <p align="center">
<%          out.println("Showing the 5 most recent transactions:"); %>
            </p>
<%        }
          else if (filter.equals("numTransactions") && numTransactions != null) {
            history = db.getTransactionHistoryByNumber(PID, Math.abs(Integer.parseInt(numTransactions)));
%>
            <p align="center">
<%            out.println("Showing the " + numTransactions + " most recent transactions:"); %>
            </p>
<%        }
          else if (filter.equals("timeframe") && timeframe != null) {
            int numDays = 0;
            if (timeframe.equals("week")) {
              numDays = 7;
            } else if (timeframe.equals("month")) {
              numDays = 30;
            } else if (timeframe.equals("3 months")) {
              numDays = 90;
            } else if (timeframe.equals("year")) {
              numDays = 365;
            }
            history = db.getTransactionHistoryByTime(PID, numDays);
%>
            <p align="center">
<%            out.println("Showing transactions from within the past " + timeframe + ":"); %>
            </p>
<%        }
          
          if (history == null) {
%>
            <p align="center">
<%            out.println("Empty history - no transactions performed yet."); %>
            </p>
<%        } else if (history.size() == 0 && timeframe != null) { %>
            <p align="center">
<%            out.println("No transactions took place within the last " + timeframe + "."); %>
            </p>
<%        } else if (history.size() == 0) { %>
            <p align="center">
<%            out.println("Empty history - no transactions performed yet."); %>
            </p>
<%        } else { %>
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
    
<%            for (int i = 0; i < history.size(); i++) { 
                  Transaction t = history.get(i);
%>
                  <tr>
                    <td class="gr1"><%=t.getTime()%></td>
                    <td class="gr1"><%=t.getType() %></td>
                    <td class="gr1"><%=t.getTicker() %></td>
                    <td class="gr1"><%=Math.abs(t.getNumShares()) %></td>
                    <td class="gr1">$<%=t.getPrice() %></td>
                  </tr>
<%            } %>
              </table>
            </div>
              
            <p>
              <div align="center">
                <fieldset align="left">
                  <legend>Show: </legend>
                  <form name="history" action="history.jsp" method="get">
                    <input type="hidden" name="pid" value=<%=request.getParameter("pid") %>>
                    <input type="radio" name="filter" value="numTransactions" checked="checked">
                      <label>
                        <select name="numTransactions">
                          <option value="5">5</option>
                          <option value="10">10</option>
                          <option value="25">25</option>
                          <option value="50">50</option>
                          <option value="100">100</option>
                        </select> most recent transactions
                      </label><br>
                    <input type="radio" name="filter" value="timeframe">
                      <label> past
                        <select name="timeframe">
                          <option value="week">week</option>
                          <option value="month">month</option>
                          <option value="3 months">3 months</option>
                          <option value="year">year</option>
                        </select> of transactions
                      </label>
                    <p align="center">
                    <input type="submit" value="Update">
                    </p>
                  </form>
                </fieldset>    
              </div>      
            </p>
            
<%        }
        } catch (SQLException e) { %>
          <p>
<%    
            out.println("Could not retrieve the transaction history for this portfolio.");
            out.println(e.getMessage());
%>
          </p>  
<%      } %>

          <p align="center">
            <a href="portfolio.jsp?pid=<%=PID %>">Return to portfolio.</a>
          </p>
<%    }
    } catch (SQLException e) {
      out.println("Could not authenticate user's credentials.");
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
