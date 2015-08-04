#!/usr/bin/python

from translation_rules import *

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

