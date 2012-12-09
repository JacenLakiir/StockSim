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
        
        <h3 align="center">Buy/Sell Stock</h3>
        
        
        <p>
          <div align="center">
            <fieldset align="left">
              <legend>Transactions</legend>
              <form name="perform-transaction" action="../jsp/perform-transaction.jsp" method="get">
                <input type="hidden" name="pid" value=<%=(String) request.getParameter("pid") %>>
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
      </div>
      
      <footer>
        <p>
          &copy; Copyright 2012 by Eric Mercer &amp; David Liu
        </p>
      </footer>
    </div>
  </body>
</html>
