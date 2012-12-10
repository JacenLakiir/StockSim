==========================
         StockSim

by Eric Mercer & David Liu
==========================

NOTE: All tasks should be performed on the class virtual machine. All scripts should be run from the top-level directory of the project.

1) Importing the zip file's contents into a Java project using Eclipse for Java Developers.

2) Add the Tomcat library to the build path by right-clicking on the project and selecting:

      Properties --> Java Build Path --> Libraries --> Add Library
   
   Then select:
       
      Server Runtime --> Apache Tomcat v6.0 --> Finish --> OK.

3) Create the database and load the production dataset into the database by running:
      
      psql -af production/CREATE-DATABASE.sql
      psql -af production/CREATE-PRODUCTION.sql

4) Compile and deploy the application to the local Tomcat server by running:
      
      ant deploy

5) Open Chromium and go to 'tomcat.my.net/stocksim/' to access the website.

6) Login as 'User#' where # is in the range [0, 99] using the password 'password'. Alternatively, create a new user account.
