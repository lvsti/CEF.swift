//
//  CEFTerminationStatus.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_types.h.
//

import Foundation

/// Process termination status values.
/// CEF name: `cef_termination_status_t`.
public enum CEFTerminationStatus: Int32 {

    /// Non-zero exit status.
    /// CEF name: `TS_ABNORMAL_TERMINATION`.
    case abnormalTermination

    /// SIGKILL or task manager kill.
    /// CEF name: `TS_PROCESS_WAS_KILLED`.
    case processWasKilled

    /// Segmentation fault.
    /// CEF name: `TS_PROCESS_CRASHED`.
    case processCrashed
}

extension CEFTerminationStatus {
    static func fromCEF(_ value: cef_termination_status_t) -> CEFTerminationStatus {
        return CEFTerminationStatus(rawValue: Int32(value.rawValue))!
    }

    func toCEF() -> cef_termination_status_t {
        return cef_termination_status_t(rawValue: UInt32(rawValue))
    }
}

