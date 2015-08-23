//
//  CEFDOMEventCategory.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_types.h.
//

import Foundation

/// DOM event category flags.
public struct CEFDOMEventCategory: OptionSetType {
    public let rawValue: UInt32
    public init(rawValue: UInt32) {
        self.rawValue = rawValue
    }

    public static let Unknown = CEFDOMEventCategory(rawValue: 0x0)
    public static let UI = CEFDOMEventCategory(rawValue: 0x1)
    public static let Mouse = CEFDOMEventCategory(rawValue: 0x2)
    public static let Mutation = CEFDOMEventCategory(rawValue: 0x4)
    public static let Keyboard = CEFDOMEventCategory(rawValue: 0x8)
    public static let Text = CEFDOMEventCategory(rawValue: 0x10)
    public static let Composition = CEFDOMEventCategory(rawValue: 0x20)
    public static let Drag = CEFDOMEventCategory(rawValue: 0x40)
    public static let Clipboard = CEFDOMEventCategory(rawValue: 0x80)
    public static let Message = CEFDOMEventCategory(rawValue: 0x100)
    public static let Wheel = CEFDOMEventCategory(rawValue: 0x200)
    public static let BeforeTextInserted = CEFDOMEventCategory(rawValue: 0x400)
    public static let Overflow = CEFDOMEventCategory(rawValue: 0x800)
    public static let PageTransition = CEFDOMEventCategory(rawValue: 0x1000)
    public static let Popstate = CEFDOMEventCategory(rawValue: 0x2000)
    public static let Progress = CEFDOMEventCategory(rawValue: 0x4000)
    public static let XMLHTTPRequestProgress = CEFDOMEventCategory(rawValue: 0x8000)
}

extension CEFDOMEventCategory {
    static func fromCEF(value: cef_dom_event_category_t) -> CEFDOMEventCategory {
        return CEFDOMEventCategory(rawValue: UInt32(value.rawValue))
    }

    func toCEF() -> cef_dom_event_category_t {
        return cef_dom_event_category_t(rawValue: UInt32(rawValue))
    }
}

