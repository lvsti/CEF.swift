//
//  CEFPOSTDataElementType.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_types.h.
//

import Foundation

/// Post data elements may represent either bytes or files.
public enum CEFPOSTDataElementType: Int32 {
    case empty = 0
    case bytes
    case file
}

extension CEFPOSTDataElementType {
    static func fromCEF(_ value: cef_postdataelement_type_t) -> CEFPOSTDataElementType {
        return CEFPOSTDataElementType(rawValue: Int32(value.rawValue))!
    }

    func toCEF() -> cef_postdataelement_type_t {
        return cef_postdataelement_type_t(rawValue: UInt32(rawValue))
    }
}

