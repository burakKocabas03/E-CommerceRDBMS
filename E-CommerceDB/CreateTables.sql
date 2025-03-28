-- Create base tables
CREATE TABLE CUSTOMER (
    CustomerID INT PRIMARY KEY,
    Phone VARCHAR(20),
    Email VARCHAR(255) NOT NULL UNIQUE,
    Password VARCHAR(255) NOT NULL,
    Fname VARCHAR(50),
    Lname VARCHAR(50),
    RegistrationDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Sex CHAR(1),
    EliteFlag BOOLEAN DEFAULT FALSE,
    PremiumFlag BOOLEAN DEFAULT FALSE,
    ElitePoint INT DEFAULT 0,
    IsPaid BOOLEAN DEFAULT FALSE
);

CREATE TABLE SHOP (
    ShopID INT PRIMARY KEY,
    Phone VARCHAR(20),
    Description TEXT,
    RegistrationDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    ShopName VARCHAR(100) NOT NULL,
    ShopType VARCHAR(50)
);

CREATE TABLE CATEGORY (
    CategoryID INT PRIMARY KEY,
    CategoryName VARCHAR(100) NOT NULL,
    ParentCategoryID INT,
    FOREIGN KEY (ParentCategoryID) REFERENCES CATEGORY(CategoryID)
);

CREATE TABLE PRODUCT (
    ProductID INT PRIMARY KEY,
    Favorite_Count INT DEFAULT 0,
    ProductName VARCHAR(255) NOT NULL,
    Brand VARCHAR(100),
	ProductRate DECIMAL(3,2) DEFAULT 0,
    Description TEXT,
    CategoryID INT,
    FOREIGN KEY (CategoryID) REFERENCES CATEGORY(CategoryID)
);

CREATE TABLE VARIANTS (
    VariantID INT PRIMARY KEY,
    VariantType VARCHAR(50) NOT NULL,
    ProductID INT,
    FOREIGN KEY (ProductID) REFERENCES PRODUCT(ProductID)
);

CREATE TABLE WAREHOUSE (
    WarehouseID INT PRIMARY KEY,
    Location VARCHAR(255) NOT NULL,
    WarehouseType VARCHAR(50),
    ShopID INT,
    FOREIGN KEY (ShopID) REFERENCES SHOP(ShopID)
);

CREATE TABLE ADDRESS (
    AddressID INT PRIMARY KEY,
    Country VARCHAR(100) NOT NULL,
    State VARCHAR(100),
    City VARCHAR(100) NOT NULL,
    Street VARCHAR(255),
    Postal_Code VARCHAR(20),
    AddressType VARCHAR(50),
    CustAddresName VARCHAR(100) UNIQUE, 
    PickUPPointName VARCHAR(100) UNIQUE,
    CustomerID INT,
    FOREIGN KEY (CustomerID) REFERENCES CUSTOMER(CustomerID)
);

CREATE TABLE SHIPMENT (
    ShipmentID INT PRIMARY KEY,
    Est_Delivery_Date TIMESTAMP,
    TrackingNumber VARCHAR(100) UNIQUE,
    ShipStatus VARCHAR(50),
    Carrier VARCHAR(100),
    WarehouseID INT,
    FOREIGN KEY (WarehouseID) REFERENCES WAREHOUSE(WarehouseID)
);

CREATE TABLE COUPON (
    CouponID INT PRIMARY KEY,
    DiscountAmount DECIMAL(10,2) NOT NULL,
    MinOrderLimit DECIMAL(10,2),
    UsageLimit INT,
    ExpirationDate TIMESTAMP,
    ShopID INT,
    FOREIGN KEY (ShopID) REFERENCES SHOP(ShopID)
);

-- Create tables with composite keys and relationships
CREATE TABLE SHOPPRODUCT (
    SKU VARCHAR(50),
    ProductID INT,
    ShopID INT,
    Price DECIMAL(10,2) NOT NULL,
    Stock INT DEFAULT 0,
    ImportFee DECIMAL(10,2),
    DiscountPercentage DECIMAL(5,2),
    AddedDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    VariantID INT,
	WarehouseID INT,
    PRIMARY KEY (SKU, ProductID, ShopID),
    FOREIGN KEY (ProductID) REFERENCES PRODUCT(ProductID),
    FOREIGN KEY (ShopID) REFERENCES SHOP(ShopID),
    FOREIGN KEY (VariantID) REFERENCES VARIANTS(VariantID),
	FOREIGN KEY (WarehouseID) REFERENCES Warehouse(WarehouseID)
	
);

CREATE TABLE PAYMENTPREFERENCES (
    CustomerID INT,
    PaymentName VARCHAR(50),
    PaymentType VARCHAR(100),
    CardInformations TEXT,
    PRIMARY KEY (CustomerID, PaymentName),
    FOREIGN KEY (CustomerID) REFERENCES CUSTOMER(CustomerID)
);

CREATE TABLE CART (
    CustomerID INT,
    CartID INT,
    TotalAmount DECIMAL(10,2),
    CartSession VARCHAR(255),
    UpdateDate TIMESTAMP,
    PRIMARY KEY (CustomerID, CartID),
    FOREIGN KEY (CustomerID) REFERENCES CUSTOMER(CustomerID)
);

CREATE TABLE COLLECTIONS (
    CustomerID INT,
    CollectionName VARCHAR(100),
    UpdateDate TIMESTAMP,
    PRIMARY KEY (CustomerID, CollectionName),
    FOREIGN KEY (CustomerID) REFERENCES CUSTOMER(CustomerID)
);

CREATE TABLE "ORDER" (
    CustomerID INT,
    OrderID INT,
    TotalAmount DECIMAL(10,2),
    OrderedDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UpdateDate TIMESTAMP,
    PaymentName VARCHAR(50),
    PRIMARY KEY (CustomerID, OrderID),
    FOREIGN KEY (CustomerID, PaymentName) REFERENCES PAYMENTPREFERENCES(CustomerID, PaymentName)
);

-- Create relationship tables
CREATE TABLE FOLLOWSHOPS (
    CustomerID INT,
    ShopID INT,
    PRIMARY KEY (CustomerID, ShopID),
    FOREIGN KEY (CustomerID) REFERENCES CUSTOMER(CustomerID),
    FOREIGN KEY (ShopID) REFERENCES SHOP(ShopID)
);

CREATE TABLE CUSTOMERCOUPON (
    CustomerID INT,
    CouponID INT,
    PRIMARY KEY (CustomerID, CouponID),
    FOREIGN KEY (CustomerID) REFERENCES CUSTOMER(CustomerID),
    FOREIGN KEY (CouponID) REFERENCES COUPON(CouponID)
);

CREATE TABLE FOLLOWCUSTOMER (
    CustomerID INT,
    FollowedCustomerID INT,
    PRIMARY KEY (CustomerID, FollowedCustomerID),
    FOREIGN KEY (CustomerID) REFERENCES CUSTOMER(CustomerID),
    FOREIGN KEY (FollowedCustomerID) REFERENCES CUSTOMER(CustomerID)
);

CREATE TABLE HAS_COUPON (
    CouponID INT,
    SKU VARCHAR(50),
    ProductID INT,
    ShopID INT,
    PRIMARY KEY (CouponID, SKU, ProductID, ShopID),
    FOREIGN KEY (CouponID) REFERENCES COUPON(CouponID),
    FOREIGN KEY (SKU, ProductID, ShopID) REFERENCES SHOPPRODUCT(SKU, ProductID, ShopID)
);

CREATE TABLE CARTCOUPON (
    CouponID INT,
    CustomerID INT,
    CartID INT,
    PRIMARY KEY (CouponID, CustomerID, CartID),
    FOREIGN KEY (CouponID) REFERENCES COUPON(CouponID),
    FOREIGN KEY (CustomerID, CartID) REFERENCES CART(CustomerID, CartID)
);

CREATE TABLE COLLECTIONITEMS (
    CollectionName VARCHAR(100),
    CustomerID INT,
    ProductID INT,
    PRIMARY KEY (CollectionName, CustomerID, ProductID),
    FOREIGN KEY (CustomerID, CollectionName) REFERENCES COLLECTIONS(CustomerID, CollectionName),
    FOREIGN KEY (ProductID) REFERENCES PRODUCT(ProductID)
);

CREATE TABLE ORDERITEM (
    CustomerID INT,
    OrderID INT,
    ProductID INT,
    ShopID INT,
    SKU VARCHAR(50),
    Quantity INT NOT NULL,
    Price DECIMAL(10,2) NOT NULL,
    Status VARCHAR(50),
    PRIMARY KEY (CustomerID, OrderID, ProductID, ShopID, SKU),
    FOREIGN KEY (CustomerID, OrderID) REFERENCES "ORDER"(CustomerID, OrderID),
    FOREIGN KEY (SKU, ProductID, ShopID) REFERENCES SHOPPRODUCT(SKU, ProductID, ShopID)
);

CREATE TABLE CARTITEM (
    CustomerID INT,
    CartID INT,
    ProductID INT,
    ShopID INT,
    SKU VARCHAR(50),
    Quantity INT NOT NULL,
    Price DECIMAL(10,2) NOT NULL,
    Status VARCHAR(50),
    PRIMARY KEY (CustomerID, CartID, ProductID, ShopID, SKU),
    FOREIGN KEY (CustomerID, CartID) REFERENCES CART(CustomerID, CartID),
    FOREIGN KEY (SKU, ProductID, ShopID) REFERENCES SHOPPRODUCT(SKU, ProductID, ShopID)
);

CREATE TABLE REVIEWS (
    CustomerID INT,
    OrderID INT,
    ProductID INT,
    ShopID INT,
    SKU VARCHAR(50),
    Rate INT CHECK (Rate BETWEEN 1 AND 5),
    Review_Comment TEXT,
    Review_Date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (CustomerID, OrderID,  ProductID, ShopID, SKU),
    FOREIGN KEY (CustomerID, OrderID, ProductID, ShopID, SKU) REFERENCES ORDERITEM(CustomerID, OrderID, ProductID, ShopID, SKU)
);

CREATE TABLE SHIPMENTORGANIZATION (
    CustomerID INT,
    OrderID INT,
    ProductID INT,
    ShopID INT,
    SKU VARCHAR(50),
    ShipmentID INT,
    AddressID INT,
    ShipmentQuantity INT NOT NULL,
    PRIMARY KEY (CustomerID, OrderID, ProductID, ShopID, SKU, ShipmentID),
    FOREIGN KEY (CustomerID, OrderID, ProductID, ShopID, SKU) REFERENCES ORDERITEM(CustomerID, OrderID, ProductID, ShopID, SKU),
    FOREIGN KEY (ShipmentID) REFERENCES SHIPMENT(ShipmentID),
    FOREIGN KEY (AddressID) REFERENCES ADDRESS(AddressID)
);