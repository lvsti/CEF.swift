//
//  CEFDOMEventCategory.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_types.h.
//

import Foundation

/// DOM event category flags.
public struct CEFDOMEventCategory: OptionSet {
    public let rawValue: UInt32
    public init(rawValue: UInt32) {
        self.rawValue = rawValue
    }

    public static let unknown = CEFDOMEventCategory(rawValue: 0x0)
    public static let ui = CEFDOMEventCategory(rawValue: 0x1)
    public static let mouse = CEFDOMEventCategory(rawValue: 0x2)
    public static let mutation = CEFDOMEventCategory(rawValue: 0x4)
    public static let keyboard = CEFDOMEventCategory(rawValue: 0x8)
    public static let text = CEFDOMEventCategory(rawValue: 0x10)
    public static let composition = CEFDOMEventCategory(rawValue: 0x20)
    public static let drag = CEFDOMEventCategory(rawValue: 0x40)
    public static let clipboard = CEFDOMEventCategory(rawValue: 0x80)
    public static let message = CEFDOMEventCategory(rawValue: 0x100)
    public static let wheel = CEFDOMEventCategory(rawValue: 0x200)
    public static let beforeTextInserted = CEFDOMEventCategory(rawValue: 0x400)
    public static let overflow = CEFDOMEventCategory(rawValue: 0x800)
    public static let pageTransition = CEFDOMEventCategory(rawValue: 0x1000)
    public static let popstate = CEFDOMEventCategory(rawValue: 0x2000)
    public static let progress = CEFDOMEventCategory(rawValue: 0x4000)
    public static let xmlHTTPRequestProgress = CEFDOMEventCategory(rawValue: 0x8000)
}

extension CEFDOMEventCategory {
    static func fromCEF(_ value: cef_dom_event_category_t) -> CEFDOMEventCategory {
        return CEFDOMEventCategory(rawValue: UInt32(value.rawValue))
    }

    func toCEF() -> cef_dom_event_category_t {
        return cef_dom_event_category_t(rawValue: UInt32(rawValue))
    }
}

