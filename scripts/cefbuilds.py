#!/usr/bin/python

import urllib2
import re
import json
import os.path
import argparse
import sys

# fetch page
def fetch_cefbuilds_html():
    response = urllib2.urlopen("https://cefbuilds.com")
    contents = response.read()
    return contents

# extract branches
def get_branches_from_html(html):
    branchref_pattern = re.compile("href=\"#(branch_[^\"]+)\"")
    
    branches = []
    for branch_match in re.finditer(branchref_pattern, html):
        branchref = branch_match.group(1)
        branches.append(branchref.split('_')[1])
    
    return branches

# returns {<platform> => [{version => <version>, s3key => <s3key>]]}
def get_builds_by_platform_for_branch(branch, html, latest_only=False):
    build_entry_pattern = re.compile("<a[^>]* s3key=\"%s/([^/]+)/([^\"]+)\"[^>]*>[^<]*CEF ([^<\n]+)[^<]*</a>" % branch, re.S)
    
    builds_by_platform = dict()
    for entry_match in re.finditer(build_entry_pattern, html):
        platform = entry_match.group(1)
        s3key = branch + "/" + platform + "/" + entry_match.group(2)
        version = entry_match.group(3).translate(None, "\r\n\t")
        
        is_first_entry = not platform in builds_by_platform
        if is_first_entry:
            builds_by_platform[platform] = []
        
        if not latest_only or is_first_entry:
            builds_by_platform[platform].append(dict(version=version, s3key=s3key))
    
    return builds_by_platform

def load_builds_from_file(filename):
    if not os.path.isfile(filename):
        return None
    
    file = open(filename, "r")
    contents = file.read()
    file.close()
    
    builds = json.loads(contents)
    return builds

def save_builds_to_file(builds, filename):
    contents = json.dumps(builds)
    
    file = open(filename, "w")
    file.write(contents)
    file.close()


parser = argparse.ArgumentParser(description='CEFBuilds changelog generator')
parser.add_argument('--platforms', dest='platform_filter', action='store', default=None, help='process only the given platforms (default: all)')
parser.add_argument('--branches', dest='branch_filter', action='store', default=None, help='process only the given branches (default: all)')
parser.add_argument('--stash-dir', dest='stash_dir', action='store', default=".", help='where to stash the computed results (default: current working directory)')
parser.add_argument('-x','--disable-stash', dest='disable_stash', action='store_true', help='if present, computed results are neither loaded nor written to disk')
parser.add_argument('-v','--verbose', dest='verbose', action='store_true', help='verbose mode')
parser.add_argument('cefbuilds_html', type=argparse.FileType('r'))
args = vars(parser.parse_args(sys.argv[1:]))

if 'platform_filter' in args and not args['platform_filter'] is None:
    platform_filter = str(args['platform_filter']).split(',')
else:
    platform_filter = None

if 'branch_filter' in args and not args['branch_filter'] is None:
    branch_filter = str(args['branch_filter']).split(',')
else:
    branch_filter = None

disable_stash = args['disable_stash']
stash_dir = args['stash_dir']
verbose = args['verbose']

html = args['cefbuilds_html'].read()

if verbose:
    print "parsing branches..."
branches = get_branches_from_html(html)

updates = dict()

for branch in branches:
    if not branch_filter is None:
        if not branch in branch_filter:
            if verbose:
                print "skipping branch " + branch + " due to command line switch"
            continue
    
    if verbose:
        print "parsing builds for branch " + branch
    
    current_builds = get_builds_by_platform_for_branch(branch, html, True)
    if not platform_filter is None:
        platforms_to_remove = []
        for platform in current_builds:
            if not platform in platform_filter:
                platforms_to_remove.append(platform)
        
        for platform in platforms_to_remove:
            del current_builds[platform]
    
    if not disable_stash:
        if verbose:
            print "calculating diff"
        filename = stash_dir + "/builds_" + branch + ".json"
        saved_builds = load_builds_from_file(filename)
    else:
        saved_builds = None
    
    for platform, current_build in current_builds.iteritems():
        if (saved_builds is None or
            not platform in saved_builds or
            cmp(current_build[0]['version'], saved_builds[platform][0]['version']) > 0):
            
            if not branch in updates:
                updates[branch] = dict()
            
            updates[branch][platform] = dict(version=current_build[0]['version'], s3key=current_build[0]['s3key'])
            if verbose:
                print " - new build available for " + platform + ": " + current_build[0]['version']
    
    if not disable_stash:
        if verbose:
            print "stashing results"
        save_builds_to_file(current_builds, filename)

if len(updates) > 0:
    print json.dumps(updates)
