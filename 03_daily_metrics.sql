CREATE OR REPLACE VIEW daily_311_metrics AS
SELECT
    created_date::date AS request_day,
    COUNT(*) AS total_requests,
    COUNT(*) FILTER (WHERE status = 'Closed') AS closed_requests,
    ROUND(
        100.0 * COUNT(*) FILTER (WHERE status = 'Closed') / COUNT(*),
        1
    ) AS closed_pct,
    ROUND(
        AVG(EXTRACT(EPOCH FROM (closed_date - created_date)) / 3600)
            FILTER (WHERE status = 'Closed' AND closed_date >= created_date),
        1
    ) AS avg_hours_to_close
FROM service_requests
WHERE created_date >= '2026-10-06'
  AND created_date < '2026-10-13'
GROUP BY created_date::date;
