-- connect to databASe
\c stocksim

-- get pASsword ASsociated with some username for login authentification
SELECT pASsword
FROM Users
WHERE username='User50';

-- get home page info after login
SELECT portfolio_name
FROM Portfolio
WHERE username = 'User38';

-- retrieve info on some particular portfolio
SELECT ticker, num_shares, avg_price_bought
FROM Stock_Holdings
WHERE PID='P7';

-- sort portfolio by some attribute
SELECT ticker, num_shares, avg_price_bought
FROM Stock_Holdings
WHERE PID='P89'
ORDER BY ticker DESC;

-- get top 10 portfolios in terms of cash
-- will change to market value in real implementation
-- right now market value doesn't make sense because price is dynamically obtained in realtime FROM Yahoo! Finance)
SELECT PID, portfolio_name, cash 
FROM Portfolio
ORDER BY cash DESC
Limit 10;

-- computes the market value of a portfolio (defined AS cash + total value of stocks)
-- NOTE: ASsumes the price of all stocks to be 50; actual webpage will dynamically obtain the price in realtime FROM Yahoo! Finance
SELECT portfolio.PID, cash+(SELECT SUM(values) FROM (SELECT 50*num_shares AS VALEUS FROM stock_holdings WHERE PID='P60') AS mktvalue, portfolio WHERE portfolio.PID='P60') AS Mkt_Value FROM portfolio WHERE PID='P60';

-- computes the market value of all portfolios in the database and sorts them to display the TOP 10 Portfolios in terms of Market Value
-- NOTE: again, 50 is used for the price of stocks.
SELECT portfolio.PID, portfolio.cash + stock_value.values AS Mkt_Value FROM (SELECT PID, Sum(50*num_shares) AS values FROM stock_holdings Group By PID) AS stock_value, portfolio WHERE portfolio.PID = stock_value.PID ORDER BY Mkt_Value DESC LIMIT 10;

-- get transaction history for a particular portfolio
SELECT ticker, num_shares, price, type, time 
FROM TRANSACTION
WHERE PID='P23';
