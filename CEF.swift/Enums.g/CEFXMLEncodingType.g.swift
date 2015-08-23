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
public enum CEFXMLEncodingType: Int32 {
    case None = 0
    case UTF8
    case UTF16LE
    case UTF16BE
    case ASCII
}

extension CEFXMLEncodingType {
    static func fromCEF(value: cef_xml_encoding_type_t) -> CEFXMLEncodingType {
        return CEFXMLEncodingType(rawValue: Int32(value.rawValue))!
    }

    func toCEF() -> cef_xml_encoding_type_t {
        return cef_xml_encoding_type_t(rawValue: UInt32(rawValue))
    }
}

