//
//  CEFContextMenuMediaStateFlags.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_types.h.
//

import Foundation

/// Supported context menu media state bit flags.
public struct CEFContextMenuMediaStateFlags: OptionSetType {
    public let rawValue: UInt32
    public init(rawValue: UInt32) {
        self.rawValue = rawValue
    }

    public static let None = CEFContextMenuMediaStateFlags(rawValue: 0)
    public static let Error = CEFContextMenuMediaStateFlags(rawValue: 1 << 0)
    public static let Paused = CEFContextMenuMediaStateFlags(rawValue: 1 << 1)
    public static let Muted = CEFContextMenuMediaStateFlags(rawValue: 1 << 2)
    public static let Loop = CEFContextMenuMediaStateFlags(rawValue: 1 << 3)
    public static let CanSave = CEFContextMenuMediaStateFlags(rawValue: 1 << 4)
    public static let HasAudio = CEFContextMenuMediaStateFlags(rawValue: 1 << 5)
    public static let HasVideo = CEFContextMenuMediaStateFlags(rawValue: 1 << 6)
    public static let ControlRootElement = CEFContextMenuMediaStateFlags(rawValue: 1 << 7)
    public static let CanPrint = CEFContextMenuMediaStateFlags(rawValue: 1 << 8)
    public static let CanRotate = CEFContextMenuMediaStateFlags(rawValue: 1 << 9)
}

extension CEFContextMenuMediaStateFlags {
    static func fromCEF(value: cef_context_menu_media_state_flags_t) -> CEFContextMenuMediaStateFlags {
        return CEFContextMenuMediaStateFlags(rawValue: UInt32(value.rawValue))
    }

    func toCEF() -> cef_context_menu_media_state_flags_t {
        return cef_context_menu_media_state_flags_t(rawValue: UInt32(rawValue))
    }
}

