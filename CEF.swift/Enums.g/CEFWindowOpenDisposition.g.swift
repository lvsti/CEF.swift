//
//  CEFWindowOpenDisposition.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_types.h.
//

import Foundation

/// The manner in which a link click should be opened.
public enum CEFWindowOpenDisposition: Int32 {
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

extension CEFWindowOpenDisposition {
    static func fromCEF(value: cef_window_open_disposition_t) -> CEFWindowOpenDisposition {
        return CEFWindowOpenDisposition(rawValue: Int32(value.rawValue))!
    }

    func toCEF() -> cef_window_open_disposition_t {
        return cef_window_open_disposition_t(rawValue: UInt32(rawValue))
    }
}

