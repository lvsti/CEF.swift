//
//  CEFJSONParserError.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_types.h.
//

import Foundation

/// Error codes that can be returned from CefParseJSONAndReturnError.
/// CEF name: `cef_json_parser_error_t`.
public enum CEFJSONParserError: Int32 {
    /// CEF name: `JSON_NO_ERROR`.
    case noError = 0
    /// CEF name: `JSON_INVALID_ESCAPE`.
    case invalidEscape
    /// CEF name: `JSON_SYNTAX_ERROR`.
    case syntaxError
    /// CEF name: `JSON_UNEXPECTED_TOKEN`.
    case unexpectedToken
    /// CEF name: `JSON_TRAILING_COMMA`.
    case trailingComma
    /// CEF name: `JSON_TOO_MUCH_NESTING`.
    case tooMuchNesting
    /// CEF name: `JSON_UNEXPECTED_DATA_AFTER_ROOT`.
    case unexpectedDataAfterRoot
    /// CEF name: `JSON_UNSUPPORTED_ENCODING`.
    case unsupportedEncoding
    /// CEF name: `JSON_UNQUOTED_DICTIONARY_KEY`.
    case unquotedDictionaryKey
    /// CEF name: `JSON_PARSE_ERROR_COUNT`.
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

