#!/usr/bin/env python3

import urllib
import urllib.parse
import re
import json
import os.path
import argparse
import sys

base_url = "https://cef-builds.spotifycdn.com"
distributions = [
    "standard",
    "minimal",
    "client",
    "debug_symbols",
    "release_symbols"
]

def compare_versions(ver1, ver2):
    def cmp(a, b):
        return (a > b) - (a < b) 
    def normalize(v):
        return [int(x) for x in re.sub(r'(\.0+)*$','', v).split(".")]
    return cmp(normalize(ver1), normalize(ver2))

# fetch page
def fetch_cefbuilds_json():
    response = urllib.request.urlopen(base_url + "/index.json")
    contents = response.read()
    return contents

# returns {<branch1> => {delta => <delta>, commit => <git_sha1>, dists => {<dist> => <artifact_url>, ...}}, <branch2> => ...}
def get_latest_builds_for_platform(platform, builds_json):
    build_specs = builds_json[platform]['versions']
    
    builds = dict()
    for spec in build_specs:
        cef_version = spec['cef_version']
        if '+' in cef_version:
            # 73.1.3+g46cf800+chromium-73.0.3683.75
            spec_comps = cef_version.split('+')
            tag = spec_comps[0]
            branch = spec_comps[2].split('.')[2]
            commit = spec_comps[1][1:]
        else:
            # 3.3578.1869.gcc1dc0f
            spec_comps = cef_version.split('.')
            tag = "0.0." + spec_comps[2]
            branch = spec_comps[1]
            commit = spec_comps[3][1:]
        
        if not branch in builds or compare_versions(builds[branch]['tag'], tag) < 0:
            dists = dict()
            for spec_file in spec['files']:
                dists[spec_file['type']] = base_url + '/' + urllib.parse.quote(spec_file['name'])
            
            builds[branch] = {
                'tag': tag, 
                'commit': commit,
                'dists': dists
            }
            
    return builds

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
parser.add_argument('cefbuilds_json', type=argparse.FileType('r'))
args = vars(parser.parse_args(sys.argv[1:]))

if 'platform_filter' in args and not args['platform_filter'] is None:
    platform_filter = args['platform_filter'].split(',')
else:
    platform_filter = ['linux32', 'linux64', 'linuxarm', 'linuxarm64', 'macosarm64', 'macosx64', 'windows32', 'windows64', 'windowsarm64']

if 'branch_filter' in args and not args['branch_filter'] is None:
    branch_filter = args['branch_filter'].split(',')
else:
    branch_filter = None

disable_stash = args['disable_stash']
stash_dir = args['stash_dir']
verbose = args['verbose']

builds_json = json.loads(args['cefbuilds_json'].read())
updates = dict()
builds = []

for platform in platform_filter:
    if verbose:
        print("parsing builds for platform " + platform)
    platform_builds = get_latest_builds_for_platform(platform, builds_json)
    
    if not branch_filter is None:
        current_builds = dict()
        for branch in platform_builds.keys():
            if not branch in branch_filter:
                if verbose:
                    print("skipping branch " + branch + " due to command line switch")
                continue
            else:
                current_builds[branch] = platform_builds[branch]
    else:
        current_builds = platform_builds
    
    if not disable_stash:
        if verbose:
            print("calculating diff")
        filename = stash_dir + "/builds_" + platform + ".json"
        saved_builds = load_builds_from_file(filename)
    else:
        saved_builds = None
    
    for branch, current_build in iter(current_builds.items()):
        if saved_builds is None or \
           not branch in saved_builds or \
           'tag' in current_build and not 'tag' in saved_builds['branch'] or \
           compare_versions(current_build['tag'], saved_builds['branch']['tag'] if 'tag' in saved_builds['branch'] else ("0.0." + saved_builds['branch']['delta'])) > 0:
            
            if not platform in updates:
                updates[platform] = dict()
            
            updates[platform][branch] = current_build
            if verbose:
                print(" - new build available for " + platform + ": " + branch + " -> " + current_build['tag'] if 'tag' in current_build else current_build['delta'])
    
    if not disable_stash:
        if verbose:
            print("stashing results")
        save_builds_to_file(current_builds, filename)

if len(updates) > 0:
    print(json.dumps(updates))
