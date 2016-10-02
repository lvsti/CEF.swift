//
//  CEFContextMenuMediaStateFlags.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_types.h.
//

import Foundation

/// Supported context menu media state bit flags.
public struct CEFContextMenuMediaStateFlags: OptionSet {
    public let rawValue: UInt32
    public init(rawValue: UInt32) {
        self.rawValue = rawValue
    }

    public static let none = CEFContextMenuMediaStateFlags(rawValue: 0)
    public static let error = CEFContextMenuMediaStateFlags(rawValue: 1 << 0)
    public static let paused = CEFContextMenuMediaStateFlags(rawValue: 1 << 1)
    public static let muted = CEFContextMenuMediaStateFlags(rawValue: 1 << 2)
    public static let loop = CEFContextMenuMediaStateFlags(rawValue: 1 << 3)
    public static let canSave = CEFContextMenuMediaStateFlags(rawValue: 1 << 4)
    public static let hasAudio = CEFContextMenuMediaStateFlags(rawValue: 1 << 5)
    public static let hasVideo = CEFContextMenuMediaStateFlags(rawValue: 1 << 6)
    public static let controlRootElement = CEFContextMenuMediaStateFlags(rawValue: 1 << 7)
    public static let canPrint = CEFContextMenuMediaStateFlags(rawValue: 1 << 8)
    public static let canRotate = CEFContextMenuMediaStateFlags(rawValue: 1 << 9)
}

extension CEFContextMenuMediaStateFlags {
    static func fromCEF(_ value: cef_context_menu_media_state_flags_t) -> CEFContextMenuMediaStateFlags {
        return CEFContextMenuMediaStateFlags(rawValue: UInt32(value.rawValue))
    }

    func toCEF() -> cef_context_menu_media_state_flags_t {
        return cef_context_menu_media_state_flags_t(rawValue: UInt32(rawValue))
    }
}

