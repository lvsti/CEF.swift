#!/usr/bin/python

import sys
import os
import string
from translation_rules import *
from translation_helpers import *
from cef_parser import *

def make_proxy_interop_file_header(swift_classname, cef_filename):
    return '''//
//  %s+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from %s.
//

import Foundation

''' % (swift_classname, cef_filename)


def make_proxy_stub(capi_name, swift_name, is_scoped):
    # class declaration
    baseclass_name = 'CEFScopedProxy' if is_scoped else 'CEFProxy'

    return '''
public final class %s: %s<%s> {
    override init?(ptr: UnsafeMutablePointer<%s>?) {
        super.init(ptr: ptr)
    }
    
    static func fromCEF(_ ptr: UnsafeMutablePointer<%s>?) -> %s? {
        return %s(ptr: ptr)
    }
}

''' % (swift_name, baseclass_name, capi_name, capi_name, capi_name, swift_name, swift_name)


def make_proxy_interop(cef_class):
    capi_name = cef_class.get_capi_name()
    swift_name = cef_capi_type_to_swift(capi_name)
    comments = cef_class.get_comment()
    is_scoped = cef_class.get_parent_name() == 'CefBaseScoped'
    
    result = make_proxy_interop_file_header(swift_name, os.path.basename(cef_class.get_file_name()))

    if is_scoped:
        result += make_cefscopedobject_conformance(capi_name)
    else:
        result += make_cefobject_conformance(capi_name)

    result += make_swiftdoc_comment("\n".join(comments[1:-1]))
    result += "\n/// CEF name: `" + cef_class.get_name() + "`"
    result += make_proxy_stub(capi_name, swift_name, is_scoped)

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
    if cef_class.is_library_side():
        outfile_contents = make_proxy_interop(cef_class)
        
        if not os.access(dst_dir, os.F_OK):
            os.makedirs(dst_dir)
    
        swift_type_name = cef_capi_type_to_swift(cef_class.get_capi_name())
        outfile = open(os.path.join(dst_dir, swift_type_name + "+Interop.g.swift"), "w")
        outfile.write(outfile_contents)
        outfile.close()
