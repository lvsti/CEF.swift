//
//  CEFGeopositionErrorCode.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_types.h.
//

import Foundation

/// Geoposition error codes.
public enum CEFGeopositionErrorCode: Int32 {
    case none = 0
    case permissionDenied
    case positionUnavailable
    case timeout
}

extension CEFGeopositionErrorCode {
    static func fromCEF(_ value: cef_geoposition_error_code_t) -> CEFGeopositionErrorCode {
        return CEFGeopositionErrorCode(rawValue: Int32(value.rawValue))!
    }

    func toCEF() -> cef_geoposition_error_code_t {
        return cef_geoposition_error_code_t(rawValue: UInt32(rawValue))
    }
}

