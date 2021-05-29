//
//  CEFTextFieldCommands.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_types.h.
//

import Foundation

/// Represents commands available to TextField.
/// CEF name: `cef_text_field_commands_t`.
public enum CEFTextFieldCommands: Int32 {
    /// CEF name: `CEF_TFC_CUT`.
    case cut = 1
    /// CEF name: `CEF_TFC_COPY`.
    case copy
    /// CEF name: `CEF_TFC_PASTE`.
    case paste
    /// CEF name: `CEF_TFC_UNDO`.
    case undo
    /// CEF name: `CEF_TFC_DELETE`.
    case delete
    /// CEF name: `CEF_TFC_SELECT_ALL`.
    case selectAll
}

extension CEFTextFieldCommands {
    static func fromCEF(_ value: cef_text_field_commands_t) -> CEFTextFieldCommands {
        return CEFTextFieldCommands(rawValue: Int32(value.rawValue))!
    }

    func toCEF() -> cef_text_field_commands_t {
        return cef_text_field_commands_t(rawValue: UInt32(rawValue))
    }
}

