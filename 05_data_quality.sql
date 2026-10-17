SELECT
    COUNT(*) AS total_requests,
    COUNT(*) FILTER (
        WHERE borough IS NULL OR borough = ''
    ) AS missing_borough,
    COUNT(*) FILTER (
        WHERE complaint_type IS NULL OR complaint_type = ''
    ) AS missing_complaint_type,
    COUNT(*) FILTER (
        WHERE closed_date < created_date
    ) AS invalid_close_dates
FROM service_requests
WHERE created_date >= '2026-10-06'
  AND created_date < '2026-10-13';
