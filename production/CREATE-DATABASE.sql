-- destroy database
DROP DATABASE stocksim;

--create database
CREATE DATABASE stocksim;
GRANT ALL PRIVILEGES ON DATABASE stocksim TO ubuntu;
\c stocksim

-- destroy tables
DROP TABLE Users CASCADE;
DROP TABLE Portfolio CASCADE;
DROP TABLE Stock_Holdings CASCADE;
DROP TABLE Transaction CASCADE;
DROP FUNCTION exec_Transaction() CASCADE;
DROP FUNCTION check_Portfolio_Name() CASCADE;

-- create tables
CREATE TABLE Users(
  username VARCHAR(30) NOT NULL PRIMARY KEY CHECK(char_length(username)>=4),
  password VARCHAR(30) NOT NULL CHECK(char_length(password)>=5),
  email VARCHAR(30) NOT NULL UNIQUE CHECK(email LIKE '%@%.%')
);
  
CREATE TABLE Portfolio(
  PID VARCHAR(30) NOT NULL PRIMARY KEY,
  portfolio_name VARCHAR(30) NOT NULL,
  username VARCHAR(30) NOT NULL REFERENCES Users(username),
  time_created TIMESTAMP NOT NULL,
  cash NUMERIC(1000,2) NOT NULL CHECK(cash>=0)
);

CREATE TABLE Stock_Holdings(
  PID VARCHAR(30) NOT NULL REFERENCES Portfolio(PID) ON DELETE CASCADE,
  ticker VARCHAR(10) NOT NULL,
  num_shares INTEGER NOT NULL CHECK(num_shares>=0),
  avg_price_bought NUMERIC(1000,2) NOT NULL,
  PRIMARY KEY(PID, Ticker)
);

CREATE TABLE Stock_Prices(
  ticker VARCHAR(10) NOT NULL,
  price NUMERIC(1000,2) NOT NULL
);

CREATE TABLE Transaction(
  PID VARCHAR(30) REFERENCES Portfolio(PID) ON DELETE CASCADE,
  ticker VARCHAR(10) NOT NULL,
  num_shares INTEGER NOT NULL,
  price NUMERIC(1000,2) NOT NULL,
  type VARCHAR(30) NOT NULL CHECK(type='Buy' OR type='Sell'),
  time TIMESTAMP NOT NULL,
  PRIMARY KEY(PID, time)
);

CREATE FUNCTION exec_Transaction() RETURNS trigger AS $exec_Transaction$
  DECLARE
    current_cash NUMERIC(1000,2);
    current_num_shares NUMERIC(1000,2);
    current_avg_price NUMERIC(1000,2);

  BEGIN
    IF new.price<=0 THEN
      RAISE EXCEPTION 'INVALID TICKER';
    END IF;
  
    IF NOT EXISTS (SELECT ticker FROM Stock_Holdings WHERE PID=new.PID AND ticker=new.ticker) THEN
      INSERT INTO Stock_Holdings VALUES(new.PID, new.ticker, 0, 0);
    END IF;
  
    SELECT cash INTO current_cash FROM Portfolio WHERE PID=new.PID;
    SELECT num_shares INTO current_num_shares FROM Stock_Holdings WHERE PID=new.PID AND ticker=new.ticker;
    SELECT avg_price_bought INTO current_avg_price FROM Stock_Holdings WHERE PID=new.PID AND ticker=new.ticker;
    
    IF new.type='Buy' AND (new.price*new.num_shares) > current_cash THEN
      RAISE EXCEPTION 'NOT ENOUGH CASH TO EXECUTE TRANSACTION';
    ELSIF new.type='Sell' AND  (current_num_shares < (-1*new.num_shares)) THEN
      RAISE EXCEPTION 'NOT ENOUGH SHARES TO EXECUTE TRANSACTION';
    ELSE
      UPDATE Portfolio SET cash=cash-(new.Price*new.num_shares) WHERE PID=new.PID;
      UPDATE Stock_Holdings SET num_shares=num_shares+new.num_shares WHERE PID=new.PID AND ticker=new.ticker;
      IF new.type='Buy' THEN
        UPDATE Stock_Holdings SET avg_price_bought=(new.num_shares*new.price+current_num_shares*current_avg_price)/(new.num_shares+current_num_shares)
          WHERE PID=new.PID AND ticker=new.ticker;
      END IF;
    END IF;
  
    DELETE FROM Stock_Holdings WHERE num_shares=0;
  
    IF NOT EXISTS (SELECT * FROM Stock_Prices WHERE ticker=new.ticker) THEN
      INSERT INTO Stock_Prices VALUES (new.ticker, new.price);
    END IF;
    
    DELETE FROM Stock_Prices WHERE ticker NOT IN (SELECT ticker FROM Stock_Holdings);

    RETURN NEW;
    END;
$exec_Transaction$ LANGUAGE plpgsql;

CREATE FUNCTION check_Portfolio_Name() RETURNS trigger AS $check_Portfolio_Name$
  BEGIN
    IF EXISTS (SELECT portfolio_name FROM Portfolio WHERE username=new.username AND portfolio_name=new.portfolio_name AND PID<>new.PID) THEN
      RAISE EXCEPTION 'PORTFOLIO NAME ALREADY EXISTS FOR USER';
    END IF;
    
        RETURN NEW;
    END;
$check_Portfolio_Name$ LANGUAGE plpgsql;

CREATE TRIGGER exec_Transaction
AFTER INSERT OR UPDATE ON Transaction
FOR EACH ROW EXECUTE PROCEDURE exec_Transaction(); 

CREATE TRIGGER check_Portfolio_Name
BEFORE INSERT ON Portfolio
FOR EACH ROW EXECUTE PROCEDURE check_Portfolio_Name(); 
