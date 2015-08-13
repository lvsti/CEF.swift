//
//  CEFParserGlobals.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 13..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation


///
// Returns the mime type for the specified file extension or an empty string if
// unknown.
///
public func CEFGetMIMEType(fileExt: String) -> String {
    let cefStrPtr = CEFStringPtrCreateFromSwiftString(fileExt)
    defer { CEFStringPtrRelease(cefStrPtr) }
    let cefType = cef_get_mime_type(cefStrPtr)
    defer { CEFStringPtrRelease(cefType) }
    return CEFStringToSwiftString(cefType.memory)
}

// Get the extensions associated with the given mime type. This should be passed
// in lower case. There could be multiple extensions for a given mime type, like
// "html,htm" for "text/html", or "txt,text,html,..." for "text/*". Any existing
// elements in the provided vector will not be erased.
public func CEFGetExtensionsForMIMEType(mimeType: String) -> [String] {
    let cefList = cef_string_list_alloc()
    let cefStrPtr = CEFStringPtrCreateFromSwiftString(mimeType)
    defer {
        CEFStringListRelease(cefList)
        CEFStringPtrRelease(cefStrPtr)
    }
    cef_get_extensions_for_mime_type(cefStrPtr, cefList)
    return CEFStringListToSwiftArray(cefList)
}

///
// Escapes characters in |text| which are unsuitable for use as a query
// parameter value. Everything except alphanumerics and -_.!~*'() will be
// converted to "%XX". If |use_plus| is true spaces will change to "+". The
// result is basically the same as encodeURIComponent in Javacript.
///
public func CEFURIEncode(text: String, usePlus: Bool) -> String {
    let cefStrPtr = CEFStringPtrCreateFromSwiftString(text)
    let cefEncodedPtr = cef_uriencode(cefStrPtr, usePlus ? 1 : 0)
    defer {
        CEFStringPtrRelease(cefStrPtr)
        CEFStringPtrRelease(cefEncodedPtr)
    }
    return CEFStringToSwiftString(cefEncodedPtr.memory)
}

///
// Unescapes |text| and returns the result. Unescaping consists of looking for
// the exact pattern "%XX" where each X is a hex digit and converting to the
// character with the numerical value of those digits (e.g. "i%20=%203%3b"
// unescapes to "i = 3;"). If |convert_to_utf8| is true this function will
// attempt to interpret the initial decoded result as UTF-8. If the result is
// convertable into UTF-8 it will be returned as converted. Otherwise the
// initial decoded result will be returned.  The |unescape_rule| parameter
// supports further customization the decoding process.
///
public func CEFURIDecode(text: String, convertToUTF8: Bool, unescapeRule: CEFURIUnescapeRule) -> String {
    let cefStrPtr = CEFStringPtrCreateFromSwiftString(text)
    let cefDecodedPtr = cef_uridecode(cefStrPtr, convertToUTF8 ? 1 : 0, unescapeRule.toCEF())
    defer {
        CEFStringPtrRelease(cefStrPtr)
        CEFStringPtrRelease(cefDecodedPtr)
    }
    return CEFStringToSwiftString(cefDecodedPtr.memory)
}

///
// Parses |string| which represents a CSS color value. If |strict| is true
// strict parsing rules will be applied. Returns true on success or false on
// error. If parsing succeeds |color| will be set to the color value otherwise
// |color| will remain unchanged.
///
public func CEFParseCSSColor(string: String, isStrict: Bool) -> CEFColor? {
    let cefStrPtr = CEFStringPtrCreateFromSwiftString(string)
    defer { CEFStringPtrRelease(cefStrPtr) }
    var cefColor: cef_color_t = 0
    
    if cef_parse_csscolor(cefStrPtr, isStrict ? 1 : 0, &cefColor) != 0 {
        return CEFColor.fromCEF(cefColor)
    }
    return nil
}

// Parses the specified |json_string| and returns a dictionary or list
// representation. If JSON parsing fails this method returns NULL.
public func CEFParseJSON(jsonString: String, options: CEFJSONParserOptions) -> CEFValue? {
    let cefStrPtr = CEFStringPtrCreateFromSwiftString(jsonString)
    defer { CEFStringPtrRelease(cefStrPtr) }
    let cefValue = cef_parse_json(cefStrPtr, options.toCEF())
    return CEFValue.fromCEF(cefValue)
}

// Parses the specified |json_string| and returns a dictionary or list
// representation. If JSON parsing fails this method returns NULL and populates
// |error_code_out| and |error_msg_out| with an error code and a formatted error
// message respectively.
public func CEFParseJSONAndReturnError(jsonString: String,
                                       options: CEFJSONParserOptions,
                                       inout errorCode: CEFJSONParserError?,
inout errorMsg: String?) -> CEFValue? {
    let cefStrPtr = CEFStringPtrCreateFromSwiftString(jsonString)
    defer { CEFStringPtrRelease(cefStrPtr) }
    var code = CEFJSONParserError.NoError.toCEF()
    var msg = cef_string_t()
    
    let cefValue = cef_parse_jsonand_return_error(cefStrPtr, options.toCEF(), &code, &msg)
    if cefValue != nil {
        errorCode = CEFJSONParserError.fromCEF(code)
        errorMsg = CEFStringToSwiftString(msg)
    }
    
    return CEFValue.fromCEF(cefValue)
}

// Generates a JSON string from the specified root |node| which should be a
// dictionary or list value. Returns an empty string on failure. This method
// requires exclusive access to |node| including any underlying data.
public func CEFWriteJSON(value: CEFValue, options: CEFJSONWriterOptions) -> String? {
    let cefStrPtr = cef_write_json(value.toCEF(), options.toCEF())
    defer { CEFStringPtrRelease(cefStrPtr) }
    
    return cefStrPtr != nil ? CEFStringToSwiftString(cefStrPtr.memory) : nil
}


