

   CREATE TABLE zepto_(
   	sku_id SERIAL  PRIMARY KEY,
	category VARCHAR(30),
	name VARCHAR(130) NOT NULL,
	mrp  NUMERIC(8,2),
	discountpercent   NUMERIC(5,2),
	availablequantity INTEGER,
	discountsellingprice NUMERIC(8,2),
	weightInGms   INTEGER,
	outOfStock    BOOLEAN,
	quantity      INTEGER
 );



 	SELECT * FROM zepto_

--TOTAL COUNT OF ROWS 
  SELECT COUNT(*) FROM zepto_;
  
--FINDING NULL VALUES
	SELECT * FROM zepto_
	WHERE name IS NULL
		or
	category IS NULL
		OR
    mrp IS NULL
		or
	 discountpercent IS NULL
		or
	 availablequantity IS NULL
		or
	 weightingms IS NULL
	    OR
	outofstock IS NULL
	    OR
	 quantity IS NULL

  
--UNIQUE CATEGORY
 SELECT DISTINCT category FROM zepto_
 ORDER BY category;

--PRODUCT IN STOCK VS OUT OF STOCK 

  SELECT outofstock,COUNT(sku_id) FROM zepto_
  GROUP BY outofstock

 --PRODUCT NAME PRESENT MULTIPLE TIMES
  SELECT name,count(sku_id) AS total_count from zepto_
  GROUP BY name
  HAVING COUNT(sku_id)>1
  ORDER BY total_count DESC
 
-- PRODUCT PRICE WITH = 0

   SELECT * FROM zepto_
   	WHERE mrp = 0 OR discountedsellingprice = 0


	DELETE FROM zepto_
	WHERE mrp = 0 

---RENAME THE COLUMN NAME 
  
   ALTER TABLE zepto_
   RENAME COLUMN discountsellingprice TO discountedsellingprice;



  -- COVERTS PAISE TO RUPEES

  UPDATE zepto_
  SET mrp = mrp/100.0,discountedsellingprice =discountedsellingprice/100.0

   SELECT mrp,discountedsellingprice FROM zepto_


  -- Q1. Find the top 10 best-value products based on the discount percentage.

    SELECT DISTINCT name,mrp,discountpercent FROM zepto_
	ORDER BY discountpercent DESC 
	LIMIT 10
  

   --Q2.What are the Products with High MRP but Out of Stock

      SELECT DISTINCT name,mrp FROM zepto_
	  WHERE outofstock = 'True' AND  mrp>300
      ORDER BY mrp DESC
   
    --Q3.Calculate Estimated Revenue for each category

	  SELECT category,sum(discountedsellingprice * availablequantity) AS total_revenue FROM zepto_
	  GROUP BY category 
	  ORDER BY total_revenue


   -- Q4. Find all products where MRP is greater than ₹500 and discount is less than 10%.

        SELECT DISTINCT name, mrp, discountPercent
		FROM zepto_
		WHERE mrp > 500 AND discountPercent < 10
		ORDER BY mrp DESC, discountPercent DESC;


    -- Q5. Identify the top 5 categories offering the highest average discount percentage.

	 SELECT category,ROUND(AVG(discountpercent),2) AS  highest_discount 
	 FROM zepto_
	 GROUP BY category
	 ORDER BY highest_discount DESC
	 LIMIT 5

   --Q6.Which product has sold the most?

    SELECT name,
    SUM(quantity) AS total_quantity_sold
	FROM zepto_
	GROUP BY name
	ORDER BY total_quantity_sold DESC
	LIMIT 1;
     

    select * from zepto_

 --  Q6. Find the price per gram for products above 100g and sort by best value.

     SELECT DISTINCT name, weightInGms, discountedSellingPrice,
	ROUND(discountedSellingPrice/weightInGms,2) AS price_per_gram
	FROM zepto_
	WHERE weightInGms >= 100
	ORDER BY price_per_gram;


    --Q7.Group the products into categories like Low, Medium, Bulk.
	 
     SELECT DISTINCT name,weightingms,
	 CASE 
	   WHEN weightingms < 1000 THEN 'Low'
	   WHEN weightingms < 5000 THEN  'Medium'
	   ELSE 'Bulk'
      END  AS weight_category
	  FROM zepto_

    --Q8.What is the Total Inventory Weight Per Category

	   SELECT category,SUM(weightingms * availablequantity)  AS total_inventory
	   FROM zepto_
       GROUP BY category
	   ORDER BY total_inventory

     --Q9. Which categories have the lowest average available inventory?

	   SELECT category,ROUND(avg(availablequantity),2) as avg_inventory from zepto_
	   GROUP BY category
	   ORDER BY avg_inventory
	   LIMIT 1
     select * from zepto_

    --Q10. Which products have low discounts but high sales?
	SELECT
    name,
    discountPercent,
    quantity
	FROM zepto_
	WHERE discountPercent < 10
	ORDER BY quantity DESC
	LIMIT 5;

  --Q11. Which category has the highest revenue but also the highest discount?
   WITH category_stats AS (
    SELECT
        Category,
        SUM(discountedSellingPrice * quantity) / 100.0 AS total_revenue,
        AVG(discountPercent) AS avg_discount
    FROM zepto_
    GROUP BY Category
)
	SELECT *
	FROM category_stats
	WHERE total_revenue = (SELECT MAX(total_revenue) FROM category_stats)
	   OR avg_discount = (SELECT MAX(avg_discount) FROM category_stats);



--OR

	SELECT
    Category,
    ROUND(SUM(discountedSellingPrice * quantity)/ 100.0,2) AS total_revenue,
    ROUND(AVG(discountPercent),2) AS avg_discount
	FROM zepto_
	GROUP BY Category
	ORDER BY total_revenue DESC, avg_discount DESC
	LIMIT 1;




 


  