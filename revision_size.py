#!./virtualenv/bin/python
"""
Calculates the character length and byte length of a random sample of revisions
"""
import random, io
import json, sys

input_stream = io.TextIOWrapper(sys.stdin.buffer, encoding='utf-8')

for line in input_stream:
    if random.random() > float(sys.argv[1]):
        continue

    doc = json.loads(line)
    print("\t".join(str(v) for v in 
                    [doc['id'],
                     doc['page']['namespace'], 
                     len(doc['text']), 
                     len(bytes(doc['text'], 'utf-8'))]))

