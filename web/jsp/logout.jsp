<html>
<head>
  <title>Logging Out...</title>
  <link rel="stylesheet" type="text/css" href="../css/style.css" />
</head>

<body>
<div>
  <header>
    <h1>StockSim</h1>
  </header>

  <div class="content">

<% String username = request.getParameter("username"); %>
<% if (username == null) { %>
    <p align="center">
<%        out.println("Could not retrieve userID for current session."); %>
    </p>
<% }
   else {
%>
    <h3 align="center">Logging Out: <%=username%></h3>
<%
    session.setAttribute("userID", null);
   }
   response.sendRedirect("../index.html");
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
