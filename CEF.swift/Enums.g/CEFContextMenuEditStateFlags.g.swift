//
//  CEFContextMenuEditStateFlags.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_types.h.
//

import Foundation

/// Supported context menu edit state bit flags.
public struct CEFContextMenuEditStateFlags: OptionSet {
    public let rawValue: UInt32
    public init(rawValue: UInt32) {
        self.rawValue = rawValue
    }

    public static let none = CEFContextMenuEditStateFlags(rawValue: 0)
    public static let canUndo = CEFContextMenuEditStateFlags(rawValue: 1 << 0)
    public static let canRedo = CEFContextMenuEditStateFlags(rawValue: 1 << 1)
    public static let canCut = CEFContextMenuEditStateFlags(rawValue: 1 << 2)
    public static let canCopy = CEFContextMenuEditStateFlags(rawValue: 1 << 3)
    public static let canPaste = CEFContextMenuEditStateFlags(rawValue: 1 << 4)
    public static let canDelete = CEFContextMenuEditStateFlags(rawValue: 1 << 5)
    public static let canSelectAll = CEFContextMenuEditStateFlags(rawValue: 1 << 6)
    public static let canTranslate = CEFContextMenuEditStateFlags(rawValue: 1 << 7)
}

extension CEFContextMenuEditStateFlags {
    static func fromCEF(value: cef_context_menu_edit_state_flags_t) -> CEFContextMenuEditStateFlags {
        return CEFContextMenuEditStateFlags(rawValue: UInt32(value.rawValue))
    }

    func toCEF() -> cef_context_menu_edit_state_flags_t {
        return cef_context_menu_edit_state_flags_t(rawValue: UInt32(rawValue))
    }
}

