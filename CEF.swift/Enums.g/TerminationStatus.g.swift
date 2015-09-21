//
//  TerminationStatus.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_types.h.
//

import Foundation

/// Process termination status values.
public enum TerminationStatus: Int32 {

    /// Non-zero exit status.
    case AbnormalTermination

    /// SIGKILL or task manager kill.
    case ProcessWasKilled

    /// Segmentation fault.
    case ProcessCrashed
}

extension TerminationStatus {
    static func fromCEF(value: cef_termination_status_t) -> TerminationStatus {
        return TerminationStatus(rawValue: Int32(value.rawValue))!
    }

    func toCEF() -> cef_termination_status_t {
        return cef_termination_status_t(rawValue: UInt32(rawValue))
    }
}

