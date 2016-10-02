//
//  CEFJSONParserError.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_types.h.
//

import Foundation

/// Error codes that can be returned from CefParseJSONAndReturnError.
public enum CEFJSONParserError: Int32 {
    case noError = 0
    case invalidEscape
    case syntaxError
    case unexpectedToken
    case trailingComma
    case tooMuchNesting
    case unexpectedDataAfterRoot
    case unsupportedEncoding
    case unquotedDictionaryKey
    case parseErrorCount
}

extension CEFJSONParserError {
    static func fromCEF(_ value: cef_json_parser_error_t) -> CEFJSONParserError {
        return CEFJSONParserError(rawValue: Int32(value.rawValue))!
    }

    func toCEF() -> cef_json_parser_error_t {
        return cef_json_parser_error_t(rawValue: UInt32(rawValue))
    }
}

