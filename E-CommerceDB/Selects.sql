-- Add check constraints to existing tables
ALTER TABLE SHOPPRODUCT 
ADD CONSTRAINT check_price_positive 
CHECK (Price > 0);

ALTER TABLE COUPON 
ADD CONSTRAINT check_valid_discount 
CHECK (DiscountAmount > 0 AND DiscountAmount <= MinOrderLimit);
-- Trigger 1: Update product rating when a new review is added
CREATE OR REPLACE FUNCTION update_product_rating()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE PRODUCT
    SET ProductRate = (
        SELECT AVG(Rate)
        FROM REVIEWS
        WHERE ProductID = NEW.ProductID
    )
    WHERE ProductID = NEW.ProductID;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER after_review_insert
AFTER INSERT ON REVIEWS
FOR EACH ROW
EXECUTE FUNCTION update_product_rating();

-- Trigger 2: Update cart total amount when items are added/modified
CREATE OR REPLACE FUNCTION update_cart_total()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE CART
    SET TotalAmount = (
        SELECT SUM(Price * Quantity)
        FROM CARTITEM
        WHERE CustomerID = NEW.CustomerID AND CartID = NEW.CartID
    ),
    UpdateDate = CURRENT_TIMESTAMP
    WHERE CustomerID = NEW.CustomerID AND CartID = NEW.CartID;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER after_cartitem_change
AFTER INSERT OR UPDATE OR DELETE ON CARTITEM
FOR EACH ROW
EXECUTE FUNCTION update_cart_total();

-- Trigger 3: Update stock when order is placed
CREATE OR REPLACE FUNCTION update_stock_after_order()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE SHOPPRODUCT
    SET Stock = Stock - NEW.Quantity
    WHERE SKU = NEW.SKU AND ProductID = NEW.ProductID AND ShopID = NEW.ShopID;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER after_order_insert
AFTER INSERT ON ORDERITEM
FOR EACH ROW
EXECUTE FUNCTION update_stock_after_order();



CREATE OR REPLACE FUNCTION update_favorite_count()
RETURNS TRIGGER AS $$
BEGIN
    -- If the collection name is 'favorites', increment the favorite count
    IF NEW.CollectionName = 'favorites' THEN
        UPDATE PRODUCT 
        SET Favorite_Count = Favorite_Count + 1
        WHERE ProductID = NEW.ProductID;
    END IF;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER increment_favorite_count
AFTER INSERT ON COLLECTIONITEMS
FOR EACH ROW
EXECUTE FUNCTION update_favorite_count();




-- INSERT statements
INSERT INTO CUSTOMER (CustomerID, Phone, Email, Password, Fname, Lname, Sex)
VALUES (6, '555-0123', 'john@example.com', 'hashedpass123', 'John', 'Doe', 'M');

INSERT INTO PRODUCT (ProductID, ProductName, Brand,Description, CategoryID)
VALUES (9,'Gaming Laptop', 'TechBrand','Very fast gaming laptop', 3);

INSERT INTO SHOP (ShopID, Phone, ShopName, ShopType)
VALUES (6, '555-9999', 'Electronics Hub', 'Electronics');

-- UPDATE statements
UPDATE CUSTOMER 
SET EliteFlag = TRUE, ElitePoint = 100 
WHERE CustomerID = 1;

UPDATE PRODUCT 
SET ProductRate = 4 
WHERE ProductID = 1;

UPDATE SHOP 
SET Description = 'Best electronics shop in town' 
WHERE ShopID = 1;

-- DELETE statements
DELETE FROM CUSTOMER
WHERE CustomerID = 6;

DELETE FROM PRODUCT
WHERE ProductID = 9;


DELETE FROM SHOP
WHERE ShopID =6;

-- Find all products and their categories
SELECT p.ProductName, c.CategoryName
FROM PRODUCT p
JOIN CATEGORY c ON p.CategoryID = c.CategoryID;

-- Find all shops and their follower count
SELECT s.ShopName, COUNT(f.CustomerID) as FollowerCount
FROM SHOP s
LEFT JOIN FOLLOWSHOPS f ON s.ShopID = f.ShopID
GROUP BY s.ShopName;

-- Find reviewed products in each category with their reviews
SELECT c.CategoryName, p.ProductName,r.Review_Comment, COUNT(r.CustomerID) as ReviewCount, ROUND(AVG(r.Rate)) as AvgRating
FROM CATEGORY c
JOIN PRODUCT p ON c.CategoryID = p.CategoryID
JOIN REVIEWS r ON p.ProductID = r.ProductID
GROUP BY c.CategoryName, p.ProductName,r.Review_Comment;



-- Find customer order history with product and shop details
SELECT c.Fname, c.Lname,o.OrderID, p.ProductName, s.ShopName, oi.Quantity, oi.Price,oi.Status
FROM CUSTOMER c
JOIN "ORDER" o ON c.CustomerID = o.CustomerID
JOIN ORDERITEM oi ON o.CustomerID = oi.CustomerID AND o.OrderID = oi.OrderID
JOIN PRODUCT p ON oi.ProductID = p.ProductID
JOIN SHOP s ON oi.ShopID = s.ShopID
ORDER BY c.fname ASC ;

--Collections per customer and products in the collections
SELECT 
    c.CustomerID,
	cu.Fname,
	cu.Lname,
    c.CollectionName,
    COUNT(ci.ProductID) as ItemCount,
    STRING_AGG(p.ProductName, ', ') as Products
FROM COLLECTIONS c
LEFT JOIN COLLECTIONITEMS ci ON c.CustomerID = ci.CustomerID 
    AND c.CollectionName = ci.CollectionName
LEFT JOIN PRODUCT p ON ci.ProductID = p.ProductID
JOIN CUSTOMER cu ON cu.CustomerID = c.CustomerID
GROUP BY c.CustomerID, c.CollectionName,cu.Fname,
	cu.Lname
ORDER BY c.CustomerID, c.CollectionName;




--Price Comparison Across Shops
WITH ProductShopCount AS (
    SELECT ProductID
    FROM SHOPPRODUCT
    GROUP BY ProductID
    HAVING COUNT(DISTINCT ShopID) > 1
)
SELECT 
    p.ProductID,
    s.ShopID,
    p.ProductName,
    p.Brand,
    v.VariantType,
    s.ShopName,
    sp.Price as OriginalPrice,
    sp.DiscountPercentage,
    ROUND(sp.Price * (1 - sp.DiscountPercentage/100), 2) as DiscountedPrice,
    sp.Stock,
    p.ProductRate,
    COUNT(r.CustomerID) as ReviewCount
FROM PRODUCT p
JOIN SHOPPRODUCT sp ON p.ProductID = sp.ProductID
JOIN SHOP s ON sp.ShopID = s.ShopID
JOIN VARIANTS v ON sp.VariantID = v.VariantID
LEFT JOIN REVIEWS r ON p.ProductID = r.ProductID AND s.ShopID = r.ShopID
JOIN ProductShopCount psc ON p.ProductID = psc.ProductID
GROUP BY p.ProductID, p.ProductName, p.Brand, v.VariantType, s.ShopID, s.ShopName, 
         sp.Price, sp.DiscountPercentage, sp.Stock, p.ProductRate
ORDER BY p.ProductID;



--Find trending products based on recent orders, ratings, and favorites:
SELECT 
    p.ProductID,
    p.ProductName,
    COUNT(DISTINCT oi.OrderID) as recent_orders,
    ROUND(AVG(r.Rate),2) as avg_rating,
    p.Favorite_Count,
    ROUND((COUNT(DISTINCT oi.OrderID) * 0.50 + COALESCE(AVG(r.Rate), 0) * 0.35 + p.Favorite_Count * 0.15),2) as trend_score
FROM PRODUCT p
LEFT JOIN ORDERITEM oi ON p.ProductID = oi.ProductID 
    AND oi.OrderID IN (
        SELECT OrderID 
        FROM "ORDER" 
        WHERE OrderedDate >= CURRENT_DATE - INTERVAL '30 days'
    )
LEFT JOIN REVIEWS r ON p.ProductID = r.ProductID
GROUP BY p.ProductID, p.ProductName, p.Favorite_Count
HAVING COUNT(DISTINCT oi.OrderID) > 0
ORDER BY trend_score DESC
LIMIT 20;


--. Stock Level Tracking Across All Shops
SELECT 
    p.ProductID,
    p.ProductName,
    p.Brand,
    s.ShopID,
    s.ShopName,
    sp.SKU,
    v.VariantType,
    sp.Stock,
    CASE 
        WHEN sp.Stock = 0 THEN 'Out of Stock'
        WHEN sp.Stock < 10 THEN 'Low Stock'
        WHEN sp.Stock < 50 THEN 'Moderate Stock'
        ELSE 'Good Stock'
    END as StockStatus,
    w.Location as WarehouseLocation
FROM PRODUCT p
JOIN SHOPPRODUCT sp ON p.ProductID = sp.ProductID
JOIN SHOP s ON sp.ShopID = s.ShopID
JOIN VARIANTS v ON sp.VariantID = v.VariantID
LEFT JOIN WAREHOUSE w ON sp.WarehouseID = w.WarehouseID
ORDER BY sp.Stock ASC;

-- Customer lifetime value analysis with their preferred categories:
SELECT 
    c.CustomerID,
    c.Email,
    COUNT(DISTINCT o.OrderID) as total_orders,
    SUM(o.TotalAmount) as lifetime_spend,
    STRING_AGG(DISTINCT cat.CategoryName, ', ') as preferred_categories,
    c.ElitePoint,
    CASE 
        WHEN c.EliteFlag AND c.PremiumFlag THEN 'Elite + Premium'
        WHEN c.EliteFlag THEN 'Elite'
        WHEN c.PremiumFlag THEN 'Premium'
        ELSE 'Regular'
    END as customer_tier
FROM CUSTOMER c
LEFT JOIN "ORDER" o ON c.CustomerID = o.CustomerID
LEFT JOIN ORDERITEM oi ON o.OrderID = oi.OrderID AND o.CustomerID = oi.CustomerID
LEFT JOIN PRODUCT p ON oi.ProductID = p.ProductID
LEFT JOIN CATEGORY cat ON p.CategoryID = cat.CategoryID
GROUP BY c.CustomerID, c.Email, c.EliteFlag, c.PremiumFlag, c.ElitePoint
ORDER BY lifetime_spend DESC;

--Find customers who have abandoned items in their cart
--(useful for follow-up marketing):
SELECT 
    c.CustomerID,
    c.Email,
    p.ProductName,
    ci.Quantity,
    ci.Price,
    cart.UpdateDate as last_cart_update
FROM CART cart
JOIN CARTITEM ci ON cart.CartID = ci.CartID AND cart.CustomerID = ci.CustomerID
JOIN CUSTOMER c ON cart.CustomerID = c.CustomerID
JOIN PRODUCT p ON ci.ProductID = p.ProductID
WHERE cart.UpdateDate < CURRENT_TIMESTAMP - INTERVAL '24 hours'
ORDER BY cart.UpdateDate DESC;

--Find which products have never been ordered 
--(helps identify potentially problematic products):
SELECT 
    p.ProductID,
    p.ProductName,
    p.Brand,
    sp.Price,
    sp.Stock,
	s.ShopName
FROM PRODUCT p
JOIN SHOPPRODUCT sp ON p.ProductID = sp.ProductID
JOIN SHOP s ON sp.ShopID = s.ShopID
WHERE p.ProductID NOT IN (
    SELECT DISTINCT ProductID 
    FROM ORDERITEM
)
ORDER BY sp.Price ASC;

-- Critical shipping analysis and delivery performance:
SELECT 
    sh.Carrier,
    COUNT(DISTINCT so.ShipmentID) as total_shipments,
    ROUND(AVG(EXTRACT(EPOCH FROM (sh.Est_Delivery_Date - o.OrderedDate))/86400)) as avg_delivery_days,
    SUM(CASE 
        WHEN sh.ShipStatus = 'Delayed' THEN 1 
        ELSE 0 
    END) as delayed_shipments,
    w.WarehouseType,
	w.Location as Departure_Location ,
    a.City as Delivery_City
    
FROM SHIPMENT sh
JOIN SHIPMENTORGANIZATION so ON sh.ShipmentID = so.ShipmentID
JOIN "ORDER" o ON so.OrderID = o.OrderID
JOIN WAREHOUSE w ON sh.WarehouseID = w.WarehouseID
JOIN ADDRESS a ON so.AddressID = a.AddressID
WHERE o.OrderedDate >= CURRENT_DATE - INTERVAL '90 days'
GROUP BY sh.Carrier, w.WarehouseType, a.City,w.Location
ORDER BY carrier,total_shipments DESC;