//
//  CEFWindowOpenDisposition.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_types.h.
//

import Foundation

/// The manner in which a link click should be opened.
public enum CEFWindowOpenDisposition: Int32 {
    case unknown
    case suppressOpen
    case currentTab
    case singletonTab
    case newForegroundTab
    case newBackgroundTab
    case newPopup
    case newWindow
    case saveToDisk
    case offTheRecord
    case ignoreAction
}

extension CEFWindowOpenDisposition {
    static func fromCEF(_ value: cef_window_open_disposition_t) -> CEFWindowOpenDisposition {
        return CEFWindowOpenDisposition(rawValue: Int32(value.rawValue))!
    }

    func toCEF() -> cef_window_open_disposition_t {
        return cef_window_open_disposition_t(rawValue: UInt32(rawValue))
    }
}

