//
//  CEFDOMEventPhase.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_types.h.
//

import Foundation

/// DOM event processing phases.
public enum CEFDOMEventPhase: Int32 {
    case unknown = 0
    case capturing
    case atTarget
    case bubbling
}

extension CEFDOMEventPhase {
    static func fromCEF(value: cef_dom_event_phase_t) -> CEFDOMEventPhase {
        return CEFDOMEventPhase(rawValue: Int32(value.rawValue))!
    }

    func toCEF() -> cef_dom_event_phase_t {
        return cef_dom_event_phase_t(rawValue: UInt32(rawValue))
    }
}

