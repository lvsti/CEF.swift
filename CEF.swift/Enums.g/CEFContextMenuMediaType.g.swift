//
//  CEFContextMenuMediaType.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_types.h.
//

import Foundation

/// Supported context menu media types.
public enum CEFContextMenuMediaType: Int32 {

    /// No special node is in context.
    case None

    /// An image node is selected.
    case Image

    /// A video node is selected.
    case Video

    /// An audio node is selected.
    case Audio

    /// A file node is selected.
    case File

    /// A plugin node is selected.
    case Plugin
}

extension CEFContextMenuMediaType {
    static func fromCEF(value: cef_context_menu_media_type_t) -> CEFContextMenuMediaType {
        return CEFContextMenuMediaType(rawValue: Int32(value.rawValue))!
    }

    func toCEF() -> cef_context_menu_media_type_t {
        return cef_context_menu_media_type_t(rawValue: UInt32(rawValue))
    }
}

