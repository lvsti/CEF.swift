//
//  CEFContextMenuMediaType.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_types.h.
//

import Foundation

/// Supported context menu media types.
/// CEF name: `cef_context_menu_media_type_t`.
public enum CEFContextMenuMediaType: Int32 {

    /// No special node is in context.
    /// CEF name: `CM_MEDIATYPE_NONE`.
    case none

    /// An image node is selected.
    /// CEF name: `CM_MEDIATYPE_IMAGE`.
    case image

    /// A video node is selected.
    /// CEF name: `CM_MEDIATYPE_VIDEO`.
    case video

    /// An audio node is selected.
    /// CEF name: `CM_MEDIATYPE_AUDIO`.
    case audio

    /// A file node is selected.
    /// CEF name: `CM_MEDIATYPE_FILE`.
    case file

    /// A plugin node is selected.
    /// CEF name: `CM_MEDIATYPE_PLUGIN`.
    case plugin
}

extension CEFContextMenuMediaType {
    static func fromCEF(_ value: cef_context_menu_media_type_t) -> CEFContextMenuMediaType {
        return CEFContextMenuMediaType(rawValue: Int32(value.rawValue))!
    }

    func toCEF() -> cef_context_menu_media_type_t {
        return cef_context_menu_media_type_t(rawValue: UInt32(rawValue))
    }
}

