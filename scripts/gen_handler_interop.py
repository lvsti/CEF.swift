#!/usr/bin/python

import sys
import os
import string
from translation_rules import *
from translation_helpers import *
from cef_parser import *


def make_handler_interop_file_header(swift_classname, cef_filename):
    return '''//
//  %s+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from %s.
//

import Foundation

''' % (swift_classname, cef_filename)


def make_marshaller(cef_capi_name, swift_name):
    return '''typealias %sMarshaller = CEFMarshaller<%s, %s>

extension %s {
    func toCEF() -> UnsafeMutablePointer<%s> {
        return %sMarshaller.pass(self)
    }
}

''' % (swift_name, swift_name, cef_capi_name, swift_name, cef_capi_name, swift_name)


def make_cefcallbackmarshalling_conformance(cef_capi_name, swift_name, cef_class):
    retval = "extension " + cef_capi_name + ": CEFCallbackMarshalling {\n"
    retval += "    mutating func marshalCallbacks() {\n"
    for func in cef_class.get_virtual_funcs():
        retval += "        %s = %s_%s\n" % (func.get_capi_name(), swift_name, func.get_capi_name())

    retval += "    }\n}\n"
    return retval


def make_handler_interop(cef_class):
    capi_name = cef_class.get_capi_name()
    swift_name = cef_capi_type_to_swift(capi_name)
    
    result = make_handler_interop_file_header(swift_name, os.path.basename(cef_class.get_file_name()))
    result += make_cefobject_conformance(capi_name)
    result += make_marshaller(capi_name, swift_name)
    result += make_cefcallbackmarshalling_conformance(capi_name, swift_name, cef_class)

    return result


if len(sys.argv) < 3:
    print "Usage: " + os.path.basename(sys.argv[0]) + " <cef_includes_dir> <dst_dir>"
    exit(-1)

includes_dir = sys.argv[1]
dst_dir = sys.argv[2]

header = obj_header()
excluded_files = ['cef_application_mac.h', 'cef_version.h']
header.add_directory(includes_dir, excluded_files)

for cef_class in header.get_classes():
    if not cef_class.is_library_side():
        outfile_contents = make_handler_interop(cef_class)
    
        if not os.access(dst_dir, os.F_OK):
            os.makedirs(dst_dir)
    
        swift_type_name = cef_capi_type_to_swift(cef_class.get_capi_name())
        outfile = open(os.path.join(dst_dir, swift_type_name + "+Interop.g.swift"), "w")
        outfile.write(outfile_contents)
        outfile.close()


