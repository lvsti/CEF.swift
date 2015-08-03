//
//  CEFJSDialogType.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_types.h.
//

import Foundation

///
// Supported JavaScript dialog types.
///
public enum CEFJSDialogType: Int32 {
    case Alert = 0
    case Confirm
    case Prompt
}

extension CEFJSDialogType {
    static func fromCEF(value: cef_jsdialog_type_t) -> CEFJSDialogType {
        return CEFJSDialogType(rawValue: Int32(value.rawValue))!
    }

    func toCEF() -> cef_jsdialog_type_t {
        return cef_jsdialog_type_t(rawValue: UInt32(rawValue))
    }
}

