//
//  CEFDOMEventCategory.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_types.h.
//

import Foundation

/// DOM event category flags.
/// CEF name: `cef_dom_event_category_t`.
public struct CEFDOMEventCategory: OptionSet {
    public let rawValue: UInt32
    public init(rawValue: UInt32) {
        self.rawValue = rawValue
    }

    /// CEF name: `DOM_EVENT_CATEGORY_UNKNOWN`.
    public static let unknown = CEFDOMEventCategory(rawValue: 0x0)
    /// CEF name: `DOM_EVENT_CATEGORY_UI`.
    public static let ui = CEFDOMEventCategory(rawValue: 0x1)
    /// CEF name: `DOM_EVENT_CATEGORY_MOUSE`.
    public static let mouse = CEFDOMEventCategory(rawValue: 0x2)
    /// CEF name: `DOM_EVENT_CATEGORY_MUTATION`.
    public static let mutation = CEFDOMEventCategory(rawValue: 0x4)
    /// CEF name: `DOM_EVENT_CATEGORY_KEYBOARD`.
    public static let keyboard = CEFDOMEventCategory(rawValue: 0x8)
    /// CEF name: `DOM_EVENT_CATEGORY_TEXT`.
    public static let text = CEFDOMEventCategory(rawValue: 0x10)
    /// CEF name: `DOM_EVENT_CATEGORY_COMPOSITION`.
    public static let composition = CEFDOMEventCategory(rawValue: 0x20)
    /// CEF name: `DOM_EVENT_CATEGORY_DRAG`.
    public static let drag = CEFDOMEventCategory(rawValue: 0x40)
    /// CEF name: `DOM_EVENT_CATEGORY_CLIPBOARD`.
    public static let clipboard = CEFDOMEventCategory(rawValue: 0x80)
    /// CEF name: `DOM_EVENT_CATEGORY_MESSAGE`.
    public static let message = CEFDOMEventCategory(rawValue: 0x100)
    /// CEF name: `DOM_EVENT_CATEGORY_WHEEL`.
    public static let wheel = CEFDOMEventCategory(rawValue: 0x200)
    /// CEF name: `DOM_EVENT_CATEGORY_BEFORE_TEXT_INSERTED`.
    public static let beforeTextInserted = CEFDOMEventCategory(rawValue: 0x400)
    /// CEF name: `DOM_EVENT_CATEGORY_OVERFLOW`.
    public static let overflow = CEFDOMEventCategory(rawValue: 0x800)
    /// CEF name: `DOM_EVENT_CATEGORY_PAGE_TRANSITION`.
    public static let pageTransition = CEFDOMEventCategory(rawValue: 0x1000)
    /// CEF name: `DOM_EVENT_CATEGORY_POPSTATE`.
    public static let popstate = CEFDOMEventCategory(rawValue: 0x2000)
    /// CEF name: `DOM_EVENT_CATEGORY_PROGRESS`.
    public static let progress = CEFDOMEventCategory(rawValue: 0x4000)
    /// CEF name: `DOM_EVENT_CATEGORY_XMLHTTPREQUEST_PROGRESS`.
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

