-- RECUERDA REEMPLAZAR los valores en las sentncias COPY
-- FROM - ruta URI del archivo CSV dentro del S3
------ s3://d5-dwh-contoso-s3/contoso_sales/DimGeography.csv'
-- IAM_ROLE - es el ARN del rol IAM / Roles / AmazonRedshift-CommandsAccessRole-20250602T23
------ arn:aws:iam::8776388:role/service-role/AmazonRedshift-CommandsAccessRole-20250602T23


CREATE TABLE IF NOT EXISTS public.dimgeography (
    GeographyKey         INT            NOT NULL,
    GeographyType        VARCHAR(50),
    ContinentName        VARCHAR(100),
    CityName             VARCHAR(100),
    StateProvinceName    VARCHAR(100),
    RegionCountryName    VARCHAR(100),

    -- Opcional: Constraint de PK
    CONSTRAINT pk_dimgeography PRIMARY KEY (GeographyKey)
)
DISTSTYLE AUTO
SORTKEY (GeographyKey);

COPY dev.public.dimgeography FROM 's3://d5-dwh-contoso-s3/contoso_sales/DimGeography.csv' IAM_ROLE 'arn:aws:iam::877638801425:role/service-role/AmazonRedshift-CommandsAccessRole-20250602T230640' FORMAT AS CSV DELIMITER ',' QUOTE '"' IGNOREHEADER 1 REGION AS 'us-east-1'




CREATE TABLE IF NOT EXISTS public.dimdate (
    DateKey                  VARCHAR(20)             NOT NULL,  -- Primary Key
    CalendarYear             INT,
    CalendarYearLabel        VARCHAR(50),
    CalendarHalfYearLabel    VARCHAR(50),
    CalendarQuarterLabel     VARCHAR(50),
    CalendarMonthLabel       VARCHAR(50),
    CalendarWeekLabel        VARCHAR(50),
    CalendarDayOfWeekLabel   VARCHAR(50),
    FiscalYear               INT,
    FiscalYearLabel          VARCHAR(50),
    FiscalHalfYearLabel      VARCHAR(50),
    FiscalQuarterLabel       VARCHAR(50),
    FiscalMonthLabel         VARCHAR(50),
    IsWorkDay                VARCHAR(10),   -- O BOOLEAN si tus datos son true/false
    IsHoliday                VARCHAR(10),   -- O BOOLEAN si tus datos son true/false
    EuropeSeason             VARCHAR(50),
    NorthAmericaSeason       VARCHAR(50),
    AsiaSeason               VARCHAR(50),
    MonthNumber              INT,
    CalendarDayOfWeekNumber  INT,

    CONSTRAINT pk_dimdate PRIMARY KEY (DateKey)
)
DISTSTYLE AUTO
SORTKEY (DateKey);

COPY dev.public.dimdate FROM 's3://d5-dwh-contoso-s3/contoso_sales/DimDate.csv' IAM_ROLE 'arn:aws:iam::877638801425:role/service-role/AmazonRedshift-CommandsAccessRole-20250602T230640' FORMAT AS CSV DELIMITER ',' QUOTE '"' IGNOREHEADER 1 REGION AS 'us-east-1'




CREATE TABLE IF NOT EXISTS public.dimchannel (
    ChannelKey          INT             NOT NULL,  -- Primary key
    ChannelName         VARCHAR(100),
    ChannelDescription  VARCHAR(200),

    CONSTRAINT pk_dimchannel PRIMARY KEY (ChannelKey)
)
DISTSTYLE AUTO
SORTKEY (ChannelKey);

COPY dev.public.dimchannel FROM 's3://d5-dwh-contoso-s3/contoso_sales/DimChannel.csv' IAM_ROLE 'arn:aws:iam::877638801425:role/service-role/AmazonRedshift-CommandsAccessRole-20250602T230640' FORMAT AS CSV DELIMITER ',' QUOTE '"' IGNOREHEADER 1 REGION AS 'us-east-1'





CREATE TABLE IF NOT EXISTS public.dimproduct (
    ProductKey                INT             NOT NULL,  -- Primary Key
    ProductName               VARCHAR(500),
    ProductDescription        VARCHAR(500),
    ProductSubcategoryKey     VARCHAR(20),
    Manufacturer              VARCHAR(150),
    BrandName                 VARCHAR(150),
    ClassID                   VARCHAR(20),
    ClassName                 VARCHAR(100),
    StyleID                   VARCHAR(20),
    StyleName                 VARCHAR(100),
    ColorID                   VARCHAR(20),
    ColorName                 VARCHAR(100),
    Weight                    VARCHAR(20),
    WeightUnitMeasureID       VARCHAR(20),
    UnitOfMeasureID           VARCHAR(20),
    UnitOfMeasureName         VARCHAR(50),
    StockTypeID               VARCHAR(20),
    StockTypeName             VARCHAR(100),
    UnitCost                  VARCHAR(50),
    UnitPrice                 VARCHAR(50),
    AvailableForSaleDate      VARCHAR(100),
    Status                    VARCHAR(50),

    CONSTRAINT pk_dimproduct PRIMARY KEY (ProductKey)
)
DISTSTYLE AUTO
SORTKEY (ProductKey);

COPY dev.public.dimproduct FROM 's3://d5-dwh-contoso-s3/contoso_sales/DimProduct.csv' IAM_ROLE 'arn:aws:iam::877638801425:role/service-role/AmazonRedshift-CommandsAccessRole-20250602T230640' FORMAT AS CSV DELIMITER ',' QUOTE '"' IGNOREHEADER 1 REGION AS 'us-east-1'



CREATE TABLE IF NOT EXISTS public.dimpromotion (
    PromotionKey       INT            NOT NULL,  -- Primary Key
    PromotionName      VARCHAR(100),
    DiscountPercent    VARCHAR(10),
    PromotionType      VARCHAR(50),
    PromotionCategory  VARCHAR(50),

    CONSTRAINT pk_dimpromotion PRIMARY KEY (PromotionKey)
)
DISTSTYLE AUTO
SORTKEY (PromotionKey);

COPY dev.public.dimpromotion FROM 's3://d5-dwh-contoso-s3/contoso_sales/DimPromotion.csv' IAM_ROLE 'arn:aws:iam::877638801425:role/service-role/AmazonRedshift-CommandsAccessRole-20250602T230640' FORMAT AS CSV DELIMITER ',' QUOTE '"' IGNOREHEADER 1 REGION AS 'us-east-1'



CREATE TABLE IF NOT EXISTS public.dimstore (
    StoreKey         INT            NOT NULL,  -- Primary Key
    GeographyKey     INT,
    StoreManager     VARCHAR(100),
    StoreType        VARCHAR(50),
    StoreName        VARCHAR(150),
    Status           VARCHAR(50),
    OpenDate         VARCHAR(50),
    CloseDate        VARCHAR(50),
    EntityKey        VARCHAR(50),
    StorePhone       VARCHAR(50),
    StoreFax         VARCHAR(50),
    CloseReason      VARCHAR(150),
    EmployeeCount    VARCHAR(10),
    SellingAreaSize  VARCHAR(50),
    LastRemodelDate  VARCHAR(50),
    EmployeeKey      VARCHAR(50),

    CONSTRAINT pk_dimstore PRIMARY KEY (StoreKey)
)
DISTSTYLE AUTO
SORTKEY (StoreKey);

COPY dev.public.dimstore FROM 's3://d5-dwh-contoso-s3/contoso_sales/DimStore.csv' IAM_ROLE 'arn:aws:iam::877638801425:role/service-role/AmazonRedshift-CommandsAccessRole-20250602T230640' FORMAT AS CSV DELIMITER ',' QUOTE '"' IGNOREHEADER 1 REGION AS 'us-east-1'




CREATE TABLE IF NOT EXISTS public.factsales (
    SalesKey           INT             NOT NULL,  -- Primary Key
    DateKey            VARCHAR(20),
    ChannelKey         INT,
    StoreKey           INT,
    ProductKey         INT,
    PromotionKey       INT,
    CurrencyKey        INT,
    UnitCost           VARCHAR(20),
    UnitPrice          VARCHAR(20),
    SalesQuantity      INT,
    ReturnQuantity     INT,
    ReturnAmount       VARCHAR(20),
    DiscountQuantity   INT,
    DiscountAmount     VARCHAR(20),
    TotalCost          VARCHAR(20),
    SalesAmount        VARCHAR(20),

    CONSTRAINT pk_factsales PRIMARY KEY (SalesKey)
)
DISTSTYLE AUTO
SORTKEY (SalesKey);

COPY dev.public.factsales FROM 's3://d5-dwh-contoso-s3/contoso_sales/FactSales.csv' IAM_ROLE 'arn:aws:iam::877638801425:role/service-role/AmazonRedshift-CommandsAccessRole-20250602T230640' FORMAT AS CSV DELIMITER ',' QUOTE '"' IGNOREHEADER 1 REGION AS 'us-east-1'


SELECT
    *
FROM
    "dev"."public"."factsales"   
limit 10;