#!/usr/bin/python

import sys
import os
import re
import string
from translation_helpers import *


def swiftdocify(cef_comment):
    level = len(cef_comment.group(1)) // 4
    swiftdoc_comment = make_swiftdoc_comment(strip_c_comment_prefix(cef_comment.group(2)))
    return indent_multiline_string(swiftdoc_comment, level).rstrip()

if len(sys.argv) < 2:
    print "Usage: " + os.path.basename(sys.argv[0]) + " <src_file> [<dst_file>]"
    exit(-1)
    

infile_path = sys.argv[1]
if len(sys.argv) >= 3:
    outfile_path = sys.argv[2]
else:
    outfile_path = infile_path

infile = open(infile_path, "r")
infile_contents = infile.read()
infile.close()

comment_pattern = re.compile("([^\\S\n]*)\/\/\/\s*\n((?:\s*\/\/(?!\/)[^\n]*\n)+)\s*\/\/\/", re.S)
outfile_contents = re.sub(comment_pattern, swiftdocify, infile_contents)

dst_dir = os.path.dirname(outfile_path)
if not os.access(dst_dir, os.F_OK):
    os.makedirs(dst_dir)

outfile = open(outfile_path, "w")
outfile.write(outfile_contents)
outfile.close()
