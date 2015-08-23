//
//  CEFJSONWriterOptions.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_types.h.
//

import Foundation

/// Options that can be passed to CefWriteJSON.
public struct CEFJSONWriterOptions: OptionSetType {
    public let rawValue: UInt32
    public init(rawValue: UInt32) {
        self.rawValue = rawValue
    }


    /// Default behavior.
    public static let Default = CEFJSONWriterOptions(rawValue: 0)

    /// This option instructs the writer that if a Binary value is encountered,
    /// the value (and key if within a dictionary) will be omitted from the
    /// output, and success will be returned. Otherwise, if a binary value is
    /// encountered, failure will be returned.
    public static let OmitBinaryValues = CEFJSONWriterOptions(rawValue: 1 << 0)

    /// This option instructs the writer to write doubles that have no fractional
    /// part as a normal integer (i.e., without using exponential notation
    /// or appending a '.0') as long as the value is within the range of a
    /// 64-bit int.
    public static let OmitDoubleTypePreservation = CEFJSONWriterOptions(rawValue: 1 << 1)

    /// Return a slightly nicer formatted json string (pads with whitespace to
    /// help with readability).
    public static let PrettyPrint = CEFJSONWriterOptions(rawValue: 1 << 2)
}

extension CEFJSONWriterOptions {
    static func fromCEF(value: cef_json_writer_options_t) -> CEFJSONWriterOptions {
        return CEFJSONWriterOptions(rawValue: UInt32(value.rawValue))
    }

    func toCEF() -> cef_json_writer_options_t {
        return cef_json_writer_options_t(rawValue: UInt32(rawValue))
    }
}

