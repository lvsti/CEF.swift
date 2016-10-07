//
//  CEFResponseFilterStatus.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_types.h.
//

import Foundation

/// Return values for CefResponseFilter::Filter().
/// CEF name: `cef_response_filter_status_t`.
public enum CEFResponseFilterStatus: Int32 {

    /// Some or all of the pre-filter data was read successfully but more data is
    /// needed in order to continue filtering (filtered output is pending).
    /// CEF name: `RESPONSE_FILTER_NEED_MORE_DATA`.
    case needMoreData

    /// Some or all of the pre-filter data was read successfully and all available
    /// filtered output has been written.
    /// CEF name: `RESPONSE_FILTER_DONE`.
    case done

    /// An error occurred during filtering.
    /// CEF name: `RESPONSE_FILTER_ERROR`.
    case error
}

extension CEFResponseFilterStatus {
    static func fromCEF(_ value: cef_response_filter_status_t) -> CEFResponseFilterStatus {
        return CEFResponseFilterStatus(rawValue: Int32(value.rawValue))!
    }

    func toCEF() -> cef_response_filter_status_t {
        return cef_response_filter_status_t(rawValue: UInt32(rawValue))
    }
}

