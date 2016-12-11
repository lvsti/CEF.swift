//
//  CEFThreadPriority.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_types.h.
//

import Foundation

/// Thread priority values listed in increasing order of importance.
/// CEF name: `cef_thread_priority_t`.
public enum CEFThreadPriority: Int32 {

    /// Suitable for threads that shouldn't disrupt high priority work.
    /// CEF name: `TP_BACKGROUND`.
    case background

    /// Default priority level.
    /// CEF name: `TP_NORMAL`.
    case normal

    /// Suitable for threads which generate data for the display (at ~60Hz).
    /// CEF name: `TP_DISPLAY`.
    case display

    /// Suitable for low-latency, glitch-resistant audio.
    /// CEF name: `TP_REALTIME_AUDIO`.
    case realtimeAudio
}

extension CEFThreadPriority {
    static func fromCEF(_ value: cef_thread_priority_t) -> CEFThreadPriority {
        return CEFThreadPriority(rawValue: Int32(value.rawValue))!
    }

    func toCEF() -> cef_thread_priority_t {
        return cef_thread_priority_t(rawValue: UInt32(rawValue))
    }
}

