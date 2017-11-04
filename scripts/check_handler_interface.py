#!/usr/bin/python

from __future__ import print_function
import sys
import os
import string
from translation_rules import *
from translation_helpers import *
from cef_parser import *

cefnames_pattern = re.compile("\/\/\/ CEF name: (`[^`]+`(?:\s*,\s*`[^`]+`)*)")

missing_declarations = []

def check_handler_interface(cef_class, interface):
    interface_funcs = cef_class.get_virtual_funcs()
    referenced_funcs = []
    for value_match in re.finditer(cefnames_pattern, interface):
        refs = [x.strip('` ') for x in value_match.group(1).split(',')]
        referenced_funcs += refs
        
    swift_type_name = cef_capi_type_to_swift(cef_class.get_capi_name())
    
    for func in interface_funcs:
        if not func.get_name() in referenced_funcs:
            global missing_declarations
            missing_declarations.append(swift_type_name + '.' + func.get_name())
            print(func.get_name() + " not declared in " + swift_type_name, file=sys.stderr)


if len(sys.argv) < 3:
    print("Usage: " + os.path.basename(sys.argv[0]) + " <cef_includes_dir> <handler_interface_dir>")
    exit(-1)

includes_dir = sys.argv[1]
interface_dir = sys.argv[2]

header = obj_header()
excluded_files = ['cef_application_mac.h', 'cef_version.h']
header.add_directory(includes_dir, excluded_files)


for cef_class in header.get_classes():
    if not cef_class.is_library_side():
        swift_type_name = cef_capi_type_to_swift(cef_class.get_capi_name())
        
        if_file_path = os.path.join(interface_dir, swift_type_name + ".swift")
        if not os.path.exists(if_file_path):
            missing_declarations.append(swift_type_name)
            print("interface missing for " + swift_type_name, file=sys.stderr)
            continue
        
        interface_file = open(if_file_path, "r")
        interface = interface_file.read()
        interface_file.close()
        
        check_handler_interface(cef_class, interface)

if len(missing_declarations) > 0:
    exit(-2)
