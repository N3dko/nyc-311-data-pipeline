#!/usr/bin/env bash
set -euo pipefail

python3 fetch_day.py "$1"
python3 prepare_311.py

sudo -u postgres psql -X -v ON_ERROR_STOP=1 -d nyc_311 \
  -c "TRUNCATE TABLE service_requests_stage;"

sudo -u postgres psql -X -v ON_ERROR_STOP=1 -d nyc_311 \
  -c "\copy service_requests_stage (unique_key, created_date, closed_date, agency, complaint_type, descriptor, borough, status, latitude, longitude) FROM STDIN WITH (FORMAT csv, HEADER true)" \
  < data/requests.csv

sudo -u postgres psql -X -v ON_ERROR_STOP=1 -d nyc_311 < 02_upsert.sql

echo "Зареждането приключи успешно."
