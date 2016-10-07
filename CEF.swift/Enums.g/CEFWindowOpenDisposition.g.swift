//
//  CEFWindowOpenDisposition.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_types.h.
//

import Foundation

/// The manner in which a link click should be opened.
/// CEF name: `cef_window_open_disposition_t`.
public enum CEFWindowOpenDisposition: Int32 {
    /// CEF name: `WOD_UNKNOWN`.
    case unknown
    /// CEF name: `WOD_SUPPRESS_OPEN`.
    case suppressOpen
    /// CEF name: `WOD_CURRENT_TAB`.
    case currentTab
    /// CEF name: `WOD_SINGLETON_TAB`.
    case singletonTab
    /// CEF name: `WOD_NEW_FOREGROUND_TAB`.
    case newForegroundTab
    /// CEF name: `WOD_NEW_BACKGROUND_TAB`.
    case newBackgroundTab
    /// CEF name: `WOD_NEW_POPUP`.
    case newPopup
    /// CEF name: `WOD_NEW_WINDOW`.
    case newWindow
    /// CEF name: `WOD_SAVE_TO_DISK`.
    case saveToDisk
    /// CEF name: `WOD_OFF_THE_RECORD`.
    case offTheRecord
    /// CEF name: `WOD_IGNORE_ACTION`.
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

