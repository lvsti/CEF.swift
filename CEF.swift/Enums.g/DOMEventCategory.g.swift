//
//  DOMEventCategory.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_types.h.
//

import Foundation

/// DOM event category flags.
public struct DOMEventCategory: OptionSetType {
    public let rawValue: UInt32
    public init(rawValue: UInt32) {
        self.rawValue = rawValue
    }

    public static let Unknown = DOMEventCategory(rawValue: 0x0)
    public static let UI = DOMEventCategory(rawValue: 0x1)
    public static let Mouse = DOMEventCategory(rawValue: 0x2)
    public static let Mutation = DOMEventCategory(rawValue: 0x4)
    public static let Keyboard = DOMEventCategory(rawValue: 0x8)
    public static let Text = DOMEventCategory(rawValue: 0x10)
    public static let Composition = DOMEventCategory(rawValue: 0x20)
    public static let Drag = DOMEventCategory(rawValue: 0x40)
    public static let Clipboard = DOMEventCategory(rawValue: 0x80)
    public static let Message = DOMEventCategory(rawValue: 0x100)
    public static let Wheel = DOMEventCategory(rawValue: 0x200)
    public static let BeforeTextInserted = DOMEventCategory(rawValue: 0x400)
    public static let Overflow = DOMEventCategory(rawValue: 0x800)
    public static let PageTransition = DOMEventCategory(rawValue: 0x1000)
    public static let Popstate = DOMEventCategory(rawValue: 0x2000)
    public static let Progress = DOMEventCategory(rawValue: 0x4000)
    public static let XMLHTTPRequestProgress = DOMEventCategory(rawValue: 0x8000)
}

extension DOMEventCategory {
    static func fromCEF(value: cef_dom_event_category_t) -> DOMEventCategory {
        return DOMEventCategory(rawValue: UInt32(value.rawValue))
    }

    func toCEF() -> cef_dom_event_category_t {
        return cef_dom_event_category_t(rawValue: UInt32(rawValue))
    }
}

