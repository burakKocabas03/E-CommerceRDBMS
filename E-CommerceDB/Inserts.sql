-- Populate CATEGORY table with hierarchical structure
INSERT INTO CATEGORY (CategoryID, CategoryName, ParentCategoryID) VALUES
(1, 'Electronics', NULL),
(2, 'Smartphones', 1),
(3, 'Laptops', 1),
(4, 'Fashion', NULL),
(5, 'Men''s Fashion', 4),
(6, 'Women''s Fashion', 4),
(7, 'Home & Living', NULL),
(8, 'Furniture', 7),
(9, 'Kitchen', 7);

-- Populate CUSTOMER table with Turkish customers
INSERT INTO CUSTOMER (CustomerID, Phone, Email, Password, Fname, Lname, Sex, EliteFlag, PremiumFlag, ElitePoint, IsPaid) VALUES
(1, '+90555-0101', 'ali.yilmaz@email.com', 'hash123', 'Ali', 'Yilmaz', 'M', true, true, 1500, true),
(2, '+90555-0102', 'ayse.demir@email.com', 'hash456', 'Ayse', 'Demir', 'F', false, true, 0, true),
(3, '+90555-0103', 'mehmet.kaya@email.com', 'hash789', 'Mehmet', 'Kaya', 'M', false, false, 0, false),
(4, '+90555-0104', 'zeynep.celik@email.com', 'hash101', 'Zeynep', 'Celik', 'F', true, false, 0, true),
(5, '+90555-0105', 'can.ozturk@email.com', 'hash102', 'Can', 'Ozturk', 'M', false, true, 0, true);

-- Populate SHOP table with shops in different Turkish cities
INSERT INTO SHOP (ShopID, Phone, Description, ShopName, ShopType) VALUES
(1, '+90216-1001', 'Premium Electronics Store in Istanbul', 'TechMaster Istanbul', 'Electronics'),
(2, '+90312-1002', 'Fashion Boutique in Ankara', 'Ankara Style Hub', 'Fashion'),
(3, '+90232-1003', 'Home Goods Store in Izmir', 'Izmir Home Center', 'Home & Living'),
(4, '+90242-1004', 'Electronics Store in Antalya', 'Antalya Digital', 'Electronics'),
(5, '+90332-1005', 'Fashion Store in Konya', 'Konya Fashion House', 'Fashion');



-- Populate PRODUCT table
INSERT INTO PRODUCT (ProductID, Favorite_Count, ProductName, Brand, Description, CategoryID) VALUES
(1, 150, 'iPhone 14 Pro', 'Apple',  'Latest iPhone model', 2),
(2, 120, 'Galaxy S23', 'Samsung', 'Latest Samsung flagship', 2),
(3, 200, 'MacBook Pro M2', 'Apple',  'Professional laptop', 3),
(4, 80, 'ThinkPad X1', 'Lenovo',  'Business laptop', 3),
(5, 90, 'Leather Jacket', 'TurkStyle',  'Genuine leather jacket', 5),
(6, 100, 'Evening Dress', 'Boutique', 'Elegant evening dress', 6),
(7, 70, 'Modern Sofa', 'TurkFurniture',  'Contemporary design sofa', 8),
(8, 60, 'Kitchen Set', 'HomeStyle',  'Complete kitchen set', 9);

-- Populate VARIANTS table
INSERT INTO VARIANTS (VariantID, VariantType, ProductID) VALUES
(1, '128GB Space Gray', 1),
(2, '256GB Space Gray', 1),
(3, '256GB Black', 2),
(4, '512GB Black', 2),
(5, '14" Space Gray', 3),
(6, '16" Space Gray', 3),
(7, 'Black M', 5),
(8, 'Black L', 5),
(9, 'Red S', 6),
(10, 'Red M', 6);

-- Populate WAREHOUSE table with locations in Turkish cities
INSERT INTO WAREHOUSE (WarehouseID, Location, WarehouseType, ShopID) VALUES
(1, 'Istanbul European Side', 'FBA',null),
(2, 'Ankara Central', 'FBA',null),
(3, 'Izmir Port Area', 'FBA',null),
(4, 'Istanbul Asian Side', 'FBA',null),
(5, 'Antalya Coast', 'FBM',4);

-- Populate ADDRESS table with Turkish addresses
INSERT INTO ADDRESS (AddressID, Country, State, City, Street, Postal_Code, AddressType, CustAddresName, CustomerID) VALUES
(1, 'Turkey', 'Marmara', 'Istanbul', 'Bagdat Street', '34710', 'CustomerAdress', 'Home Address 1', 1),
(2, 'Turkey', 'Central Anatolia', 'Ankara', 'Tunali Street', '06550', 'CustomerAdress', 'Home Address 2', 2),
(3, 'Turkey', 'Aegean', 'Izmir', 'Alsancak Street', '35220', 'CustomerAdress', 'Work Address 1', 3),
(4, 'Turkey', 'Mediterranean', 'Antalya', 'Konyaalti Street', '07070', 'CustomerAdress', 'Home Address 3', 4),
(5, 'Turkey', 'Central Anatolia', 'Konya', 'Meram Street', '42090', 'CustomerAdress', 'MyHome', 5),
(6, 'Turkey', 'Central Anatolia', 'Konya', 'Mevlana Street', '42200' , 'CustomerAdress', 'Brother Home', 5),
(7, 'Turkey', 'BlackSea', 'Trabzon', 'Macka Street', '61030', 'PickupPointAdress', 'Burak Petshop', null);

-- Populate SHIPMENT table
INSERT INTO SHIPMENT (ShipmentID, Est_Delivery_Date, TrackingNumber, ShipStatus, Carrier, WarehouseID) VALUES
(1, CURRENT_TIMESTAMP + INTERVAL '3 days', 'TR100001', 'In Transit', 'Turkish Cargo', 1),
(2, CURRENT_TIMESTAMP + INTERVAL '2 days', 'TR100002', 'Processing', 'Aras Cargo', 2),
(3, CURRENT_TIMESTAMP + INTERVAL '4 days', 'TR100003', 'Delivered', 'MNG Cargo', 3),
(4, CURRENT_TIMESTAMP + INTERVAL '1 day', 'TR100004', 'In Transit', 'PTT Cargo', 4),
(5, CURRENT_TIMESTAMP + INTERVAL '5 days', 'TR100005', 'Processing', 'Yurtici Cargo', 5),
(6, CURRENT_TIMESTAMP + INTERVAL '2 days', 'TR100006', 'In Transit', 'Turkish Cargo', 1),
(7, CURRENT_TIMESTAMP + INTERVAL '3 days', 'TR100007', 'Processing', 'Aras Cargo', 2),
(8, CURRENT_TIMESTAMP + INTERVAL '1 day', 'TR100008', 'In Transit', 'MNG Cargo', 3),
(9, CURRENT_TIMESTAMP + INTERVAL '4 days', 'TR100009', 'Processing', 'PTT Cargo', 4),
(10, CURRENT_TIMESTAMP + INTERVAL '2 days', 'TR100010', 'In Transit', 'Aras Cargo', 5),
(11, CURRENT_TIMESTAMP + INTERVAL '3 days', 'TR100011', 'In Transit', 'Yurtici Cargo', 5),
(12, CURRENT_TIMESTAMP + INTERVAL '2 days', 'TR100012', 'In Transit', 'Yurtici Cargo', 5);

-- Populate COUPON table
INSERT INTO COUPON (CouponID, DiscountAmount, MinOrderLimit, UsageLimit, ExpirationDate, ShopID) VALUES
(1, 100.00, 1000.00, 100, CURRENT_TIMESTAMP + INTERVAL '30 days', 1),
(2, 50.00, 500.00, 200, CURRENT_TIMESTAMP + INTERVAL '15 days', 2),
(3, 200.00, 2000.00, 50, CURRENT_TIMESTAMP + INTERVAL '45 days', 3),
(4, 75.00, 750.00, 150, CURRENT_TIMESTAMP + INTERVAL '60 days', 4),
(5, 150.00, 1500.00, 75, CURRENT_TIMESTAMP + INTERVAL '20 days', 5),
(6, 250.00, 2500.00, 1000, CURRENT_TIMESTAMP + INTERVAL '30 days', null),  -- Platform-wide discount for high-value orders
(7, 100.00, 1000.00, 2000, CURRENT_TIMESTAMP + INTERVAL '45 days', null),  -- Mid-range platform discount
(8, 50.00, 500.00, 5000, CURRENT_TIMESTAMP + INTERVAL '60 days', null);    -- Entry-level platform discount

-- Now add HAS_COUPON entries for platform-wide coupons

-- Populate SHOPPRODUCT table with prices in Turkish Lira
INSERT INTO SHOPPRODUCT (SKU, ProductID, ShopID, Price, Stock, ImportFee, DiscountPercentage, VariantID,WarehouseID) VALUES
('IP14-128-SG', 1, 1, 45000.00, 50, 1000.00, 5.00, 1, 1),
('IP14-256-SG', 1, 1, 50000.00, 30, 1000.00, 5.00, 2, 4),
('GS23-256-B', 2, 4, 35000.00, 40, 800.00, 10.00, 3, 5),
('GS23-512-B', 2, 4, 40000.00, 25, 800.00, 10.00, 4, 5),
('MBP-14-SG', 3, 1, 55000.00, 20, 1200.00, 0.00, 5, 1),
('MBP-16-SG', 3, 1, 65000.00, 15, 1200.00, 0.00, 6, 1),
('LJ-BLACK-M', 5, 2, 3000.00, 100, 100.00, 15.00, 7, 2),
('LJ-BLACK-L', 5, 2, 3000.00, 80, 100.00, 15.00, 8, 2 ),
('ED-RED-S', 6, 2, 2500.00, 60, 80.00, 20.00, 9, 2),
('ED-RED-M', 6, 2, 2500.00, 45, 80.00, 20.00, 10, 2),
('IP14-128-SG-2', 1, 2, 46000.00, 30, 1000.00, 3.00, 1, 2),
('IP14-128-SG-3', 1, 3, 45500.00, 25, 1000.00, 4.00, 1, 3),
('GS23-256-B-1', 2, 1, 34500.00, 35, 800.00, 8.00, 3, 4),
('GS23-256-B-3', 2, 3, 35500.00, 30, 800.00, 7.00, 3, 3),
('MBP-14-SG-4', 3, 4, 56000.00, 15, 1200.00, 2.00, 5, 4),
('TKS-12-NM-1', 8, 4, 1430, 3, 0, 0, null, 4);

INSERT INTO PAYMENTPREFERENCES (CustomerID, PaymentName, PaymentType, CardInformations) 
VALUES
    -- Customer 1 (Ali Yilmaz) payment methods
    (1, 'Ziraat Credit Card', 'CARD', 'Card Type: Credit, Bank: Ziraat, Last4: 1234, Expiry: 12/25'),
    (1, 'Garanti Debit', 'CARD', 'Card Type: Debit, Bank: Garanti, Last4: 5678, Expiry: 03/26'),
    (1, 'YapiKredi Contactless', 'CARD', 'Card Type: Credit, Bank: YapiKredi, Last4: 9012, Expiry: 08/24'),

    -- Customer 2 (Ayse Demir) payment methods
    (2, 'IsBank Credit', 'CARD', 'Card Type: Credit, Bank: Is Bankasi, Last4: 3456, Expiry: 05/25'),
    (2, 'Akbank World', 'CARD', 'Card Type: Credit, Bank: Akbank, Last4: 7890, Expiry: 11/24'),
    
    -- Customer 3 (Mehmet Kaya) payment methods
    (3, 'Halkbank Paraf', 'CARD', 'Card Type: Credit, Bank: Halkbank, Last4: 2345, Expiry: 07/26'),
    (3, 'Vakifbank Debit', 'CARD', 'Card Type: Debit, Bank: Vakifbank, Last4: 6789, Expiry: 09/25'),
    
    -- Customer 4 (Zeynep Celik) payment methods
    (4, 'Denizbank Credit', 'CARD', 'Card Type: Credit, Bank: Denizbank, Last4: 4567, Expiry: 04/25'),
    (4, 'QNB Card', 'CARD', 'Card Type: Credit, Bank: QNB Finansbank, Last4: 8901, Expiry: 10/24'),
    (4, 'TEB Debit', 'CARD', 'Card Type: Debit, Bank: TEB, Last4: 3456, Expiry: 06/26'),
    
    -- Customer 5 (Can Ozturk) payment methods
    (5, 'ING Bank Credit', 'CARD', 'Card Type: Credit, Bank: ING Bank, Last4: 5678, Expiry: 02/25'),
    (5, 'Garanti Bonus', 'CARD', 'Card Type: Credit, Bank: Garanti, Last4: 9012, Expiry: 12/24');


-- Populate CART table
INSERT INTO CART (CustomerID, CartID, TotalAmount, CartSession, UpdateDate) VALUES
(1, 1, 91000.00, 'SESSION1',CURRENT_TIMESTAMP - INTERVAL '2 hours'),
(2, 1, 35000.00, 'SESSION2', CURRENT_TIMESTAMP - INTERVAL '23 hours'),
(3, 1, 3000.00, 'SESSION3', CURRENT_TIMESTAMP - INTERVAL '45 hours'),
(4, 1, 2500.00, 'SESSION4', CURRENT_TIMESTAMP - INTERVAL '72 hours'),
(5, 1, 55000.00, 'SESSION5', CURRENT_TIMESTAMP - INTERVAL '89 hours');

-- Populate ORDER table
INSERT INTO "ORDER" (CustomerID, OrderID, TotalAmount, OrderedDate, UpdateDate,PaymentName) VALUES
(1, 1, 91000.00, CURRENT_TIMESTAMP - INTERVAL '5 days', CURRENT_TIMESTAMP,'Ziraat Credit Card'),
(2, 1, 35000.00, CURRENT_TIMESTAMP - INTERVAL '4 days', CURRENT_TIMESTAMP,'IsBank Credit'),
(3, 1, 48500.00, CURRENT_TIMESTAMP - INTERVAL '3 days', CURRENT_TIMESTAMP,'Halkbank Paraf'),
(4, 1, 2500.00, CURRENT_TIMESTAMP - INTERVAL '2 days', CURRENT_TIMESTAMP,'Denizbank Credit'),
(1, 2, 69000.00, CURRENT_TIMESTAMP - INTERVAL '2 hours', CURRENT_TIMESTAMP,'Garanti Debit'),
(1, 3, 56000.00, CURRENT_TIMESTAMP - INTERVAL '4 hours', CURRENT_TIMESTAMP,'Yapikredi Contactless'),
(1, 4, 45500.00, CURRENT_TIMESTAMP - INTERVAL '6 hours', CURRENT_TIMESTAMP,'Ziraat Credit Card'),
(2, 2, 46000.00, CURRENT_TIMESTAMP - INTERVAL '3 hours', CURRENT_TIMESTAMP,'Akbank World'),
(2, 3, 35500.00, CURRENT_TIMESTAMP - INTERVAL '5 hours', CURRENT_TIMESTAMP,'IsBank Credit'),
(5, 1, 61000, CURRENT_TIMESTAMP - INTERVAL '3 days' ,CURRENT_TIMESTAMP,'ING Bank Credit');


-- Populate ORDERITEM table
INSERT INTO ORDERITEM (CustomerID, OrderID, ProductID, ShopID, SKU, Quantity, Price, Status) VALUES
(1, 1, 1, 1, 'IP14-128-SG', 1, 45000.00, 'Delivered'),
(2, 1, 2, 4, 'GS23-256-B', 1, 35000.00, 'In Transit'),
(3, 1, 5, 2, 'LJ-BLACK-M', 1, 3000.00, 'Processing'),
(4, 1, 6, 2, 'ED-RED-S', 1, 2500.00, 'Shipped'),
(5, 1, 3, 1, 'MBP-14-SG', 1, 55000.00, 'Processing'),
(1, 1, 1, 2, 'IP14-128-SG-2', 1, 46000.00, 'Processing'),
(2, 1, 2, 1, 'GS23-256-B-1', 1, 34500.00, 'Delivered'),
(3, 1, 1, 3, 'IP14-128-SG-3', 1, 45500.00, 'In Transit'),
(5, 1, 5, 2, 'LJ-BLACK-L', 2, 3000.00, 'In Transit'),
(1, 2, 2, 1, 'GS23-256-B-1', 2, 34500.00, 'Processing'),
(1, 3, 3, 4, 'MBP-14-SG-4', 1, 56000.00, 'Processing'),
(1, 4, 1, 3, 'IP14-128-SG-3', 1, 45500.00, 'Processing'),
(2, 2, 1, 2, 'IP14-128-SG-2', 1, 46000.00, 'Processing'),
(2, 3, 2, 3, 'GS23-256-B-3', 1, 35500.00, 'Processing');

INSERT INTO CARTITEM (CustomerID, CartID, ProductID, ShopID, SKU, Quantity, Price, Status) VALUES
-- Cart for Customer 1 (Multiple items)
(1, 1, 1, 1, 'IP14-128-SG', 1, 45000.00, 'Active'),
(1, 1, 2, 4, 'GS23-256-B', 1, 35000.00, 'Active'),

-- Cart for Customer 2 (Multiple electronics)
(2, 1, 3, 1, 'MBP-14-SG', 1, 55000.00, 'Active'),
(2, 1, 2, 1, 'GS23-256-B-1', 1, 34500.00, 'Active'),

-- Cart for Customer 3 (Fashion items)
(3, 1, 5, 2, 'LJ-BLACK-M', 2, 3000.00, 'Active'),
(3, 1, 6, 2, 'ED-RED-S', 1, 2500.00, 'Active'),

-- Cart for Customer 4 (Mixed items)
(4, 1, 6, 2, 'ED-RED-M', 1, 2500.00, 'Active'),
(4, 1, 1, 3, 'IP14-128-SG-3', 1, 45500.00, 'Active'),

-- Cart for Customer 5 (High-value electronics)
(5, 1, 3, 1, 'MBP-14-SG', 1, 55000.00, 'Active'),
(5, 1, 1, 1, 'IP14-256-SG', 1, 50000.00, 'Active');




-- Populate REVIEWS table
INSERT INTO REVIEWS (CustomerID, OrderID, ProductID, ShopID, SKU, Rate, Review_Comment) VALUES
(1, 1, 1, 1, 'IP14-128-SG', 5, 'Excellent product and fast delivery!'),
(2, 1, 2, 4, 'GS23-256-B', 4, 'Good phone, slightly expensive'),
(3, 1, 5, 2, 'LJ-BLACK-M', 5, 'Perfect fit and great quality'),
(4, 1, 6, 2, 'ED-RED-S', 4, 'Beautiful dress, fast shipping'),
(5, 1, 3, 1, 'MBP-14-SG', 5, 'Amazing 	 laptop, worth every penny'),
(1, 1, 1, 2, 'IP14-128-SG-2', 4, 'Good service and product'),
(2, 1, 2, 1, 'GS23-256-B-1', 5, 'Excellent phone and quick delivery'),
(3, 1, 1, 3, 'IP14-128-SG-3', 4, 'Satisfied with the purchase');


-- Populate relationship tables
INSERT INTO FOLLOWSHOPS (CustomerID, ShopID) VALUES
(1, 1), (1, 2), (2, 2), (3, 3), (4, 4);

INSERT INTO CUSTOMERCOUPON (CustomerID, CouponID) VALUES
(1, 1), (2, 2), (3, 3), (4, 4), (5, 5);

INSERT INTO CARTCOUPON (CouponID, CustomerID, CartID) 
VALUES
    -- Customer 1's cart (total amount 91000 TL) can use high-value coupons
    (1, 1, 1),  -- 100 TL off from TechMaster
    (3, 1, 1),  -- 200 TL off from Izmir Home Center
    
    -- Customer 2's cart (total amount 35000 TL)
    (2, 2, 1),  -- 50 TL off from Ankara Style Hub
    
    -- Customer 5's cart (total amount 55000 TL)
    (4, 5, 1);  -- 75 TL off from Antalya Digital
INSERT INTO HAS_COUPON (CouponID, SKU, ProductID, ShopID)
VALUES
    -- TechMaster Istanbul (ShopID 1) coupons
    (1, 'IP14-128-SG', 1, 1),     -- iPhone 14 Pro 128GB
    (1, 'MBP-14-SG', 3, 1),       -- MacBook Pro 14"
    (1, 'MBP-16-SG', 3, 1),       -- MacBook Pro 16"
    
    -- Ankara Style Hub (ShopID 2) coupons
    (2, 'LJ-BLACK-M', 5, 2),      -- Leather Jacket M
    (2, 'LJ-BLACK-L', 5, 2),      -- Leather Jacket L
    (2, 'ED-RED-S', 6, 2),        -- Evening Dress S
    (2, 'ED-RED-M', 6, 2),        -- Evening Dress M
    
    -- Antalya Digital (ShopID 4) coupons
    (4, 'GS23-256-B', 2, 4),      -- Galaxy S23 256GB
    (4, 'GS23-512-B', 2, 4),      -- Galaxy S23 512GB
    (4, 'MBP-14-SG-4', 3, 4);     -- MacBook Pro at Antalya Digital


	 -- High-value coupon (CouponID 6) for expensive electronics across shops
	(6, 'IP14-128-SG', 1, 1),      -- iPhone from TechMaster
    (6, 'IP14-128-SG-2', 1, 2),    -- iPhone from Ankara Style
    (6, 'IP14-128-SG-3', 1, 3),    -- iPhone from Izmir Home
    (6, 'MBP-14-SG', 3, 1),        -- MacBook from TechMaster
    (6, 'MBP-14-SG-4', 3, 4),      -- MacBook from Antalya Digital
    
    -- Mid-range coupon (CouponID 7) for mid-priced items
    (7, 'GS23-256-B', 2, 4),       -- Galaxy from Antalya Digital
    (7, 'GS23-256-B-1', 2, 1),     -- Galaxy from TechMaster
    (7, 'GS23-256-B-3', 2, 3),     -- Galaxy from Izmir Home
    
    -- Entry-level coupon (CouponID 8) for fashion items
    (8, 'LJ-BLACK-M', 5, 2),       -- Leather Jacket from Ankara Style
    (8, 'ED-RED-S', 6, 2),         -- Evening Dress from Ankara Style
    (8, 'ED-RED-M', 6, 2);         -- Evening Dress from Ankara Style



INSERT INTO FOLLOWCUSTOMER (CustomerID, FollowedCustomerID) VALUES
(1, 2), (2, 1), (3, 1), (4, 1), (5, 1);

-- Populate SHIPMENTORGANIZATION table
INSERT INTO SHIPMENTORGANIZATION (CustomerID, OrderID, ProductID, ShopID, SKU, ShipmentID, AddressID, ShipmentQuantity) VALUES
(1, 1, 1, 1, 'IP14-128-SG', 1, 1, 1),
(2, 1, 2, 4, 'GS23-256-B', 2, 2, 1),
(3, 1, 5, 2, 'LJ-BLACK-M', 3, 3, 1),
(4, 1, 6, 2, 'ED-RED-S', 4, 4, 1),
(5, 1, 3, 1, 'MBP-14-SG', 5, 5, 1),
(5, 1, 5, 2, 'LJ-BLACK-L', 11 ,5, 1), 
(5, 1, 5, 2, 'LJ-BLACK-L', 12 ,6, 1),
(1, 2, 2, 1, 'GS23-256-B-1', 6, 1, 1),
(1, 3, 3, 4, 'MBP-14-SG-4', 7, 1, 1),
(1, 4, 1, 3, 'IP14-128-SG-3', 8, 1, 1),
(2, 2, 1, 2, 'IP14-128-SG-2', 9, 2, 1),
(2, 3, 2, 3, 'GS23-256-B-3', 10, 2, 1);




INSERT INTO COLLECTIONS (CustomerID, CollectionName, UpdateDate) VALUES
-- Customer 1's collections
(1, 'My Electronics Wishlist', CURRENT_TIMESTAMP),
(1, 'Gift Ideas', CURRENT_TIMESTAMP - INTERVAL '5 days'),
(1, 'favorites', CURRENT_TIMESTAMP - INTERVAL '10 days'),

-- Customer 2's collections
(2, 'Fashion Favorites', CURRENT_TIMESTAMP),
(2, 'Tech Gadgets', CURRENT_TIMESTAMP - INTERVAL '3 days'),
(2, 'favorites', CURRENT_TIMESTAMP - INTERVAL '7 days');


INSERT INTO COLLECTIONITEMS (CollectionName, CustomerID, ProductID) VALUES
-- Customer 1's collection items
('My Electronics Wishlist', 1, 1),  -- iPhone
('My Electronics Wishlist', 1, 2),  -- Galaxy
('My Electronics Wishlist', 1, 3),  -- MacBook
('Gift Ideas', 1, 5),              -- Leather Jacket
('Gift Ideas', 1, 6),              -- Evening Dress
('favorites', 1, 4),        -- ThinkPad

-- Customer 2's collection items
('Fashion Favorites', 2, 5),       -- Leather Jacket
('Fashion Favorites', 2, 6),       -- Evening Dress
('Tech Gadgets', 2, 1),           -- iPhone
('Tech Gadgets', 2, 2),           -- Galaxy
('favorites', 2, 3);              -- MacBook

