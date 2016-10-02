//
//  CEFJSONParserOptions.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_types.h.
//

import Foundation

/// Options that can be passed to CefParseJSON.
public struct CEFJSONParserOptions: OptionSet {
    public let rawValue: UInt32
    public init(rawValue: UInt32) {
        self.rawValue = rawValue
    }


    /// Parses the input strictly according to RFC 4627. See comments in Chromium's
    /// base/json/json_reader.h file for known limitations/deviations from the RFC.
    public static let rfc = CEFJSONParserOptions(rawValue: 0)

    /// Allows commas to exist after the last element in structures.
    public static let allowTrailingCommas = CEFJSONParserOptions(rawValue: 1 << 0)
}

extension CEFJSONParserOptions {
    static func fromCEF(value: cef_json_parser_options_t) -> CEFJSONParserOptions {
        return CEFJSONParserOptions(rawValue: UInt32(value.rawValue))
    }

    func toCEF() -> cef_json_parser_options_t {
        return cef_json_parser_options_t(rawValue: UInt32(rawValue))
    }
}

