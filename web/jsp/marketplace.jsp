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
        
        <h3 align="center">Buy/Sell Stock</h3>
       
<%@ page import="java.sql.SQLException" %>

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
%> 
        <p>
          <div align="center">
            <fieldset align="left">
              <legend>Transactions</legend>
              <form name="perform-transaction" action="../jsp/perform-transaction.jsp" method="get">
                <input type="hidden" name="pid" value=<%=PID %>>
                <select name="type">
                  <option value="Buy">buy</option>
                  <option value="Sell">sell</option>
                </select>
                <input type="number" name="numShares" min="1" step="1" dir="ltr" required="required" size="5"> share(s) of
                <input type="text" name="ticker" placeholder="GOOG" required="required" size="5">
                <input type="submit" value="Submit">
              </form>
            </fieldset>
          </div>
        </p>      
      
        <p align="center">
          <a href="portfolio.jsp?pid=<%=request.getParameter("pid") %>">Return to portfolio.</a>
        </p>  
      </div>
<%      }
      } catch (SQLException e) { %>
          <p>
<%    
            out.println("Could not authenticate user's credentials.");
            out.println(e.getMessage());
%>
          </p>  
<%    } %>
      </div>
      
      <footer>
        <p>
          &copy; Copyright 2012 by Eric Mercer &amp; David Liu
        </p>
      </footer>
    </div>
  </body>
</html>
