from dtAcolite import dtAcolite

import argparse
import json
import os
arg_parser = argparse.ArgumentParser()


arg_parser.add_argument('--id', action='store', type=str, required=True, dest='id')


arg_parser.add_argument('--path_ids', action='store', type=str, required=True, dest='path_ids')


args = arg_parser.parse_args()
print(args)

id = args.id

path_ids = json.loads(args.path_ids)



year = 2016
start_date = f"{year}-01-01"
end_date   = f"{year}-12-31"
data_collection = "SENTINEL-2"
product_type = "S2MSI1C"
aoi = "POLYGON((4.6 53.1, 4.9 53.1, 4.9 52.8, 4.6 52.8, 4.6 53.1))'"
collection = "sentinel"

app_configuration = dtAcolite.configure_acolite_directory(base_dir = "/tmp/data", year = year, collection = collection)
print(app_configuration)

file_acolite_processing = open("/tmp/acolite_processing_" + id + ".json", "w")
file_acolite_processing.write(json.dumps(acolite_processing))
file_acolite_processing.close()
