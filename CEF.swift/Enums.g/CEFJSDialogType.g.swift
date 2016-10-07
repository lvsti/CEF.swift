//
//  CEFJSDialogType.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_types.h.
//

import Foundation

/// Supported JavaScript dialog types.
/// CEF name: `cef_jsdialog_type_t`.
public enum CEFJSDialogType: Int32 {
    /// CEF name: `JSDIALOGTYPE_ALERT`.
    case alert = 0
    /// CEF name: `JSDIALOGTYPE_CONFIRM`.
    case confirm
    /// CEF name: `JSDIALOGTYPE_PROMPT`.
    case prompt
}

extension CEFJSDialogType {
    static func fromCEF(_ value: cef_jsdialog_type_t) -> CEFJSDialogType {
        return CEFJSDialogType(rawValue: Int32(value.rawValue))!
    }

    func toCEF() -> cef_jsdialog_type_t {
        return cef_jsdialog_type_t(rawValue: UInt32(rawValue))
    }
}

