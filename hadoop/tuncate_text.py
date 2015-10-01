#!./virtualenv/bin/python
"""
Truncates the 'text' field of JSON blobs to a limited length in unicode
characters.  The default '--max-chars' was set for addressing content dump
vandalism in English Wikipedia.  This script adds a boolean 'truncated' field
that will be True when the text field was changes and False when it was not.

Usage:
    truncate_text (-h|--help)
    truncate_text [--max-chars=<num>] [--verbose]

Options:
    -h|--help          Print this documentation
    --max-chars=<num>  The maximum number of characters that are allowed in a
                       'text' field. [default: 2097152]
    --verbose          Prints debugging information.
"""
import io
import json
import sys

import docopt


def main(argv=None):
    args = docopt.docopt(__doc__, argv=argv)

    input_stream = io.TextIOWrapper(sys.stdin.buffer, encoding='utf-8')
    docs = (json.loads(line) for line in input_stream)
    max_chars = int(args['--max-chars'])
    verbose = args['--verbose']

    run(docs, max_chars, verbose)


def run(docs, max_chars, verbose):

    for doc in truncate_text(docs, max_chars):
        if verbose and doc['truncated']:
            sys.stderr.write(".")
            sys.stderr.flush()
        json.dump(doc, sys.stdout)
        sys.stdout.write("\n")

    if verbose:
        sys.stderr.write("\n")
        sys.stderr.flush()


def truncate_text(docs, max_chars):

    for doc in docs:
        if len(doc['text']) > max_chars:
            doc['text'] = doc['text'][:max_chars]
            doc['truncated'] = True
        else:
            doc['truncated'] = False

        yield doc
