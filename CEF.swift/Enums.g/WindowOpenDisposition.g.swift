//
//  WindowOpenDisposition.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_types.h.
//

import Foundation

/// The manner in which a link click should be opened.
public enum WindowOpenDisposition: Int32 {
    case Unknown
    case SuppressOpen
    case CurrentTab
    case SingletonTab
    case NewForegroundTab
    case NewBackgroundTab
    case NewPopup
    case NewWindow
    case SaveToDisk
    case OffTheRecord
    case IgnoreAction
}

extension WindowOpenDisposition {
    static func fromCEF(value: cef_window_open_disposition_t) -> WindowOpenDisposition {
        return WindowOpenDisposition(rawValue: Int32(value.rawValue))!
    }

    func toCEF() -> cef_window_open_disposition_t {
        return cef_window_open_disposition_t(rawValue: UInt32(rawValue))
    }
}

