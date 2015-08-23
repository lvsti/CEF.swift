//
//  CEFContextMenuEditStateFlags.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_types.h.
//

import Foundation

/// Supported context menu edit state bit flags.
public struct CEFContextMenuEditStateFlags: OptionSetType {
    public let rawValue: UInt32
    public init(rawValue: UInt32) {
        self.rawValue = rawValue
    }

    public static let None = CEFContextMenuEditStateFlags(rawValue: 0)
    public static let CanUndo = CEFContextMenuEditStateFlags(rawValue: 1 << 0)
    public static let CanRedo = CEFContextMenuEditStateFlags(rawValue: 1 << 1)
    public static let CanCut = CEFContextMenuEditStateFlags(rawValue: 1 << 2)
    public static let CanCopy = CEFContextMenuEditStateFlags(rawValue: 1 << 3)
    public static let CanPaste = CEFContextMenuEditStateFlags(rawValue: 1 << 4)
    public static let CanDelete = CEFContextMenuEditStateFlags(rawValue: 1 << 5)
    public static let CanSelectAll = CEFContextMenuEditStateFlags(rawValue: 1 << 6)
    public static let CanTranslate = CEFContextMenuEditStateFlags(rawValue: 1 << 7)
}

extension CEFContextMenuEditStateFlags {
    static func fromCEF(value: cef_context_menu_edit_state_flags_t) -> CEFContextMenuEditStateFlags {
        return CEFContextMenuEditStateFlags(rawValue: UInt32(value.rawValue))
    }

    func toCEF() -> cef_context_menu_edit_state_flags_t {
        return cef_context_menu_edit_state_flags_t(rawValue: UInt32(rawValue))
    }
}

