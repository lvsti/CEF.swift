//
//  GeopositionErrorCode.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_types.h.
//

import Foundation

/// Geoposition error codes.
public enum GeopositionErrorCode: Int32 {
    case None = 0
    case PermissionDenied
    case PositionUnavailable
    case Timeout
}

extension GeopositionErrorCode {
    static func fromCEF(value: cef_geoposition_error_code_t) -> GeopositionErrorCode {
        return GeopositionErrorCode(rawValue: Int32(value.rawValue))!
    }

    func toCEF() -> cef_geoposition_error_code_t {
        return cef_geoposition_error_code_t(rawValue: UInt32(rawValue))
    }
}

