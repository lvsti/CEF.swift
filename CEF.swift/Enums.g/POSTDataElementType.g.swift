//
//  POSTDataElementType.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_types.h.
//

import Foundation

/// Post data elements may represent either bytes or files.
public enum POSTDataElementType: Int32 {
    case Empty = 0
    case Bytes
    case File
}

extension POSTDataElementType {
    static func fromCEF(value: cef_postdataelement_type_t) -> POSTDataElementType {
        return POSTDataElementType(rawValue: Int32(value.rawValue))!
    }

    func toCEF() -> cef_postdataelement_type_t {
        return cef_postdataelement_type_t(rawValue: UInt32(rawValue))
    }
}

