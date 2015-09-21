//
//  StorageType.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_types.h.
//

import Foundation

/// Storage types.
public enum StorageType: Int32 {
    case LocalStorage = 0
    case SessionStorage
}

extension StorageType {
    static func fromCEF(value: cef_storage_type_t) -> StorageType {
        return StorageType(rawValue: Int32(value.rawValue))!
    }

    func toCEF() -> cef_storage_type_t {
        return cef_storage_type_t(rawValue: UInt32(rawValue))
    }
}

