-- One-time setup: ACCOUNTADMIN is needed only to create these objects
USE ROLE ACCOUNTADMIN;

-- Dedicated role
CREATE ROLE IF NOT EXISTS DE_DEV;
GRANT ROLE DE_DEV TO USER VINCENTMBIRA;

-- Cheap warehouse: smallest size, suspends after 60s idle
-- This is done to pause the schema after 60s idle for cost control
CREATE WAREHOUSE IF NOT EXISTS DE_WH
  WAREHOUSE_SIZE = 'XSMALL' -- define the warehouse size
  MIN_CLUSTER_COUNT = 1 -- starts as single cluster VW
  MAX_CLUSTER_COUNT = 5 -- scales up to 5 clusters based on demand
  AUTO_SUSPEND = 60 -- 60 seconds = 1 min
  AUTO_RESUME = TRUE  -- starts VW when query is run
  INITIALLY_SUSPENDED = TRUE; -- VW created in suspended state 

-- Creating the Database and schemas
CREATE DATABASE IF NOT EXISTS DE_LAB;
CREATE SCHEMA IF NOT EXISTS DE_LAB.RAW;
CREATE SCHEMA IF NOT EXISTS DE_LAB.ANALYTICS;

-- Grants
GRANT USAGE, OPERATE ON WAREHOUSE DE_WH TO ROLE DE_DEV;
GRANT ALL ON DATABASE DE_LAB TO ROLE DE_DEV;
GRANT ALL ON ALL SCHEMAS IN DATABASE DE_LAB TO ROLE DE_DEV;

-- Cost guardrails: cap the credits costs so that a mistake can't drain my cost while on trial
CREATE RESOURCE MONITOR IF NOT EXISTS DE_MONITOR
  WITH CREDIT_QUOTA = 10
  TRIGGERS ON 90 PERCENT DO NOTIFY
           ON 100 PERCENT DO SUSPEND;
ALTER WAREHOUSE DE_WH SET RESOURCE_MONITOR = DE_MONITOR;

-- Create a small test table
USE ROLE DE_DEV; USE WAREHOUSE DE_WH; USE SCHEMA DE_LAB.RAW;

SELECT CURRENT_ROLE(), CURRENT_WAREHOUSE(), CURRENT_DATABASE();

-- Creating table ad_clicks
CREATE OR REPLACE TABLE ad_clicks (
  click_id INT, campaign STRING, clicked_at TIMESTAMP, cost NUMBER(10,2)
);
INSERT INTO ad_clicks VALUES
  (1,'spring_sale','2026-10-01 09:00:00',0.45),
(2,'spring_sale','2026-10-01 09:05:00',0.50),
(3,'brand_awareness','2026-10-02 14:30:00',0.30),
(4,'spring_sale','2026-10-01 09:10:00',0.55),
(5,'spring_sale','2026-10-01 09:15:00',0.60),
(6,'brand_awareness','2026-10-02 14:35:00',0.35),
(7,'spring_sale','2026-10-01 09:20:00',0.65),
(8,'spring_sale','2026-10-01 09:25:00',0.70),
(9,'brand_awareness','2026-10-02 14:40:00',0.40),
(10,'spring_sale','2026-10-01 09:30:00',0.75),
(11,'spring_sale','2026-10-01 09:35:00',0.80),
(12,'brand_awareness','2026-10-02 14:45:00',0.45),
(13,'spring_sale','2026-10-01 09:40:00',0.85),
(14,'spring_sale','2026-10-01 09:45:00',0.90),
(15,'brand_awareness','2026-10-02 14:50:00',0.50),
(16,'spring_sale','2026-10-01 09:50:00',0.95),
(17,'spring_sale','2026-10-01 09:55:00',1.00),
(18,'brand_awareness','2026-10-02 14:55:00',0.55),
(19,'spring_sale','2026-10-01 10:00:00',0.45),
(20,'spring_sale','2026-10-01 10:05:00',0.50),
(21,'brand_awareness','2026-10-02 15:00:00',0.60),
(22,'spring_sale','2026-10-01 10:10:00',0.55),
(23,'spring_sale','2026-10-01 10:15:00',0.60),
(24,'brand_awareness','2026-10-02 15:05:00',0.65),
(25,'spring_sale','2026-10-01 10:20:00',0.65),
(26,'spring_sale','2026-10-01 10:25:00',0.70),
(27,'brand_awareness','2026-10-02 15:10:00',0.70),
(28,'spring_sale','2026-10-01 10:30:00',0.75),
(29,'spring_sale','2026-10-01 10:35:00',0.80),
(30,'brand_awareness','2026-10-02 15:15:00',0.75),
(31,'spring_sale','2026-10-01 10:40:00',0.85),
(32,'spring_sale','2026-10-01 10:45:00',0.90),
(33,'brand_awareness','2026-10-02 15:20:00',0.80),
(34,'spring_sale','2026-10-01 10:50:00',0.95),
(35,'spring_sale','2026-10-01 10:55:00',1.00),
(36,'brand_awareness','2026-10-02 15:25:00',0.85),
(37,'spring_sale','2026-10-01 11:00:00',0.45),
(38,'spring_sale','2026-10-01 11:05:00',0.50),
(39,'brand_awareness','2026-10-02 15:30:00',0.90),
(40,'spring_sale','2026-10-01 11:10:00',0.55),
(41,'spring_sale','2026-10-01 11:15:00',0.60),
(42,'brand_awareness','2026-10-02 15:35:00',0.95),
(43,'spring_sale','2026-10-01 11:20:00',0.65),
(44,'spring_sale','2026-10-01 11:25:00',0.70),
(45,'brand_awareness','2026-10-02 15:40:00',1.00),
(46,'spring_sale','2026-10-01 11:30:00',0.75),
(47,'spring_sale','2026-10-01 11:35:00',0.80),
(48,'brand_awareness','2026-10-02 15:45:00',0.30),
(49,'spring_sale','2026-10-01 11:40:00',0.85),
(50,'spring_sale','2026-10-01 11:45:00',0.90),
(51,'brand_awareness','2026-10-02 15:50:00',0.35),
(52,'spring_sale','2026-10-01 11:50:00',0.95),
(53,'spring_sale','2026-10-01 11:55:00',1.00),
(54,'brand_awareness','2026-10-02 15:55:00',0.40),
(55,'spring_sale','2026-10-01 12:00:00',0.45),
(56,'spring_sale','2026-10-01 12:05:00',0.50),
(57,'brand_awareness','2026-10-02 16:00:00',0.45),
(58,'spring_sale','2026-10-01 12:10:00',0.55),
(59,'spring_sale','2026-10-01 12:15:00',0.60),
(60,'brand_awareness','2026-10-02 16:05:00',0.50),
(61,'spring_sale','2026-10-01 12:20:00',0.65),
(62,'spring_sale','2026-10-01 12:25:00',0.70),
(63,'brand_awareness','2026-10-02 16:10:00',0.55),
(64,'spring_sale','2026-10-01 12:30:00',0.75),
(65,'spring_sale','2026-10-01 12:35:00',0.80),
(66,'brand_awareness','2026-10-02 16:15:00',0.60),
(67,'spring_sale','2026-10-01 12:40:00',0.85),
(68,'spring_sale','2026-10-01 12:45:00',0.90),
(69,'brand_awareness','2026-10-02 16:20:00',0.65),
(70,'spring_sale','2026-10-01 12:50:00',0.95),
(71,'spring_sale','2026-10-01 12:55:00',1.00),
(72,'brand_awareness','2026-10-02 16:25:00',0.70),
(73,'spring_sale','2026-10-01 13:00:00',0.45),
(74,'spring_sale','2026-10-01 13:05:00',0.50),
(75,'brand_awareness','2026-10-02 16:30:00',0.75),
(76,'spring_sale','2026-10-01 13:10:00',0.55),
(77,'spring_sale','2026-10-01 13:15:00',0.60),
(78,'brand_awareness','2026-10-02 16:35:00',0.80),
(79,'spring_sale','2026-10-01 13:20:00',0.65),
(80,'spring_sale','2026-10-01 13:25:00',0.70),
(81,'brand_awareness','2026-10-02 16:40:00',0.85),
(82,'spring_sale','2026-10-01 13:30:00',0.75),
(83,'spring_sale','2026-10-01 13:35:00',0.80),
(84,'brand_awareness','2026-10-02 16:45:00',0.90),
(85,'spring_sale','2026-10-01 13:40:00',0.85),
(86,'spring_sale','2026-10-01 13:45:00',0.90),
(87,'brand_awareness','2026-10-02 16:50:00',0.95),
(88,'spring_sale','2026-10-01 13:50:00',0.95),
(89,'spring_sale','2026-10-01 13:55:00',1.00),
(90,'brand_awareness','2026-10-02 16:55:00',1.00),
(91,'spring_sale','2026-10-01 14:00:00',0.45),
(92,'spring_sale','2026-10-01 14:05:00',0.50),
(93,'brand_awareness','2026-10-02 17:00:00',0.30),
(94,'spring_sale','2026-10-01 14:10:00',0.55),
(95,'spring_sale','2026-10-01 14:15:00',0.60),
(96,'brand_awareness','2026-10-02 17:05:00',0.35),
(97,'spring_sale','2026-10-01 14:20:00',0.65),
(98,'spring_sale','2026-10-01 14:25:00',0.70),
(99,'brand_awareness','2026-10-02 17:10:00',0.40),
(100,'spring_sale','2026-10-01 14:30:00',0.75);

-- Querying the ad_clicks table
SELECT * FROM ad_clicks; 

