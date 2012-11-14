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
            <li><a href="../html/leaderboards.html">Leaderboards</a></li>
          </ul>
        </nav>
        
        <h3 align="center">Home</h3>
        
<%@ page import="java.sql.SQLException, java.util.List, java.util.Collections" %>

<%-- The following locates object "db" of type "db.StockSimDB" from the
     current session.  We have created this object in the listener
     (src/listener/SessionListener.java) when the session was first
     initialized.
--%>
<jsp:useBean id="db" type="db.StockSimDB" scope="session"/>

<%  try {
    String username = (String) session.getAttribute("userID");
%>
        <p align="center">
        Welcome, <%=username %>!        
        </p>
<%  } catch (Exception e) { %>
    <p>
<%    
    out.println("Could not retrieve userID for current session.");
    out.println(e.getMessage());
%>
    </p>    
<%  } %>
        
<%  try {
    String username = (String) session.getAttribute("userID");
    List<String> portfolioNames = db.getPortfolioNames(username);
    Collections.sort(portfolioNames);
%>
    <div class="table">
      <table>
        <tr>
          <th>Portfolio</th>
          <th>Market Value</th>
        </tr>
<%    for (int i = 0; i < portfolioNames.size(); i++) { %>
      <tr>
        <td class=<%=(i % 2 == 0) ? "gr1" : "gr1alt"%>>
          <a href="../html/portfolio.html"><%=portfolioNames.get(i)%></a>
        </td>
        <td class=<%=(i % 2 == 0) ? "gr1" : "gr1alt"%>>
          <%--TODO: calculate market value from Yahoo! Finance data --%>
          $0
        </td>
      </tr>
<%    } %>
      </table>
    </div>
<%  } catch (SQLException e) { %>
    <p>
<%    
    out.println("Could not retrieve the user's portfolios.");
    out.println(e.getMessage());
%>
    </p>  
<%  } %>
        <p>
          <div align="center">
            <form>
              <input type="button" onClick="parent.location='../html/newPortfolio.html'" value="Create New Portfolio">
            </form>
          </div>
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
