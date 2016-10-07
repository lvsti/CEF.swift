//
//  CEFURLRequestStatus.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_types.h.
//

import Foundation

/// Flags that represent CefURLRequest status.
/// CEF name: `cef_urlrequest_status_t`.
public enum CEFURLRequestStatus: Int32 {

    /// Unknown status.
    /// CEF name: `UR_UNKNOWN`.
    case unknown = 0

    /// Request succeeded.
    /// CEF name: `UR_SUCCESS`.
    case success

    /// An IO request is pending, and the caller will be informed when it is
    /// completed.
    /// CEF name: `UR_IO_PENDING`.
    case ioPending

    /// Request was canceled programatically.
    /// CEF name: `UR_CANCELED`.
    case canceled

    /// Request failed for some reason.
    /// CEF name: `UR_FAILED`.
    case failed
}

extension CEFURLRequestStatus {
    static func fromCEF(_ value: cef_urlrequest_status_t) -> CEFURLRequestStatus {
        return CEFURLRequestStatus(rawValue: Int32(value.rawValue))!
    }

    func toCEF() -> cef_urlrequest_status_t {
        return cef_urlrequest_status_t(rawValue: UInt32(rawValue))
    }
}

