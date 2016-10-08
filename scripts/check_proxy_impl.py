#!/usr/bin/python

import sys
import os
import string
from translation_rules import *
from translation_helpers import *
from cef_parser import *

cefnames_pattern = re.compile("\/\/\/ CEF name: (`[^`]+`(?:\s*,\s*`[^`]+`)*)")


def check_proxy_impl(cef_class, impl):
    interface_funcs = cef_class.get_static_funcs() + cef_class.get_virtual_funcs()
    referenced_funcs = []
    for value_match in re.finditer(cefnames_pattern, impl):
        refs = [x.strip('` ') for x in value_match.group(1).split(',')]
        referenced_funcs += refs
        
    swift_type_name = cef_capi_type_to_swift(cef_class.get_capi_name())
    
    for func in interface_funcs:
        if not func.get_name() in referenced_funcs:
            print func.get_name() + " not implemented in " + swift_type_name


if len(sys.argv) < 3:
    print "Usage: " + os.path.basename(sys.argv[0]) + " <cef_includes_dir> <proxy_impl_dir>"
    exit(-1)

includes_dir = sys.argv[1]
impl_dir = sys.argv[2]

header = obj_header()
# TODO: remove cef_zip_reader.h when CEF parser is fixed
excluded_files = ['cef_application_mac.h', 'cef_version.h', 'cef_zip_reader.h']
header.add_directory(includes_dir, excluded_files)


for cef_class in header.get_classes():
    if cef_class.is_library_side():
        swift_type_name = cef_capi_type_to_swift(cef_class.get_capi_name())
        
        impl_file = open(os.path.join(impl_dir, swift_type_name + ".swift"), "r")
        impl = impl_file.read()
        impl_file.close()
        
        check_proxy_impl(cef_class, impl)
