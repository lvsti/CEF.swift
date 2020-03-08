//
//  CEFMediaRouteConnectionState.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_types.h.
//

import Foundation

/// Connection state for a MediaRoute object.
/// CEF name: `cef_media_route_connection_state_t`.
public enum CEFMediaRouteConnectionState: Int32 {
    /// CEF name: `CEF_MRCS_UNKNOWN`.
    case unknown
    /// CEF name: `CEF_MRCS_CONNECTING`.
    case connecting
    /// CEF name: `CEF_MRCS_CONNECTED`.
    case connected
    /// CEF name: `CEF_MRCS_CLOSED`.
    case closed
    /// CEF name: `CEF_MRCS_TERMINATED`.
    case terminated
}

extension CEFMediaRouteConnectionState {
    static func fromCEF(_ value: cef_media_route_connection_state_t) -> CEFMediaRouteConnectionState {
        return CEFMediaRouteConnectionState(rawValue: Int32(value.rawValue))!
    }

    func toCEF() -> cef_media_route_connection_state_t {
        return cef_media_route_connection_state_t(rawValue: UInt32(rawValue))
    }
}

