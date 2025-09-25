
import argparse
import json
import os
arg_parser = argparse.ArgumentParser()


arg_parser.add_argument('--id', action='store', type=str, required=True, dest='id')



args = arg_parser.parse_args()
print(args)

id = args.id




vara1 = 1
vara3 = 3

file_vara1 = open("/tmp/vara1_" + id + ".json", "w")
file_vara1.write(json.dumps(vara1))
file_vara1.close()
file_vara3 = open("/tmp/vara3_" + id + ".json", "w")
file_vara3.write(json.dumps(vara3))
file_vara3.close()
