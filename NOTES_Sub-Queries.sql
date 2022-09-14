-- Sub-Queries

USE farmers_market;

-- CREATE TABLE
SELECT *
FROM (
	SELECT *
	FROM customer
	) AS table_name;
    
-- find AVG MIN TEMP of 54.32    
    SELECT FORMAT(AVG(market_min_temp), 2)
    FROM market_date_info;
    
-- SCALER (single value)
SELECT *
FROM market_date_info
WHERE market_min_temp < (SELECT AVG(market_min_temp)
							FROM market_date_info)
ORDER BY market_min_temp DESC;

-- COLUMNS (list)
SELECT vendor_id
FROM vendor_booth_assignments
WHERE market_date = '2019-04-03';

SELECT *
FROM vendor
WHERE vendor_id IN(1, 2, 3);

SELECT *
FROM vendor
WHERE vendor_id IN(
					SELECT vendor_id
					FROM vendor_booth_assignments
					WHERE market_date = '2019-04-03'
                    );
                    
-- Row (single value)
SELECT customer_id
FROM customer_purchases
ORDER BY market_date ASC, transaction_time ASC
LIMIT 1;

SELECT *
FROM customer
WHERE customer_id = '9';

SELECT *
FROM customer
WHERE customer_id = (SELECT customer_id
						FROM customer_purchases
						ORDER BY market_date ASC, transaction_time ASC
						LIMIT 1);
                        
-- TABLE
SELECT *
FROM customer;

SELECT *
FROM(SELECT *
		FROM customer) AS C