#!/usr/bin/python

import sys
import os
import re
import string
from translation_rules import *
from translation_helpers import *


def cef_capi_enum_entry_to_swift(capi_entry, prefix):
    if capi_entry in entryname_overrides:
        return entryname_overrides[capi_entry]
    
    retval = ""
    force_lower = True
    for word in capi_entry[len(prefix)+1:].split("_"):
        if force_lower:
            retval += word.lower()
            force_lower = False
        else:
            if word.lower() in abbreviations:
                retval += word.upper()
            else:
                retval += word.capitalize()
    
    if retval in swift_keywords:
        retval = '`' + retval + '`'

    return retval

def cef_capi_enum_value_to_swift(capi_value):
    if capi_value in entryvalue_overrides:
        return entryvalue_overrides[capi_value]
    
    return capi_value

def common_prefix(m):
    if not m: return ''
    s1 = min(m)
    s2 = max(m)
    for i, c in enumerate(s1):
        if c != s2[i]:
            return s1[:i]
    return s1    


enum_type_pattern = re.compile("\/\/\/\s*\n((?:\s*\/\/(?!\/)[^\n]*\n)+)\s*\/\/\/\s*\s*typedef\s+enum\s*{\s*([^}]*?)\s*}\s*([^;]+);", re.S)
enum_value_pattern = re.compile("(?:\/\/\/\s*\n((?:\s*\/\/(?!\/)[^\n]*\n)+)\s*\/\/\/\s*)?(?:^|\n)\s*(\w+)\s*(?:=\s*([^,\/]+)\s*)?,?\s*((?:\s*\/\/(?!\/)[^\n]*)*)(?=(?:\n|$))", re.S)

def make_enum(cef_capi_name, cef_body):
    result = ""

    swift_type_name = cef_capi_type_to_swift(cef_capi_name)
    result += "public enum " + swift_type_name + ": Int32 {\n"

    head_comments = []
    names = []
    values = []
    inline_comments = []
    for value_match in re.finditer(enum_value_pattern, type_body):
        head_comments.append(value_match.group(1))
        names.append(value_match.group(2))
        values.append(value_match.group(3))
        inline_comments.append(value_match.group(4))

    prefix = string.join(common_prefix(names).split("_")[:-1], "_")
    for i in range(0, len(names)):
        if head_comments[i] != None:
            result += "\n" + indent_multiline_string(make_swiftdoc_comment(strip_c_comment_prefix(head_comments[i])), 1)
        elif inline_comments[i] != None and len(inline_comments[i].strip()) > 0:
            result += "\n" + indent_multiline_string("///\n" + inline_comments[i] + "\n///", 1) + "\n"
        
        result += "    /// CEF name: `" + names[i] + "`.\n"
            
        swift_name = cef_capi_enum_entry_to_swift(names[i], prefix)
        result += "    case " + swift_name
        if values[i] != None:
            result += " = " + values[i].strip()
            
        result += "\n"

    result += "}\n\n"
    
    cast = "UInt32"
    if cef_capi_name in entrytype_tocef_cast_overrides:
        cast = entrytype_tocef_cast_overrides[cef_capi_name]
    
    result += "extension " + swift_type_name + " {\n"
    result += "    static func fromCEF(_ value: " + cef_capi_name + ") -> " + swift_type_name + " {\n"
    result += "        return " + swift_type_name + "(rawValue: Int32(value.rawValue))!\n"
    result += "    }\n\n"
    result += "    func toCEF() -> " + cef_capi_name + " {\n"
    result += "        return " + cef_capi_name + "(rawValue: " + cast + "(rawValue))\n"
    result += "    }\n"
    result += "}\n\n"

    return result


def make_option_set(cef_capi_name, cef_body):
    result = ""

    swift_type_name = cef_capi_type_to_swift(cef_capi_name)

    result += "public struct " + swift_type_name + ": OptionSet {\n"
    result += "    public let rawValue: UInt32\n"
    result += "    public init(rawValue: UInt32) {\n"
    result += "        self.rawValue = rawValue\n"
    result += "    }\n\n"

    head_comments = []
    names = []
    values = []
    inline_comments = []
    for value_match in re.finditer(enum_value_pattern, type_body):
        head_comments.append(value_match.group(1))
        names.append(value_match.group(2))
        values.append(value_match.group(3))
        inline_comments.append(value_match.group(4))

    prefix = string.join(common_prefix(names).split("_")[:-1], "_")
    for i in range(0, len(names)):
        if head_comments[i] != None:
            result += "\n" + indent_multiline_string(make_swiftdoc_comment(strip_c_comment_prefix(head_comments[i])), 1)
        elif inline_comments[i] != None and len(inline_comments[i].strip()) > 0:
            result += "\n" + indent_multiline_string("///\n" + inline_comments[i] + "\n///", 1) + "\n"

        result += "    /// CEF name: `" + names[i] + "`.\n"
            
        swift_entry_name = cef_capi_enum_entry_to_swift(names[i], prefix)
        swift_value = cef_capi_enum_value_to_swift(values[i].strip())
        result += "    public static let " + swift_entry_name + " = " + swift_type_name + "(rawValue: " + swift_value + ")\n"

    result += "}\n\n"

    result += "extension " + swift_type_name + " {\n"
    result += "    static func fromCEF(_ value: " + cef_capi_name + ") -> " + swift_type_name + " {\n"
    result += "        return " + swift_type_name + "(rawValue: UInt32(value.rawValue))\n"
    result += "    }\n\n"
    result += "    func toCEF() -> " + cef_capi_name + " {\n"
    result += "        return " + cef_capi_name + "(rawValue: UInt32(rawValue))\n"
    result += "    }\n"
    result += "}\n\n"

    return result


def make_const_collection(cef_capi_name, cef_header_name):
    result = ""

    swift_type_name = cef_capi_type_to_swift(cef_capi_name)
    swift_raw_type = cef_const_collections[cef_capi_name]

    result += "public struct " + swift_type_name + ": RawRepresentable {\n"
    result += "    public let rawValue: " + swift_raw_type + "\n"
    result += "    public init(rawValue: " + swift_raw_type + ") {\n"
    result += "        self.rawValue = rawValue\n"
    result += "    }\n\n"

    head_comments = []
    names = []
    values = []
    inline_comments = []
    for value_match in re.finditer(enum_value_pattern, type_body):
        head_comments.append(value_match.group(1))
        names.append(value_match.group(2))
        values.append(value_match.group(3))
        inline_comments.append(value_match.group(4))

    prefix = string.join(common_prefix(names).split("_")[:-1], "_")
    for i in range(0, len(names)):
        if head_comments[i] != None:
            result += "\n" + indent_multiline_string(make_swiftdoc_comment(strip_c_comment_prefix(head_comments[i])), 1)
        elif inline_comments[i] != None and len(inline_comments[i].strip()) > 0:
            result += "\n" + indent_multiline_string("///\n" + inline_comments[i] + "\n///", 1) + "\n"
            
        result += "    /// CEF name: `" + names[i] + "`.\n"

        swift_entry_name = cef_capi_enum_entry_to_swift(names[i], prefix)
        swift_value = cef_capi_enum_value_to_swift(values[i].strip())
        result += "    public static let " + swift_entry_name + " = " + swift_type_name + "(rawValue: " + swift_value + ")\n"

    result += "}\n\n"

    result += "extension " + swift_type_name + " {\n"
    result += "    static func fromCEF(_ value: " + swift_raw_type + ") -> " + swift_type_name + " {\n"
    result += "        return " + swift_type_name + "(rawValue: value)\n"
    result += "    }\n\n"
    result += "    func toCEF() -> " + swift_raw_type + " {\n"
    result += "        return rawValue\n"
    result += "    }\n"
    result += "}\n\n"

    return result
    


def make_enum_header(swift_type_name, cef_header_name):
    header = '''//
//  %s.g.swift
//  CEF.swift
//
//  This file was generated automatically from %s.
//

import Foundation

'''
    return header % (swift_type_name, cef_header_name)


if len(sys.argv) < 3:
    print "Usage: " + os.path.basename(sys.argv[0]) + " <cef_header> <dst_dir>"
    exit(-1)
    

infile_path = sys.argv[1]
dst_dir = sys.argv[2]

infile = open(infile_path, "r")
infile_contents = infile.read()
infile.close()


for type_match in re.finditer(enum_type_pattern, infile_contents):
    type_comment = type_match.group(1)
    type_body = type_match.group(2)
    type_name = type_match.group(3)
    
    result = ""
    result += indent_multiline_string(make_swiftdoc_comment(strip_c_comment_prefix(type_comment)), 0)
    result += "/// CEF name: `" + type_name + "`.\n"
    
    if type_name in cef_enums:
        result += make_enum(type_name, type_body)
    elif type_name in cef_option_sets:
        result += make_option_set(type_name, type_body)
    elif type_name in cef_const_collections:
        result += make_const_collection(type_name, type_body)
    else:
        if type_name in cef_hybrid_enums:
            print "skipping hybrid type '" + type_name + "'"
        else:
            print "skipping unknown type '" + type_name + "'"
        continue

    swift_type_name = cef_capi_type_to_swift(type_name)
    
    outfile_contents = make_enum_header(swift_type_name, os.path.basename(infile_path))
    outfile_contents += result
    
    if not os.access(dst_dir, os.F_OK):
        os.makedirs(dst_dir)
    
    outfile = open(os.path.join(dst_dir, swift_type_name + ".g.swift"), "w")
    outfile.write(outfile_contents)
    outfile.close()


# print find_enums(file_contents)
