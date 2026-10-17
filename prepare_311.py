import csv
import json
from pathlib import Path

fields = [
    "unique_key", "created_date", "closed_date", "agency",
    "complaint_type", "descriptor", "borough", "status", "latitude", "longitude",
]

records = json.loads(Path("data/raw_311.json").read_text(encoding="utf-8"))

with Path("data/requests.csv").open("w", newline="", encoding="utf-8") as file:
    writer = csv.DictWriter(file, fieldnames=fields)
    writer.writeheader()
    for record in records:
        writer.writerow({field: record.get(field, "") for field in fields})

print(f"Подготвени редове: {len(records)}")
