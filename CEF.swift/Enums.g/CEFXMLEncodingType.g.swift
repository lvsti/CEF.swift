//
//  CEFXMLEncodingType.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_types.h.
//

import Foundation

/// Supported XML encoding types. The parser supports ASCII, ISO-8859-1, and
/// UTF16 (LE and BE) by default. All other types must be translated to UTF8
/// before being passed to the parser. If a BOM is detected and the correct
/// decoder is available then that decoder will be used automatically.
/// CEF name: `cef_xml_encoding_type_t`.
public enum CEFXMLEncodingType: Int32 {
    /// CEF name: `XML_ENCODING_NONE`.
    case none = 0
    /// CEF name: `XML_ENCODING_UTF8`.
    case utf8
    /// CEF name: `XML_ENCODING_UTF16LE`.
    case utf16le
    /// CEF name: `XML_ENCODING_UTF16BE`.
    case utf16be
    /// CEF name: `XML_ENCODING_ASCII`.
    case ascii
}

extension CEFXMLEncodingType {
    static func fromCEF(_ value: cef_xml_encoding_type_t) -> CEFXMLEncodingType {
        return CEFXMLEncodingType(rawValue: Int32(value.rawValue))!
    }

    func toCEF() -> cef_xml_encoding_type_t {
        return cef_xml_encoding_type_t(rawValue: UInt32(rawValue))
    }
}

