-- Extract date part from timestamp_str (replace format if needed)
WITH extracted_date AS (
  SELECT
    *,
    CASE WHEN ORDER_DATE IS NULL THEN current_date
         ELSE TRY_CAST(ORDER_DATE AS timestamp)
    END AS ORDER_DATE
  FROM dbt_ad.jaffle_shop_orders
)
-- Select desired date format
SELECT
  -- Extract year, month, day components
  YEAR(ORDER_DATE) * 10000 +
  MONTH(ORDER_DATE) * 100 +
  DAY(ORDER_DATE) AS ds_business_time
FROM extracted_date;