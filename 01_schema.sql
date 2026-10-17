CREATE TABLE IF NOT EXISTS public.service_requests (
    unique_key TEXT PRIMARY KEY,
    created_date TIMESTAMP NOT NULL,
    closed_date TIMESTAMP,
    agency TEXT,
    complaint_type TEXT,
    descriptor TEXT,
    borough TEXT,
    status TEXT,
    latitude DOUBLE PRECISION,
    longitude DOUBLE PRECISION,
    loaded_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS public.service_requests_stage (
    unique_key TEXT,
    created_date TIMESTAMP,
    closed_date TIMESTAMP,
    agency TEXT,
    complaint_type TEXT,
    descriptor TEXT,
    borough TEXT,
    status TEXT,
    latitude DOUBLE PRECISION,
    longitude DOUBLE PRECISION,
    loaded_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
