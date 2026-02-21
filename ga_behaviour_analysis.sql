USE ga_sessions;

DESCRIBE ga_all_sessions;

CREATE VIEW ga_all_sessions AS
SELECT session_date, country, transactions, revenue FROM august2016
UNION ALL
SELECT session_date, country, transactions, revenue FROM september2016
UNION ALL
SELECT session_date, country, transactions, revenue FROM october2016
UNION ALL
SELECT session_date, country, transactions, revenue FROM november2016
UNION ALL
SELECT session_date, country, transactions, revenue FROM december2016
UNION ALL
SELECT session_date, country, transactions, revenue FROM january2017;

SELECT * FROM ga_all_sessions;

SELECT
    country,
    COUNT(*) AS sessions
FROM ga_all_sessions
GROUP BY country
ORDER BY sessions DESC
LIMIT 3;

SELECT
    country,
    SUM(revenue) AS total_revenue
FROM ga_all_sessions
GROUP BY country
ORDER BY total_revenue DESC
LIMIT 3;

-- I selected a specific column from the dataset to create the agg column. That column must appear in the SELECT/UNION ALL query 
-- For the other Query I select every column from the dataset so I didn't have to include it in the SELECT/UNION ALL

-- CONCLUSION: USA is the core market, India and Vietnam= low monetization traffic, Venezuela, Canada= high value, low volume
-- REVENUE PER SESSION:
SELECT
    country,
    SUM(revenue) / COUNT(*) AS revenue_per_session
FROM ga_all_sessions
GROUP BY country
ORDER BY revenue_per_session DESC
LIMIT 3;


-- While the United States remains the primary market in terms of volume, several countries such as Venezuela, Curaçao, and Kenya show significantly higher revenue per session. 
-- This suggests the presence of high-value but low-volume markets, which require transaction-level analysis to assess scalability and customer behavior. 
-- To investigate this, Stripe payment data is integrated.

SELECT 
 country, 
 SUM(revenue) AS total_revenue, 
 YEAR(session_date) AS year,
 MONTH(session_date) AS month
FROM ga_all_sessions
WHERE country = 'United States'
GROUP BY YEAR(session_date), MONTH(session_date)
ORDER BY year,month;

SELECT 
 country, 
 COUNT(*) AS sessions, 
 YEAR(session_date) AS year,
 MONTH(session_date) AS month
FROM ga_all_sessions
WHERE country = 'United States'
GROUP BY YEAR(session_date), MONTH(session_date)
ORDER BY year,month;

-- Conversion rate: How often a session turn into a purchase?

SELECT 
 country, 
 SUM(transactions) / COUNT(*) AS conversion_rate, 
 YEAR(session_date) AS year,
 MONTH(session_date) AS month
FROM ga_all_sessions
WHERE country = 'United States'
GROUP BY YEAR(session_date), MONTH(session_date)
ORDER BY year,month;

-- “Google Analytics shows that conversion rates in the core market (USA) remain relatively stable over time. 
-- However, revenue per session varies significantly across countries, suggesting that monetization differences
-- are driven by order value and payment behavior rather than traffic efficiency. To investigate this further, 
-- Stripe transaction-level data is required.”

SELECT 
 country, 
 SUM(transactions) / COUNT(*) AS conversion_rate, 
 YEAR(session_date) AS year,
 MONTH(session_date) AS month
FROM ga_all_sessions
WHERE country = 'Venezuela'
GROUP BY YEAR(session_date), MONTH(session_date)
ORDER BY year,month;

-- Which countries have the most volatile revenue?
SELECT
  country,

  SUM(CASE 
        WHEN DATE_FORMAT(session_date, '%Y-%m') = '2016-08'
        THEN revenue ELSE 0 
      END) AS rev_2016_08,

  SUM(CASE 
        WHEN DATE_FORMAT(session_date, '%Y-%m') = '2016-09'
        THEN revenue ELSE 0 
      END) AS rev_2016_09,

  SUM(CASE 
        WHEN DATE_FORMAT(session_date, '%Y-%m') = '2016-10'
        THEN revenue ELSE 0 
      END) AS rev_2016_10,

  SUM(CASE 
        WHEN DATE_FORMAT(session_date, '%Y-%m') = '2016-11'
        THEN revenue ELSE 0 
      END) AS rev_2016_11,

  SUM(CASE 
        WHEN DATE_FORMAT(session_date, '%Y-%m') = '2016-12'
        THEN revenue ELSE 0 
      END) AS rev_2016_12,

  SUM(CASE 
        WHEN DATE_FORMAT(session_date, '%Y-%m') = '2017-01'
        THEN revenue ELSE 0 
      END) AS rev_2017_01

FROM ga_all_sessions
GROUP BY country
ORDER BY
  (rev_2016_08 + rev_2016_09 + rev_2016_10 + rev_2016_11 + rev_2016_12 + rev_2017_01) DESC;
  
  
  
  
  -- Is volatility driven by traffic swings or conversion swings?
-- first, we check the conversion rate per month

SELECT
  country,
  SUM(CASE WHEN DATE_FORMAT(session_date, '%Y-%m') = '2016-08'
	THEN transactions ELSE 0 END)/COUNT(*) AS conversion_2016_08,
    
  SUM(CASE WHEN DATE_FORMAT(session_date, '%Y-%m') = '2016-09'
	THEN transactions ELSE 0 END)/COUNT(*) AS conversion_2016_09,

  SUM(CASE WHEN DATE_FORMAT(session_date, '%Y-%m') = '2016-10'
	THEN transactions ELSE 0 END)/COUNT(*) AS conversion_2016_10,

  SUM(CASE WHEN DATE_FORMAT(session_date, '%Y-%m') = '2016-11'
	THEN transactions ELSE 0 END)/COUNT(*) AS conversion_2016_11,
  
  SUM(CASE WHEN DATE_FORMAT(session_date, '%Y-%m') = '2016-12'
    THEN transactions ELSE 0 END)/COUNT(*) AS conversion_2016_12,

  SUM(CASE WHEN DATE_FORMAT(session_date, '%Y-%m') = '2017-01'
    THEN transactions ELSE 0 
END)/COUNT(*) AS conversion_2017_01
      
FROM ga_all_sessions
GROUP BY country
ORDER BY
  (conversion_2016_08 + conversion_2016_09 + conversion_2016_10 + conversion_2016_11 + conversion_2016_12 + conversion_2017_01) DESC;




-- Then, we check the traffic:

SELECT
  country,

  COUNT(CASE WHEN DATE_FORMAT(session_date, '%Y-%m') = '2016-08'
        THEN transactions ELSE 0 END) AS visits_2016_08,

  COUNT(CASE WHEN DATE_FORMAT(session_date, '%Y-%m') = '2016-09'
        THEN transactions ELSE 0 END) AS visits_2016_09,

  COUNT(CASE WHEN DATE_FORMAT(session_date, '%Y-%m') = '2016-10'
        THEN transactions ELSE 0 END) AS visits_2016_10,

  COUNT(CASE WHEN DATE_FORMAT(session_date, '%Y-%m') = '2016-11'
        THEN transactions ELSE 0 END) AS visits_2016_11,

  COUNT(CASE WHEN DATE_FORMAT(session_date, '%Y-%m') = '2016-12'
        THEN transactions ELSE 0 END) AS visits_2016_12,

  COUNT(CASE WHEN DATE_FORMAT(session_date, '%Y-%m') = '2017-01'
        THEN transactions ELSE 0 END) AS visits_2017_01

FROM ga_all_sessions
GROUP BY country
ORDER BY
  (visits_2016_08 + visits_2016_09 + visits_2016_10 + visits_2016_11 + visits_2016_12 + visits_2017_01) DESC;
  
-- Revenue standard deviation by country
SELECT
  country,
  AVG(monthly_revenue) AS avg_monthly_revenue,
  STDDEV_POP(monthly_revenue) AS stddev_monthly_revenue,
  STDDEV_POP(monthly_revenue) / NULLIF(AVG(monthly_revenue), 0) AS coeff_variation
FROM (
  SELECT
    country,
    YEAR(session_date) AS year,
    MONTH(session_date) AS month,
    SUM(revenue) AS monthly_revenue
  FROM ga_all_sessions
  GROUP BY country, year, month
) t
GROUP BY country
HAVING AVG(monthly_revenue) > 0
ORDER BY coeff_variation DESC;

-- High CV → volatile market (risky, inconsistent)

SELECT
  country,
  COUNT(*) AS sessions,
  COALESCE(SUM(transactions) / COUNT(*), 0) AS conversion_rate,
  COALESCE(SUM(revenue) / COUNT(*), 0) AS revenue_per_session
FROM ga_all_sessions
WHERE country IS NOT NULL
  AND country != '(not set)'
GROUP BY country
ORDER BY
  sessions DESC,
  conversion_rate DESC,
  revenue_per_session DESC;
  
-- How much of a country’s revenue comes from top X% of sessions?

WITH ranked_sessions AS (
  SELECT
    country,
    revenue,
    ROW_NUMBER() OVER (
      PARTITION BY country
      ORDER BY revenue DESC
    ) AS rn,
    COUNT(*) OVER (
      PARTITION BY country
    ) AS total_sessions
  FROM ga_all_sessions
  WHERE revenue IS NOT NULL
)

SELECT
  country,
  SUM(revenue) AS total_revenue,
  SUM(CASE WHEN rn <= total_sessions * 0.10
        THEN revenue
        ELSE 0
      END) AS top_10pct_revenue,
  SUM(CASE WHEN rn <= total_sessions * 0.10
	THEN revenue
	ELSE 0
    END) / SUM(revenue) AS revenue_share_top_10pct

FROM ranked_sessions
GROUP BY country
ORDER BY revenue_share_top_10pct DESC;

-- Device impact on the conversion.

CREATE VIEW ga_core_market AS
SELECT session_date, country, transactions, revenue, device 
FROM august2016
WHERE country='United States'
UNION ALL
SELECT session_date, country, transactions, revenue, device 
FROM september2016
WHERE country='United States'
UNION ALL
SELECT session_date, country, transactions, revenue, device 
FROM october2016
WHERE country='United States'
UNION ALL
SELECT session_date, country, transactions, revenue, device 
FROM november2016
WHERE country='United States'
UNION ALL
SELECT session_date, country, transactions, revenue, device 
FROM december2016
WHERE country='United States'
UNION ALL
SELECT session_date, country, transactions, revenue, device 
FROM january2017
WHERE country='United States';

SELECT SUM(revenue)/COUNT(*) AS conversion_rate,device
FROM ga_core_market
GROUP BY device
ORDER BY conversion_rate DESC;





  
  
  
  



