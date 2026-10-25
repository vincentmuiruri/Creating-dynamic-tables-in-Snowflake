# Synthetic Data for Nursery Truck Loading System

## Overview
This synthetic dataset simulates a real-world nursery truck loading tracking system for the Regeneration Kenya project. The data represents the delivery of tree seedlings and farm inputs to farmers across various Kenyan counties.

## Data Structure

### 1. Main Table: `nursery_truck_loading_sheet_kenya`
**Records: 5 main shipments**

Contains the primary shipment information including:
- Officer details (nursery officer, field clerk, receiving officer)
- Location data (county, sub-county, ward, farmer)
- Submission metadata (dates, device IDs, form versions)
- Approval status and signatures

**Sample Counties Covered:**
- Kiambu (Kikuyu)
- Kisumu (Kisumu East)
- Nakuru (Nakuru West)
- Meru (Imenti South)
- Nyeri (Nyeri Central)

### 2. Species Repeat Table: `nursery_truck_loading_sheet_species_repeat_kenya`
**Records: 14 species entries across 5 shipments**

Contains tree species information for each shipment:
- Common species: Grevillea, Croton, Mangifera (Mango), Eucalyptus
- Indigenous species: Melia volkensii, Faidherbia albida, Cordia africana
- Fruit trees: Citrus (Orange), Macadamia, Persea (Avocado)

**Distribution:**
- Shipment 1: 3 species (500 total seedlings)
- Shipment 2: 2 species (350 total seedlings)
- Shipment 3: 4 species (600 total seedlings)
- Shipment 4: 3 species (450 total seedlings)
- Shipment 5: 2 species (300 total seedlings)

### 3. Farm Inputs Repeat Table: `nursery_truck_loading_sheet_farm_inputs_repeat_kenya`
**Records: 11 input entries across 5 shipments**

Contains farm supplies delivered with seedlings:
- Fertilizers: NPK, DAP, Urea
- Organic amendments: Compost, Organic Manure
- Other supplies: Pesticides, Tree Guards, Irrigation Pipes, Water Tanks

**Distribution:**
- Shipment 1: 2 inputs
- Shipment 2: 3 inputs
- Shipment 3: 2 inputs
- Shipment 4: 1 input
- Shipment 5: 3 inputs

## Parent-Child Relationships

The data uses KEY-PARENT_KEY relationships:
```
main_001 (Kiambu shipment)
├── species_001_001 (Grevillea robusta - 200)
├── species_001_002 (Croton megalocarpus - 150)
├── species_001_003 (Calliandra calothyrsus - 150)
├── inputs_001_001 (Fertilizer NPK - 10)
└── inputs_001_002 (Pesticides - 5)
```

## Expected Dynamic Table Output

When the dynamic table is created, it performs a **Cartesian product** of species and inputs for each shipment:

```
Total Expected Rows = Sum of (species_count × inputs_count for each main record)
= (3×2) + (2×3) + (4×2) + (3×1) + (2×3)
= 6 + 6 + 8 + 3 + 6
= 29 rows
```

### Sample Output Row:
```
Main: John Kamau → Kiambu → Peter Mwangi
Species: Grevillea robusta (200 seedlings)
Input: Fertilizer NPK (10 units)
```

## Usage Instructions

### Step 1: Create the Base Tables and Insert Data
```sql
-- Run the synthetic_data_nursery_loading.sql script
```

### Step 2: Create the Dynamic Table
```sql
-- Run your original dynamic table creation script
CREATE OR REPLACE DYNAMIC TABLE "REGENERATION_KENYA"."ODK"."all_nursery_truck_loading_combined"
TARGET_LAG = '1 minute'
WAREHOUSE = 'COMPUTE_WH'
AS
-- (your complete query here)
```

### Step 3: Verify the Results
```sql
-- Check total rows (should be 29)
SELECT COUNT(*) FROM "REGENERATION_KENYA"."ODK"."all_nursery_truck_loading_combined";

-- View sample combinations
SELECT 
    "general_group-nursery_officer",
    "site_group-county",
    species_type,
    species_count,
    inputs_type,
    inputs_count
FROM "REGENERATION_KENYA"."ODK"."all_nursery_truck_loading_combined"
ORDER BY KEY, species_type, inputs_type
LIMIT 10;
```

## Data Quality Notes

1. **Realistic Data**: All names, locations, and species are appropriate for Kenya
2. **Complete Records**: Every main record has both species and inputs (no NULL arrays)
3. **Varied Complexity**: Different records have different numbers of species/inputs to test edge cases
4. **Status Variety**: Most approved, one pending to test filtering
5. **Version Tracking**: Includes form versions and edit counts

## Troubleshooting

If you get fewer than 29 rows:
- Check that all PARENT_KEY values match existing KEY values
- Verify the LATERAL FLATTEN is working correctly
- Ensure ARRAY_AGG is grouping properly

If you get NULL values:
- Check the COALESCE logic for empty arrays
- Verify the OBJECT_CONSTRUCT field names match

## Test Queries

### Test 1: Verify All Relationships
```sql
SELECT 
    m.KEY,
    COUNT(DISTINCT s.KEY) AS species_count,
    COUNT(DISTINCT f.KEY) AS inputs_count,
    COUNT(DISTINCT s.KEY) * COUNT(DISTINCT f.KEY) AS expected_rows
FROM "REGENERATION_KENYA"."ODK"."nursery_truck_loading_sheet_kenya" m
LEFT JOIN "REGENERATION_KENYA"."ODK"."nursery_truck_loading_sheet_species_repeat_kenya" s 
    ON m.KEY = s.PARENT_KEY
LEFT JOIN "REGENERATION_KENYA"."ODK"."nursery_truck_loading_sheet_farm_inputs_repeat_kenya" f 
    ON m.KEY = f.PARENT_KEY
GROUP BY m.KEY;
```

### Test 2: Verify Specific Shipment
```sql
-- Check Kiambu shipment (should produce 6 rows: 3 species × 2 inputs)
SELECT *
FROM "REGENERATION_KENYA"."ODK"."all_nursery_truck_loading_combined"
WHERE KEY = 'main_001';
```

