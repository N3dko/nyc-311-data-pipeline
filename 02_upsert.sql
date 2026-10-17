INSERT INTO service_requests (
    unique_key, created_date, closed_date, agency,
    complaint_type, descriptor, borough, status,
    latitude, longitude
)
SELECT
    unique_key, created_date, closed_date, agency,
    complaint_type, descriptor, borough, status,
    latitude, longitude
FROM service_requests_stage
WHERE TRUE
ON CONFLICT (unique_key) DO UPDATE SET
    created_date = EXCLUDED.created_date,
    closed_date = EXCLUDED.closed_date,
    agency = EXCLUDED.agency,
    complaint_type = EXCLUDED.complaint_type,
    descriptor = EXCLUDED.descriptor,
    borough = EXCLUDED.borough,
    status = EXCLUDED.status,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude,
    loaded_at = NOW();
