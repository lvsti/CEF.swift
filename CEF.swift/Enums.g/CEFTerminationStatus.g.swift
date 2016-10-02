//
//  CEFTerminationStatus.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_types.h.
//

import Foundation

/// Process termination status values.
public enum CEFTerminationStatus: Int32 {

    /// Non-zero exit status.
    case abnormalTermination

    /// SIGKILL or task manager kill.
    case processWasKilled

    /// Segmentation fault.
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

