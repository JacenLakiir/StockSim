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
        
        <h3 align="center">Leaderboards</h3>
       
<%@ page import="java.sql.SQLException, java.util.List, db.LeaderBoard" %>

<%-- The following locates object "db" of type "db.StockSimDB" from the
     current session.  We have created this object in the listener
     (src/listener/SessionListener.java) when the session was first
     initialized.
--%>
<jsp:useBean id="db" type="db.StockSimDB" scope="session"/>
        
<%  try {
      List<LeaderBoard> topPortfolios = db.getLeaderBoards();
      if (topPortfolios == null || topPortfolios.size() == 0) {
%>
        <p>
<%          out.println("Empty leaderboards - no portfolios created yet."); %>
        </p>
<%    } else { %>
    <div class="table">
      <table>
        <tr>
          <th>Rank</th>
          <th>Username</th>
          <th>Portfolio</th>
          <th>Market Value</th>
        </tr>
<%  for (int i = 0; i < topPortfolios.size(); i++) { 
      LeaderBoard lb = topPortfolios.get(i);
%>
      <tr>
        <td class=<%=(i % 2 == 0) ? "gr1" : "gr1alt"%>>
          <%=i+1 %>
        </td>
        <td class=<%=(i % 2 == 0) ? "gr1" : "gr1alt"%>>
          <%=lb.getUsername() %>
        </td>
        <td class=<%=(i % 2 == 0) ? "gr1" : "gr1alt"%>>
          <%=lb.getPortfolioName() %>
        </td>
        <td class=<%=(i % 2 == 0) ? "gr1" : "gr1alt"%>>
          $<%=lb.getMarketValue() %>
        </td>
      </tr>
<%    } %>
      </table>
    </div>
    <br>
<%    }
  } catch (SQLException e) { %>
    <p>
<%    
    out.println("Could not retrieve leaderboards.");
    out.println(e.getMessage());
%>
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
