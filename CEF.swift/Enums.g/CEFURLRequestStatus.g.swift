//
//  CEFURLRequestStatus.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_types.h.
//

import Foundation

///
// Flags that represent CefURLRequest status.
///
public enum CEFURLRequestStatus: Int32 {

    ///
    // Unknown status.
    ///
    case Unknown = 0

    ///
    // Request succeeded.
    ///
    case Success

    ///
    // An IO request is pending, and the caller will be informed when it is
    // completed.
    ///
    case IOPending

    ///
    // Request was canceled programatically.
    ///
    case Canceled

    ///
    // Request failed for some reason.
    ///
    case Failed
}

extension CEFURLRequestStatus {
    static func fromCEF(value: cef_urlrequest_status_t) -> CEFURLRequestStatus {
        return CEFURLRequestStatus(rawValue: Int32(value.rawValue))!
    }

    func toCEF() -> cef_urlrequest_status_t {
        return cef_urlrequest_status_t(rawValue: UInt32(rawValue))
    }
}

