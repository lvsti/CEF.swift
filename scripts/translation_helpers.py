#!/usr/bin/python

from translation_rules import *

def cef_capi_func_name_to_swift_func_name(capi_func_name):
    parts = capi_func_name.split("_")
    retval = parts[0].lower()

    for word in parts[1:]:
        if word.lower() in abbreviations:
            retval += word.upper()
        else:
            retval += word.capitalize()
    
    return retval


def cef_capi_type_to_swift(capi_type):
    if capi_type in typename_overrides:
        return typename_overrides[capi_type]
    
    retval = "CEF"
    for word in capi_type.split("_")[1:-1]:
        if word.lower() in abbreviations:
            retval += word.upper()
        else:
            retval += word.capitalize()
    
    return retval


def indent_multiline_string(mls, level):
    retval = ""
    for line in mls.splitlines(True):
        retval += "\t".expandtabs(4*level) + line.lstrip()
    return retval


def strip_c_comment_prefix(mls):
    retval = ""
    for line in mls.splitlines(True):
        stripped = line.lstrip()
        if len(stripped) >= 2 and stripped[:2] == "//":
            retval += stripped[2:].lstrip()
            
    return retval


def make_swiftdoc_comment(desc, params = None, returns = None):
    retval = ""
    if desc != None:
        retval += indent_multiline_string(desc, 0)
    
    if params != None:
        if desc != None:
            retval += "\n\n"
        for param_name in params:
            retval += ":param: " + param_name + " " + params[param_name].lstrip() + "\n"
        retval = retval.rstrip()
    
    if returns != None:
        if params != None or desc != None:
            retval += "\n\n"
        retval += ":returns: " + returns.lstrip() + "\n"
    
    swiftdoc = ""
    for line in retval.splitlines(True):
        swiftdoc += "/// " + line

    return swiftdoc


def make_cefobject_conformance(cef_capi_name):
    return "extension " + cef_capi_name + ": CEFObject {}\n\n"


def make_cefscopedobject_conformance(cef_capi_name):
    return "extension " + cef_capi_name + ": CEFScopedObject {}\n\n"
