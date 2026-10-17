CREATE OR REPLACE VIEW borough_complaint_metrics AS
SELECT
    borough,
    complaint_type,
    COUNT(*) AS total_requests,
    COUNT(*) FILTER (WHERE status = 'Closed') AS closed_requests
FROM service_requests
WHERE created_date >= '2026-10-06'
  AND created_date < '2026-10-13'
GROUP BY borough, complaint_type;
