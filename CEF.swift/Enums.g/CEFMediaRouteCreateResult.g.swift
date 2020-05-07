//
//  CEFMediaRouteCreateResult.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_types.h.
//

import Foundation

/// Result codes for CefMediaRouter::CreateRoute. Should be kept in sync with
/// Chromium's media_router::RouteRequestResult::ResultCode type.
/// CEF name: `cef_media_route_create_result_t`.
public enum CEFMediaRouteCreateResult: Int32 {
    /// CEF name: `CEF_MRCR_UNKNOWN_ERROR`.
    case unknownError = 0
    /// CEF name: `CEF_MRCR_OK`.
    case ok = 1
    /// CEF name: `CEF_MRCR_TIMED_OUT`.
    case timedOut = 2
    /// CEF name: `CEF_MRCR_ROUTE_NOT_FOUND`.
    case routeNotFound = 3
    /// CEF name: `CEF_MRCR_SINK_NOT_FOUND`.
    case sinkNotFound = 4
    /// CEF name: `CEF_MRCR_INVALID_ORIGIN`.
    case invalidOrigin = 5
    /// CEF name: `CEF_MRCR_NO_SUPPORTED_PROVIDER`.
    case noSupportedProvider = 7
    /// CEF name: `CEF_MRCR_CANCELLED`.
    case cancelled = 8
    /// CEF name: `CEF_MRCR_ROUTE_ALREADY_EXISTS`.
    case routeAlreadyExists = 9

    ///
    // The total number of values.
    ///
    /// CEF name: `CEF_MRCR_TOTAL_COUNT`.
    case totalCount = 11
}

extension CEFMediaRouteCreateResult {
    static func fromCEF(_ value: cef_media_route_create_result_t) -> CEFMediaRouteCreateResult {
        return CEFMediaRouteCreateResult(rawValue: Int32(value.rawValue))!
    }

    func toCEF() -> cef_media_route_create_result_t {
        return cef_media_route_create_result_t(rawValue: UInt32(rawValue))
    }
}

