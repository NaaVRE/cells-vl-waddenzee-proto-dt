
import argparse
import json
import os
arg_parser = argparse.ArgumentParser()


arg_parser.add_argument('--id', action='store', type=str, required=True, dest='id')


arg_parser.add_argument('--vara1', action='store', type=int, required=True, dest='vara1')

arg_parser.add_argument('--vara3', action='store', type=int, required=True, dest='vara3')


args = arg_parser.parse_args()
print(args)

id = args.id

vara1 = args.vara1
vara3 = args.vara3



vara2 = vara1
vara4 = vara3

file_vara2 = open("/tmp/vara2_" + id + ".json", "w")
file_vara2.write(json.dumps(vara2))
file_vara2.close()
file_vara4 = open("/tmp/vara4_" + id + ".json", "w")
file_vara4.write(json.dumps(vara4))
file_vara4.close()
