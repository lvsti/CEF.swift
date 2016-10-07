//
//  CEFContextMenuMediaStateFlags.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_types.h.
//

import Foundation

/// Supported context menu media state bit flags.
/// CEF name: `cef_context_menu_media_state_flags_t`.
public struct CEFContextMenuMediaStateFlags: OptionSet {
    public let rawValue: UInt32
    public init(rawValue: UInt32) {
        self.rawValue = rawValue
    }

    /// CEF name: `CM_MEDIAFLAG_NONE`.
    public static let none = CEFContextMenuMediaStateFlags(rawValue: 0)
    /// CEF name: `CM_MEDIAFLAG_ERROR`.
    public static let error = CEFContextMenuMediaStateFlags(rawValue: 1 << 0)
    /// CEF name: `CM_MEDIAFLAG_PAUSED`.
    public static let paused = CEFContextMenuMediaStateFlags(rawValue: 1 << 1)
    /// CEF name: `CM_MEDIAFLAG_MUTED`.
    public static let muted = CEFContextMenuMediaStateFlags(rawValue: 1 << 2)
    /// CEF name: `CM_MEDIAFLAG_LOOP`.
    public static let loop = CEFContextMenuMediaStateFlags(rawValue: 1 << 3)
    /// CEF name: `CM_MEDIAFLAG_CAN_SAVE`.
    public static let canSave = CEFContextMenuMediaStateFlags(rawValue: 1 << 4)
    /// CEF name: `CM_MEDIAFLAG_HAS_AUDIO`.
    public static let hasAudio = CEFContextMenuMediaStateFlags(rawValue: 1 << 5)
    /// CEF name: `CM_MEDIAFLAG_HAS_VIDEO`.
    public static let hasVideo = CEFContextMenuMediaStateFlags(rawValue: 1 << 6)
    /// CEF name: `CM_MEDIAFLAG_CONTROL_ROOT_ELEMENT`.
    public static let controlRootElement = CEFContextMenuMediaStateFlags(rawValue: 1 << 7)
    /// CEF name: `CM_MEDIAFLAG_CAN_PRINT`.
    public static let canPrint = CEFContextMenuMediaStateFlags(rawValue: 1 << 8)
    /// CEF name: `CM_MEDIAFLAG_CAN_ROTATE`.
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

