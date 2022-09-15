-- CASE STATEMENTS

USE farmers_market;

SELECT *, 
	CASE booth_type
		WHEN 'standard' THEN 1
        ELSE 0
	END AS is_standard
FROM booth;

SELECT product_category_name,
	CASE 
		WHEN product_category_name LIKE '%fresh%' 
			AND product_category_name NOT LIKE '%frozen%' THEN 'Fresh'
		WHEN product_category_name LIKE '%frozen%' 
			AND product_category_name LIKE '%fresh%' THEN 'Fresh or Frozen'
        WHEN product_category_name LIKE '%pack%' THEN 'Packaged'
        ELSE 'Non-Edible'
	END AS product_category_type
FROM product_category;

SELECT DISTINCT cost_to_customer_per_qty
FROM customer_purchases;

SELECT *,
	CASE
		WHEN cost_to_customer_per_qty <= 1 THEN 'Cheap'
        WHEN cost_to_customer_per_qty > 1 
			AND cost_to_customer_per_qty <5 THEN 'Mid-range'
		WHEN cost_to_customer_per_qty >= 5 THEN 'High-end'
	END AS price_category
FROM customer_purchases;

SELECT AVG(quantity)
FROM customer_purchases;

SELECT *,
	IF(quantity > (SELECT AVG(quantity) FROM customer_purchases), 
					'Large Purchase', 
					'Normal Purchase'
		) AS purchase_type
FROM customer_purchases;

--  PIVOT TABLES

SELECT vendor_name,
	COUNT(CASE WHEN b.booth_type = 'standard' THEN booth_type ELSE NULL END) AS 'Standard',
    COUNT(CASE WHEN b.booth_type = 'large' THEN booth_type ELSE NULL END) AS 'Large',
    COUNT(CASE WHEN b.booth_type = 'small' THEN booth_type ELSE NULL END) AS 'Small'
FROM booth AS b
JOIN vendor_booth_assignments AS vba ON b.booth_number = vba.booth_number
JOIN vendor AS v ON vba.vendor_id = v.vendor_id
GROUP BY vendor_name;
