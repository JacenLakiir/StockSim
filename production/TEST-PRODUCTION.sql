-- connect to database
\c stocksim

-- get password associated with some username for login authentification
SELECT password
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
-- right now market value doesn't make sense because price is dynamically obtained in realtime from Yahoo! Finance)
SELECT PID, portfolio_name, cash 
FROM Portfolio
ORDER BY cash DESC
LIMIT 10;

-- computes the market value of a portfolio (defined as cash + total value of stocks)
-- NOTE: assumes the price of all stocks to be $50; actual webpage will dynamically obtain the price in realtime from Yahoo! Finance
SELECT portfolio.PID, cash+(SELECT SUM(values) FROM (SELECT 50*num_shares AS VALUES FROM stock_holdings WHERE PID='P60') AS mktvalue, portfolio WHERE portfolio.PID='P60') AS Mkt_Value FROM portfolio WHERE PID='P60';

-- computes the market value of all portfolios in the database and sorts them to display the top 10 portfolios in terms of market value
-- NOTE: $50 is again used for the price of stocks
SELECT portfolio.PID, portfolio.cash + stock_value.values AS Mkt_Value FROM (SELECT PID, SUM(50*num_shares) AS VALUES FROM Stock_Holdings GROUP BY PID) AS stock_value, portfolio WHERE portfolio.PID = stock_value.PID ORDER BY Mkt_Value DESC LIMIT 10;

-- get transaction history for a particular portfolio
SELECT ticker, num_shares, price, type, time 
FROM Transaction
WHERE PID='P23';
