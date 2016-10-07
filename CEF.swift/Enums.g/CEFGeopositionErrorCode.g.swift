//
//  CEFGeopositionErrorCode.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_types.h.
//

import Foundation

/// Geoposition error codes.
/// CEF name: `cef_geoposition_error_code_t`.
public enum CEFGeopositionErrorCode: Int32 {
    /// CEF name: `GEOPOSITON_ERROR_NONE`.
    case none = 0
    /// CEF name: `GEOPOSITON_ERROR_PERMISSION_DENIED`.
    case permissionDenied
    /// CEF name: `GEOPOSITON_ERROR_POSITION_UNAVAILABLE`.
    case positionUnavailable
    /// CEF name: `GEOPOSITON_ERROR_TIMEOUT`.
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

