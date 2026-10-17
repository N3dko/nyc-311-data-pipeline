import sys
from datetime import date, timedelta

day = sys.argv[1]
next_day = (date.fromisoformat(day) + timedelta(days=1)).isoformat()
import json
from pathlib import Path
from urllib.parse import urlencode
from urllib.request import urlopen

page_size = 1000
offset = 0
all_records = []

while True:
    parameters = {
        "$select": "unique_key,created_date,closed_date,agency,complaint_type,descriptor,borough,status,latitude,longitude",
        "$where": f"created_date >= '{day}T00:00:00' AND created_date < '{next_day}T00:00:00'",
        "$order": "created_date ASC, unique_key ASC",
        "$limit": page_size,
        "$offset": offset,
    }
    url = "https://data.cityofnewyork.us/resource/erm2-nwe9.json?" + urlencode(parameters)

    with urlopen(url, timeout=60) as response:
        page = json.load(response)

    all_records.extend(page)
    print(f"Изтеглени досега: {len(all_records)}")

    if len(page) < page_size:
        break
    offset += page_size

Path("data").mkdir(parents=True, exist_ok=True)
Path("data/raw_311.json").write_text(
    json.dumps(all_records, indent=2), encoding="utf-8"
)
print(f"Готово за {day}: {len(all_records)} сигнала")
