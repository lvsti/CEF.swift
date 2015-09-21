//
//  ContextMenuEditStateFlags.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_types.h.
//

import Foundation

/// Supported context menu edit state bit flags.
public struct ContextMenuEditStateFlags: OptionSetType {
    public let rawValue: UInt32
    public init(rawValue: UInt32) {
        self.rawValue = rawValue
    }

    public static let None = ContextMenuEditStateFlags(rawValue: 0)
    public static let CanUndo = ContextMenuEditStateFlags(rawValue: 1 << 0)
    public static let CanRedo = ContextMenuEditStateFlags(rawValue: 1 << 1)
    public static let CanCut = ContextMenuEditStateFlags(rawValue: 1 << 2)
    public static let CanCopy = ContextMenuEditStateFlags(rawValue: 1 << 3)
    public static let CanPaste = ContextMenuEditStateFlags(rawValue: 1 << 4)
    public static let CanDelete = ContextMenuEditStateFlags(rawValue: 1 << 5)
    public static let CanSelectAll = ContextMenuEditStateFlags(rawValue: 1 << 6)
    public static let CanTranslate = ContextMenuEditStateFlags(rawValue: 1 << 7)
}

extension ContextMenuEditStateFlags {
    static func fromCEF(value: cef_context_menu_edit_state_flags_t) -> ContextMenuEditStateFlags {
        return ContextMenuEditStateFlags(rawValue: UInt32(value.rawValue))
    }

    func toCEF() -> cef_context_menu_edit_state_flags_t {
        return cef_context_menu_edit_state_flags_t(rawValue: UInt32(rawValue))
    }
}

