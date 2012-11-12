==========================
         StockSim

by Eric Mercer & David Liu
==========================

Our sample database creation and query scripts can be run in PostgreSQL on the class virtual machine. They are located in the 'samples' folder.

To create and load the sample database, run:
	psql -af CREATE-SAMPLE.sql > CREATE-SAMPLE.out

To run sample database queries for supplying dynamic web content, run:
	psql -af TEST-SAMPLE.sql > TEST-SAMPLE.out

To view the output of the sample database query script, open 'TEST-SAMPLE.out'.

----------

A canned demo version of the website can be found in the 'web' folder.

To view the login / account-creation process, open index.html and then follow the "First Time? ..." link.

To view the rest of the website (post-login), open home.html and navigate from there. Note that some URLs are dead (do nothing) and that all pages are static and use placeholder data.

----------

Planned application/database stack:
  - Tomcat
  - PostgreSQL
  - Java/JSP/Servlets/JDBC
  - HTML/CSS
