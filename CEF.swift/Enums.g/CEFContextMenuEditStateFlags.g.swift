//
//  CEFContextMenuEditStateFlags.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_types.h.
//

import Foundation

/// Supported context menu edit state bit flags.
/// CEF name: `cef_context_menu_edit_state_flags_t`.
public struct CEFContextMenuEditStateFlags: OptionSet {
    public let rawValue: UInt32
    public init(rawValue: UInt32) {
        self.rawValue = rawValue
    }

    /// CEF name: `CM_EDITFLAG_NONE`.
    public static let none = CEFContextMenuEditStateFlags(rawValue: 0)
    /// CEF name: `CM_EDITFLAG_CAN_UNDO`.
    public static let canUndo = CEFContextMenuEditStateFlags(rawValue: 1 << 0)
    /// CEF name: `CM_EDITFLAG_CAN_REDO`.
    public static let canRedo = CEFContextMenuEditStateFlags(rawValue: 1 << 1)
    /// CEF name: `CM_EDITFLAG_CAN_CUT`.
    public static let canCut = CEFContextMenuEditStateFlags(rawValue: 1 << 2)
    /// CEF name: `CM_EDITFLAG_CAN_COPY`.
    public static let canCopy = CEFContextMenuEditStateFlags(rawValue: 1 << 3)
    /// CEF name: `CM_EDITFLAG_CAN_PASTE`.
    public static let canPaste = CEFContextMenuEditStateFlags(rawValue: 1 << 4)
    /// CEF name: `CM_EDITFLAG_CAN_DELETE`.
    public static let canDelete = CEFContextMenuEditStateFlags(rawValue: 1 << 5)
    /// CEF name: `CM_EDITFLAG_CAN_SELECT_ALL`.
    public static let canSelectAll = CEFContextMenuEditStateFlags(rawValue: 1 << 6)
    /// CEF name: `CM_EDITFLAG_CAN_TRANSLATE`.
    public static let canTranslate = CEFContextMenuEditStateFlags(rawValue: 1 << 7)
}

extension CEFContextMenuEditStateFlags {
    static func fromCEF(_ value: cef_context_menu_edit_state_flags_t) -> CEFContextMenuEditStateFlags {
        return CEFContextMenuEditStateFlags(rawValue: UInt32(value.rawValue))
    }

    func toCEF() -> cef_context_menu_edit_state_flags_t {
        return cef_context_menu_edit_state_flags_t(rawValue: UInt32(rawValue))
    }
}

