//
//  CEFMenuColorType.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_types.h.
//

import Foundation

/// Supported color types for menu items.
/// CEF name: `cef_menu_color_type_t`.
public enum CEFMenuColorType: Int32 {
    /// CEF name: `CEF_MENU_COLOR_TEXT`.
    case text
    /// CEF name: `CEF_MENU_COLOR_TEXT_HOVERED`.
    case textHovered
    /// CEF name: `CEF_MENU_COLOR_TEXT_ACCELERATOR`.
    case textAccelerator
    /// CEF name: `CEF_MENU_COLOR_TEXT_ACCELERATOR_HOVERED`.
    case textAcceleratorHovered
    /// CEF name: `CEF_MENU_COLOR_BACKGROUND`.
    case background
    /// CEF name: `CEF_MENU_COLOR_BACKGROUND_HOVERED`.
    case backgroundHovered
    /// CEF name: `CEF_MENU_COLOR_COUNT`.
    case count
}

extension CEFMenuColorType {
    static func fromCEF(_ value: cef_menu_color_type_t) -> CEFMenuColorType {
        return CEFMenuColorType(rawValue: Int32(value.rawValue))!
    }

    func toCEF() -> cef_menu_color_type_t {
        return cef_menu_color_type_t(rawValue: UInt32(rawValue))
    }
}

