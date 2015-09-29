"""
Samples tokens from a set of persistence files.

Usage:
    sample_tokens [<persistence-file>...] --rate=<val>

Options:
    <persistence-file>  A file of revision JSON docs containing persistence
                        information
    --rate=<val>        The rate at which tokens should be sampled.
"""
import json
import random
import re
import sys

import docopt
import mwcli.files
import para

import mysqltsv

HEADERS = ['rev_id', 'token', 'is_whitespace', 'contains_letters', 'persisted',
           'seconds_visible', 'non_self_persisted', 'seconds_possible',
           'revisions_processed', 'non_self_processed']

LETTERS_RE = re.compile(r'[^\W\d]+')


def main(argv=None):
    args = docopt.docopt(__doc__, argv=argv)

    if len(args['<persistence-file>']) == 0:
        paths = [sys.stdin]
    else:
        paths = args['<persistence-file>']

    rate = float(args['--rate'])

    run(paths, rate)


def run(paths, rate):

    writer = mysqltsv.Writer(sys.stdout, headers=HEADERS)

    def process_path(path):
        f = mwcli.files.reader(path)

        return sample_tokens((json.loads(line) for line in f), rate)

    for values in para.map(process_path, paths):
        writer.write(values)


def sample_tokens(rev_docs, rate):
    for rev_doc in rev_docs:
        for token_doc in rev_doc['persistence']['tokens']:
            if random.random() <= rate:
                yield (rev_doc['id'],
                       token_doc['text'],
                       len(token_doc['text'].strip()) == 0,
                       LETTERS_RE.match(token_doc['text']) is not None,
                       token_doc['persisted'],
                       token_doc['seconds_visible'],
                       token_doc['non_self_persisted'],
                       rev_doc['persistence']['seconds_possible'],
                       rev_doc['persistence']['revisions_processed'],
                       rev_doc['persistence']['non_self_processed'])
