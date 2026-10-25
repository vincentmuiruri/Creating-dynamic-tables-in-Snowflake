-- ============================================================================
-- Synthetic Data for Nursery Truck Loading System
-- Database: REGENERATION_KENYA, Schema: ODK
-- ============================================================================

USE DATABASE "REGENERATION_KENYA";
USE SCHEMA ODK;

-- ============================================================================
-- 1. CREATE MAIN TABLE: nursery_truck_loading_sheet_kenya
-- ============================================================================

CREATE OR REPLACE TABLE "REGENERATION_KENYA"."ODK"."nursery_truck_loading_sheet_kenya" (
    SubmissionDate TIMESTAMP_NTZ,
    "general_group-nursery_officer" VARCHAR(255),
    "general_group-date" DATE,
    "general_group-field_clerk" VARCHAR(255),
    "general_group-not_listed" VARCHAR(255),
    "site_group-county" VARCHAR(100),
    "site_group-sub_county" VARCHAR(100),
    "site_group-ward" VARCHAR(100),
    "site_group-farmer" VARCHAR(255),
    total_species INTEGER,
    total_note VARCHAR(500),
    receiving_officer VARCHAR(255),
    nursery_signature VARCHAR(255),
    receiver_signature VARCHAR(255),
    "meta-instanceID" VARCHAR(255),
    KEY VARCHAR(255) PRIMARY KEY,
    SubmitterID INTEGER,
    SubmitterName VARCHAR(255),
    AttachmentsPresent INTEGER,
    AttachmentsExpected INTEGER,
    Status VARCHAR(50),
    ReviewState VARCHAR(50),
    DeviceID VARCHAR(255),
    Edits INTEGER,
    FormVersion VARCHAR(50)
);

-- ============================================================================
-- 2. CREATE SPECIES REPEAT TABLE
-- ============================================================================

CREATE OR REPLACE TABLE "REGENERATION_KENYA"."ODK"."nursery_truck_loading_sheet_species_repeat_kenya" (
    species_type VARCHAR(255),
    species_count INTEGER,
    species_count_helper INTEGER,
    PARENT_KEY VARCHAR(255),
    KEY VARCHAR(255) PRIMARY KEY
);

-- ============================================================================
-- 3. CREATE FARM INPUTS REPEAT TABLE
-- ============================================================================

CREATE OR REPLACE TABLE "REGENERATION_KENYA"."ODK"."nursery_truck_loading_sheet_farm_inputs_repeat_kenya" (
    inputs_type VARCHAR(255),
    inputs_not_listed VARCHAR(255),
    inputs_count INTEGER,
    inputs_count_helper INTEGER,
    PARENT_KEY VARCHAR(255),
    KEY VARCHAR(255) PRIMARY KEY
);

-- ============================================================================
-- 4. INSERT SYNTHETIC DATA - MAIN TABLE
-- ============================================================================

INSERT INTO "REGENERATION_KENYA"."ODK"."nursery_truck_loading_sheet_kenya" VALUES
(
    '2024-01-15 09:30:00',
    'John Kamau',
    '2024-01-15',
    'Mary Wanjiru',
    NULL,
    'Kiambu',
    'Kikuyu',
    'Kinoo',
    'Peter Mwangi',
    500,
    'Good quality seedlings, well watered',
    'Sarah Njeri',
    'signature_nursery_001.png',
    'signature_receiver_001.png',
    'uuid:12345-abcde-67890-fghij',
    'main_001',
    1001,
    'John Kamau',
    0,
    0,
    'Approved',
    'Approved',
    'device_001',
    0,
    '1.0'
),
(
    '2024-01-16 10:15:00',
    'Grace Akinyi',
    '2024-01-16',
    'James Omondi',
    NULL,
    'Kisumu',
    'Kisumu East',
    'Kajulu',
    'David Otieno',
    350,
    'Seedlings ready for planting season',
    'Lucy Adhiambo',
    'signature_nursery_002.png',
    'signature_receiver_002.png',
    'uuid:23456-bcdef-78901-ghijk',
    'main_002',
    1002,
    'Grace Akinyi',
    0,
    0,
    'Approved',
    'Approved',
    'device_002',
    0,
    '1.0'
),
(
    '2024-01-17 08:45:00',
    'Moses Kipchoge',
    '2024-01-17',
    'Agnes Cherono',
    NULL,
    'Nakuru',
    'Nakuru West',
    'Bahati',
    'Daniel Rotich',
    600,
    'Extra fertilizer included',
    'Ruth Jepkosgei',
    'signature_nursery_003.png',
    'signature_receiver_003.png',
    'uuid:34567-cdefg-89012-hijkl',
    'main_003',
    1003,
    'Moses Kipchoge',
    0,
    0,
    'Pending',
    'Pending',
    'device_003',
    1,
    '1.0'
),
(
    '2024-01-18 11:00:00',
    'Faith Mutua',
    '2024-01-18',
    'Joseph Kariuki',
    NULL,
    'Meru',
    'Imenti South',
    'Abothuguchi',
    'Samuel Mwenda',
    450,
    'Mixed indigenous species',
    'Anne Kaimuri',
    'signature_nursery_004.png',
    'signature_receiver_004.png',
    'uuid:45678-defgh-90123-ijklm',
    'main_004',
    1004,
    'Faith Mutua',
    0,
    0,
    'Approved',
    'Approved',
    'device_004',
    0,
    '1.1'
),
(
    '2024-01-19 13:20:00',
    'Robert Njoroge',
    '2024-01-19',
    'Catherine Wambui',
    NULL,
    'Nyeri',
    'Nyeri Central',
    'Ruring''u',
    'Patrick Githuku',
    300,
    'Fruit trees for agroforestry',
    'Jane Wangari',
    'signature_nursery_005.png',
    'signature_receiver_005.png',
    'uuid:56789-efghi-01234-jklmn',
    'main_005',
    1005,
    'Robert Njoroge',
    0,
    0,
    'Approved',
    'Approved',
    'device_005',
    0,
    '1.1'
);

-- ============================================================================
-- 5. INSERT SYNTHETIC DATA - SPECIES REPEAT TABLE
-- ============================================================================

-- Species for main_001 (3 species types)
INSERT INTO "REGENERATION_KENYA"."ODK"."nursery_truck_loading_sheet_species_repeat_kenya" VALUES
('Grevillea robusta', 200, 200, 'main_001', 'species_001_001'),
('Croton megalocarpus', 150, 150, 'main_001', 'species_001_002'),
('Calliandra calothyrsus', 150, 150, 'main_001', 'species_001_003');

-- Species for main_002 (2 species types)
INSERT INTO "REGENERATION_KENYA"."ODK"."nursery_truck_loading_sheet_species_repeat_kenya" VALUES
('Mangifera indica', 200, 200, 'main_002', 'species_002_001'),
('Persea americana', 150, 150, 'main_002', 'species_002_002');

-- Species for main_003 (4 species types)
INSERT INTO "REGENERATION_KENYA"."ODK"."nursery_truck_loading_sheet_species_repeat_kenya" VALUES
('Eucalyptus grandis', 200, 200, 'main_003', 'species_003_001'),
('Markhamia lutea', 150, 150, 'main_003', 'species_003_002'),
('Senna spectabilis', 150, 150, 'main_003', 'species_003_003'),
('Acacia mearnsii', 100, 100, 'main_003', 'species_003_004');

-- Species for main_004 (3 species types)
INSERT INTO "REGENERATION_KENYA"."ODK"."nursery_truck_loading_sheet_species_repeat_kenya" VALUES
('Melia volkensii', 150, 150, 'main_004', 'species_004_001'),
('Faidherbia albida', 150, 150, 'main_004', 'species_004_002'),
('Cordia africana', 150, 150, 'main_004', 'species_004_003');

-- Species for main_005 (2 species types)
INSERT INTO "REGENERATION_KENYA"."ODK"."nursery_truck_loading_sheet_species_repeat_kenya" VALUES
('Citrus sinensis', 150, 150, 'main_005', 'species_005_001'),
('Macadamia integrifolia', 150, 150, 'main_005', 'species_005_002');

-- ============================================================================
-- 6. INSERT SYNTHETIC DATA - FARM INPUTS REPEAT TABLE
-- ============================================================================

-- Farm inputs for main_001 (2 input types)
INSERT INTO "REGENERATION_KENYA"."ODK"."nursery_truck_loading_sheet_farm_inputs_repeat_kenya" VALUES
('Fertilizer - NPK', NULL, 10, 10, 'main_001', 'inputs_001_001'),
('Pesticides', NULL, 5, 5, 'main_001', 'inputs_001_002');

-- Farm inputs for main_002 (3 input types)
INSERT INTO "REGENERATION_KENYA"."ODK"."nursery_truck_loading_sheet_farm_inputs_repeat_kenya" VALUES
('Fertilizer - DAP', NULL, 15, 15, 'main_002', 'inputs_002_001'),
('Organic Manure', NULL, 20, 20, 'main_002', 'inputs_002_002'),
('Mulching Material', NULL, 10, 10, 'main_002', 'inputs_002_003');

-- Farm inputs for main_003 (2 input types)
INSERT INTO "REGENERATION_KENYA"."ODK"."nursery_truck_loading_sheet_farm_inputs_repeat_kenya" VALUES
('Fertilizer - NPK', NULL, 12, 12, 'main_003', 'inputs_003_001'),
('Water Tanks', NULL, 2, 2, 'main_003', 'inputs_003_002');

-- Farm inputs for main_004 (1 input type)
INSERT INTO "REGENERATION_KENYA"."ODK"."nursery_truck_loading_sheet_farm_inputs_repeat_kenya" VALUES
('Compost', NULL, 25, 25, 'main_004', 'inputs_004_001');

-- Farm inputs for main_005 (3 input types)
INSERT INTO "REGENERATION_KENYA"."ODK"."nursery_truck_loading_sheet_farm_inputs_repeat_kenya" VALUES
('Fertilizer - Urea', NULL, 8, 8, 'main_005', 'inputs_005_001'),
('Tree Guards', NULL, 300, 300, 'main_005', 'inputs_005_002'),
('Irrigation Pipes', NULL, 50, 50, 'main_005', 'inputs_005_003');

-- ============================================================================
-- 7. VERIFICATION QUERIES
-- ============================================================================

-- Check main table records
SELECT COUNT(*) AS main_records FROM "REGENERATION_KENYA"."ODK"."nursery_truck_loading_sheet_kenya";

-- Check species records
SELECT COUNT(*) AS species_records FROM "REGENERATION_KENYA"."ODK"."nursery_truck_loading_sheet_species_repeat_kenya";

-- Check farm inputs records
SELECT COUNT(*) AS inputs_records FROM "REGENERATION_KENYA"."ODK"."nursery_truck_loading_sheet_farm_inputs_repeat_kenya";

-- View relationship counts
SELECT 
    m.KEY,
    m."general_group-nursery_officer",
    COUNT(DISTINCT s.KEY) AS species_count,
    COUNT(DISTINCT f.KEY) AS inputs_count
FROM "REGENERATION_KENYA"."ODK"."nursery_truck_loading_sheet_kenya" m
LEFT JOIN "REGENERATION_KENYA"."ODK"."nursery_truck_loading_sheet_species_repeat_kenya" s 
    ON m.KEY = s.PARENT_KEY
LEFT JOIN "REGENERATION_KENYA"."ODK"."nursery_truck_loading_sheet_farm_inputs_repeat_kenya" f 
    ON m.KEY = f.PARENT_KEY
GROUP BY m.KEY, m."general_group-nursery_officer"
ORDER BY m.KEY;

-- ============================================================================
-- 8. EXPECTED OUTPUT AFTER DYNAMIC TABLE CREATION
-- ============================================================================

-- After creating the dynamic table, you should get:
-- Main Record 1: 3 species × 2 inputs = 6 rows
-- Main Record 2: 2 species × 3 inputs = 6 rows
-- Main Record 3: 4 species × 2 inputs = 8 rows
-- Main Record 4: 3 species × 1 input = 3 rows
-- Main Record 5: 2 species × 3 inputs = 6 rows
-- TOTAL EXPECTED: 29 rows in the combined dynamic table

-- Preview what the dynamic table should produce
SELECT 
    m.KEY AS main_key,
    m."general_group-nursery_officer",
    s.species_type,
    s.species_count,
    f.inputs_type,
    f.inputs_count
FROM "REGENERATION_KENYA"."ODK"."nursery_truck_loading_sheet_kenya" m
CROSS JOIN "REGENERATION_KENYA"."ODK"."nursery_truck_loading_sheet_species_repeat_kenya" s
CROSS JOIN "REGENERATION_KENYA"."ODK"."nursery_truck_loading_sheet_farm_inputs_repeat_kenya" f
WHERE s.PARENT_KEY = m.KEY AND f.PARENT_KEY = m.KEY
ORDER BY m.KEY, s.species_type, f.inputs_type
LIMIT 20;
