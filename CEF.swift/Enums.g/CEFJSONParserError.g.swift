//
//  CEFJSONParserError.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_types.h.
//

import Foundation

/// Error codes that can be returned from CefParseJSONAndReturnError.
public enum CEFJSONParserError: Int32 {
    case NoError = 0
    case InvalidEscape
    case SyntaxError
    case UnexpectedToken
    case TrailingComma
    case TooMuchNesting
    case UnexpectedDataAfterRoot
    case UnsupportedEncoding
    case UnquotedDictionaryKey
    case ParseErrorCount
}

extension CEFJSONParserError {
    static func fromCEF(value: cef_json_parser_error_t) -> CEFJSONParserError {
        return CEFJSONParserError(rawValue: Int32(value.rawValue))!
    }

    func toCEF() -> cef_json_parser_error_t {
        return cef_json_parser_error_t(rawValue: UInt32(rawValue))
    }
}

