//
//  DOMEventPhase.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_types.h.
//

import Foundation

/// DOM event processing phases.
public enum DOMEventPhase: Int32 {
    case Unknown = 0
    case Capturing
    case AtTarget
    case Bubbling
}

extension DOMEventPhase {
    static func fromCEF(value: cef_dom_event_phase_t) -> DOMEventPhase {
        return DOMEventPhase(rawValue: Int32(value.rawValue))!
    }

    func toCEF() -> cef_dom_event_phase_t {
        return cef_dom_event_phase_t(rawValue: UInt32(rawValue))
    }
}

