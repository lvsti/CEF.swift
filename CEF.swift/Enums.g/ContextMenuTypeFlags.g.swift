//
//  ContextMenuTypeFlags.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_types.h.
//

import Foundation

/// Supported context menu type flags.
public struct ContextMenuTypeFlags: OptionSetType {
    public let rawValue: UInt32
    public init(rawValue: UInt32) {
        self.rawValue = rawValue
    }


    /// No node is selected.
    public static let None = ContextMenuTypeFlags(rawValue: 0)

    /// The top page is selected.
    public static let Page = ContextMenuTypeFlags(rawValue: 1 << 0)

    /// A subframe page is selected.
    public static let Frame = ContextMenuTypeFlags(rawValue: 1 << 1)

    /// A link is selected.
    public static let Link = ContextMenuTypeFlags(rawValue: 1 << 2)

    /// A media node is selected.
    public static let Media = ContextMenuTypeFlags(rawValue: 1 << 3)

    /// There is a textual or mixed selection that is selected.
    public static let Selection = ContextMenuTypeFlags(rawValue: 1 << 4)

    /// An editable element is selected.
    public static let Editable = ContextMenuTypeFlags(rawValue: 1 << 5)
}

extension ContextMenuTypeFlags {
    static func fromCEF(value: cef_context_menu_type_flags_t) -> ContextMenuTypeFlags {
        return ContextMenuTypeFlags(rawValue: UInt32(value.rawValue))
    }

    func toCEF() -> cef_context_menu_type_flags_t {
        return cef_context_menu_type_flags_t(rawValue: UInt32(rawValue))
    }
}

