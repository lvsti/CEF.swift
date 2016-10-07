//
//  CEFDOMEventPhase.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_types.h.
//

import Foundation

/// DOM event processing phases.
/// CEF name: `cef_dom_event_phase_t`.
public enum CEFDOMEventPhase: Int32 {
    /// CEF name: `DOM_EVENT_PHASE_UNKNOWN`.
    case unknown = 0
    /// CEF name: `DOM_EVENT_PHASE_CAPTURING`.
    case capturing
    /// CEF name: `DOM_EVENT_PHASE_AT_TARGET`.
    case atTarget
    /// CEF name: `DOM_EVENT_PHASE_BUBBLING`.
    case bubbling
}

extension CEFDOMEventPhase {
    static func fromCEF(_ value: cef_dom_event_phase_t) -> CEFDOMEventPhase {
        return CEFDOMEventPhase(rawValue: Int32(value.rawValue))!
    }

    func toCEF() -> cef_dom_event_phase_t {
        return cef_dom_event_phase_t(rawValue: UInt32(rawValue))
    }
}

