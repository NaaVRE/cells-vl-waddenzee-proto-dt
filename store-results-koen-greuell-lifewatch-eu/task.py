
import argparse
import json
import os
arg_parser = argparse.ArgumentParser()


arg_parser.add_argument('--id', action='store', type=str, required=True, dest='id')


arg_parser.add_argument('--vara2', action='store', type=int, required=True, dest='vara2')

arg_parser.add_argument('--vara4', action='store', type=int, required=True, dest='vara4')


args = arg_parser.parse_args()
print(args)

id = args.id

vara2 = args.vara2
vara4 = args.vara4



print(vara2)
print(vara4)

