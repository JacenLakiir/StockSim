-- NOTE: some queries cannot currently be written since they rely on stock data from
--		 Yahoo! Finance, such as stock data requests, leaderboards, and market value
--		 calculations; these require the use of a host language such as Java or Python in
--		 conjunction with queries to the website database, which is beyond the scope of
--		 Milestone 1 as described in the project requirements

-- create new account from new account form
INSERT INTO Users VALUES('StockSimUser', 'awesome_password', 'person@gmail.com');

-- create new portfolio with some user-assigned portfolio name
INSERT INTO Portfolio VALUES('P81', 'Tech Investments', 'StockSimUser', 10000);

-- perform buy/sell transaction for some number of shares for some stock
INSERT INTO Transaction VALUES('P81', 'GOOG', 100, 37.93, 'Buy', now());

-- get password associated with some username for login authentification
SELECT password
FROM Users
WHERE username='StockSimUser';

-- get home page info after login
SELECT portfolio_name
FROM Portfolio
WHERE username = 'User1';

-- retrieve info on some particular portfolio
SELECT ticker, num_shares, avg_price_bought
FROM Stock_Holdings
WHERE PID='P1';

-- sort portfolio by some attribute
SELECT ticker, num_shares, avg_price_bought
FROM Stock_Holdings
WHERE PID='P1'
ORDER BY num_shares DESC;

-- retrieve some number of recent transactions or transactions within some time period
SELECT time, type, ticker, num_shares, price
FROM Transaction
WHERE PID='P1'
ORDER BY time DESC
LIMIT 3;
