//
//  CEFDuplexMode.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_types.h.
//

import Foundation

/// Print job duplex mode values.
public enum CEFDuplexMode: Int32 {
    case unknown = -1
    case simplex
    case longEdge
    case shortEdge
}

extension CEFDuplexMode {
    static func fromCEF(value: cef_duplex_mode_t) -> CEFDuplexMode {
        return CEFDuplexMode(rawValue: Int32(value.rawValue))!
    }

    func toCEF() -> cef_duplex_mode_t {
        return cef_duplex_mode_t(rawValue: Int32(rawValue))
    }
}

