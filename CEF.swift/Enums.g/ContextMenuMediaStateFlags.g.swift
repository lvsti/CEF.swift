//
//  ContextMenuMediaStateFlags.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_types.h.
//

import Foundation

/// Supported context menu media state bit flags.
public struct ContextMenuMediaStateFlags: OptionSetType {
    public let rawValue: UInt32
    public init(rawValue: UInt32) {
        self.rawValue = rawValue
    }

    public static let None = ContextMenuMediaStateFlags(rawValue: 0)
    public static let Error = ContextMenuMediaStateFlags(rawValue: 1 << 0)
    public static let Paused = ContextMenuMediaStateFlags(rawValue: 1 << 1)
    public static let Muted = ContextMenuMediaStateFlags(rawValue: 1 << 2)
    public static let Loop = ContextMenuMediaStateFlags(rawValue: 1 << 3)
    public static let CanSave = ContextMenuMediaStateFlags(rawValue: 1 << 4)
    public static let HasAudio = ContextMenuMediaStateFlags(rawValue: 1 << 5)
    public static let HasVideo = ContextMenuMediaStateFlags(rawValue: 1 << 6)
    public static let ControlRootElement = ContextMenuMediaStateFlags(rawValue: 1 << 7)
    public static let CanPrint = ContextMenuMediaStateFlags(rawValue: 1 << 8)
    public static let CanRotate = ContextMenuMediaStateFlags(rawValue: 1 << 9)
}

extension ContextMenuMediaStateFlags {
    static func fromCEF(value: cef_context_menu_media_state_flags_t) -> ContextMenuMediaStateFlags {
        return ContextMenuMediaStateFlags(rawValue: UInt32(value.rawValue))
    }

    func toCEF() -> cef_context_menu_media_state_flags_t {
        return cef_context_menu_media_state_flags_t(rawValue: UInt32(rawValue))
    }
}

