==========================
         StockSim

by Eric Mercer & David Liu
==========================

Our production dataset can be created by running 'ProductionDatasetGenerator.java' located in the 'src/production' folder. This will create a file called CREATE-PRODUCTION.sql in the top-level 'productions' folder. From this folder, all the database scripts can be executed.

To create the database schema, run:
  psql -af CREATE-DATABASE.sql

To load the production dataset into the database, run:
  psql -af CREATE-PRODUCTION.sql

To run sample database queries on the production dataset, run:
  psql -af TEST-PRODUCTION.sql > TEST-PRODUCTION.out

To view the output of the sample database query script, open 'TEST-PRODUCTION.out'.

----------

To view the website-in-progress on the virtual machine, run 'ant deploy' and open 'tomcat.my.net/stocksim/' in Chromium.

Login as 'User#' where # is between 0 and 99 (inclusive). The password is 'password'.

Note that some parts of the website have not yet been implemented and are still static / using mock data.
