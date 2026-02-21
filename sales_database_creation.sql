CREATE DATABASE IF NOT EXISTS ga_sessions;

USE ga_sessions;

DROP TABLE IF EXISTS august2016;
CREATE TABLE august2016 (
    
    session_date DATE,
    user_id VARCHAR(255),
    visits INT,
    pageviews INT,
    transactions INT NULL,
    revenue DECIMAL(12,2) NULL,
    device VARCHAR(50),
    country VARCHAR(50)
);

SHOW VARIABLES LIKE 'local_infile';
SET GLOBAL local_infile = 1;


LOAD DATA LOCAL INFILE 'C:/Users/elbgr/OneDrive/Escritorio/sales_project/august2016.csv'
INTO TABLE august2016
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(session_date, user_id, visits, pageviews, @transactions, @revenue, device, country)
SET
  transactions = NULLIF(@transactions, ''),
  revenue      = NULLIF(@revenue, '');


DROP TABLE IF EXISTS september2016;
CREATE TABLE september2016 (
    
    session_date DATE,
    user_id VARCHAR(255),
    visits INT,
    pageviews INT,
    transactions INT NULL,
    revenue DECIMAL(12,2) NULL,
    device VARCHAR(50),
    country VARCHAR(50)
);

LOAD DATA LOCAL INFILE 'C:/Users/elbgr/OneDrive/Escritorio/sales_project/september2016.csv'
INTO TABLE september2016
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(session_date, user_id, visits, pageviews, @transactions, @revenue, device, country)
SET
  transactions = NULLIF(@transactions, ''),
  revenue      = NULLIF(@revenue, '');
  
  
 DROP TABLE IF EXISTS october2016;
CREATE TABLE october2016 (
    
    session_date DATE,
    user_id VARCHAR(255),
    visits INT,
    pageviews INT,
    transactions INT NULL,
    revenue DECIMAL(12,2) NULL,
    device VARCHAR(50),
    country VARCHAR(50)
); 


LOAD DATA LOCAL INFILE 'C:/Users/elbgr/OneDrive/Escritorio/sales_project/october2016.csv'
INTO TABLE october2016
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(session_date, user_id, visits, pageviews, @transactions, @revenue, device, country)
SET
  transactions = NULLIF(@transactions, ''),
  revenue      = NULLIF(@revenue, '');
  
  
DROP TABLE IF EXISTS november2016;
CREATE TABLE november2016 (
    
    session_date DATE,
    user_id VARCHAR(255),
    visits INT,
    pageviews INT,
    transactions INT NULL,
    revenue DECIMAL(12,2) NULL,
    device VARCHAR(50),
    country VARCHAR(50)
);  

LOAD DATA LOCAL INFILE 'C:/Users/elbgr/OneDrive/Escritorio/sales_project/november2016.csv'
INTO TABLE november2016
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(session_date, user_id, visits, pageviews, @transactions, @revenue, device, country)
SET
  transactions = NULLIF(@transactions, ''),
  revenue      = NULLIF(@revenue, '');
  
DROP TABLE IF EXISTS december2016;
CREATE TABLE december2016 (
    
    session_date DATE,
    user_id VARCHAR(255),
    visits INT,
    pageviews INT,
    transactions INT NULL,
    revenue DECIMAL(12,2) NULL,
    device VARCHAR(50),
    country VARCHAR(50)
);  

LOAD DATA LOCAL INFILE 'C:/Users/elbgr/OneDrive/Escritorio/sales_project/december2016.csv'
INTO TABLE december2016
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(session_date, user_id, visits, pageviews, @transactions, @revenue, device, country)
SET
  transactions = NULLIF(@transactions, ''),
  revenue      = NULLIF(@revenue, '');
  

DROP TABLE IF EXISTS january2017;
CREATE TABLE january2017 (
    
    session_date DATE,
    user_id VARCHAR(255),
    visits INT,
    pageviews INT,
    transactions INT NULL,
    revenue DECIMAL(12,2) NULL,
    device VARCHAR(50),
    country VARCHAR(50)
);


LOAD DATA LOCAL INFILE 'C:/Users/elbgr/OneDrive/Escritorio/sales_project/january2017.csv'
INTO TABLE january2017
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(session_date, user_id, visits, pageviews, @transactions, @revenue, device, country)
SET
  transactions = NULLIF(@transactions, ''),
  revenue      = NULLIF(@revenue, '');
  
  
  
  