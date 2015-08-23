//
//  CEFStorageType.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_types.h.
//

import Foundation

/// Storage types.
public enum CEFStorageType: Int32 {
    case LocalStorage = 0
    case SessionStorage
}

extension CEFStorageType {
    static func fromCEF(value: cef_storage_type_t) -> CEFStorageType {
        return CEFStorageType(rawValue: Int32(value.rawValue))!
    }

    func toCEF() -> cef_storage_type_t {
        return cef_storage_type_t(rawValue: UInt32(rawValue))
    }
}

