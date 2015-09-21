//
//  ContextMenuMediaType.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_types.h.
//

import Foundation

/// Supported context menu media types.
public enum ContextMenuMediaType: Int32 {

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

extension ContextMenuMediaType {
    static func fromCEF(value: cef_context_menu_media_type_t) -> ContextMenuMediaType {
        return ContextMenuMediaType(rawValue: Int32(value.rawValue))!
    }

    func toCEF() -> cef_context_menu_media_type_t {
        return cef_context_menu_media_type_t(rawValue: UInt32(rawValue))
    }
}

