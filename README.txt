==========================
         StockSim

by Eric Mercer & David Liu
==========================

NOTE: All tasks should be performed on the class virtual machine.

After importing the zip file's contents into a Java project using Eclipse for Java Developers, go to:

  Properties-->Java Build Path-->Libraries-->Add Library

Then select:

  Server Runtime-->Apache Tomcat v6.0-->Finish-->OK.

Our production dataset can be created by running 'ProductionDatasetGenerator.java' located in the 'src/production' folder. This will create a file called CREATE-PRODUCTION.sql in the top-level 'production' folder. From this folder, all the database scripts can be executed.

To create the database schema and load the production dataset into the database, run:
  psql -af CREATE-DATABASE.sql
  psql -af CREATE-PRODUCTION.sql

The website then needs to be deployed to the local Tomcat server. From the top-level of the project, run:
  ant deploy

In Chromium, open 'tomcat.my.net/stocksim/' to access the website Login as 'User#' where # is between 0 and 99 (inclusive) using the password 'password'. Alternatively, create a new user account.
