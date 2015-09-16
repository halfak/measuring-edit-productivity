"""
Drops the text field from a RevisionDocument.  Dramatically saves space. 
"""
import json, sys


for line in sys.stdin:
	doc = json.loads(line)
	
	if 'text' in doc:
		del doc['text']
	if 'revision' in doc and 'text' in doc['revision']:
		del doc['revision']['text']
	
	json.dump(doc, sys.stdout)
	sys.stdout.write("\n")
