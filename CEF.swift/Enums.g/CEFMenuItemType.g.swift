//
//  CEFMenuItemType.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_types.h.
//

import Foundation

/// Supported menu item types.
/// CEF name: `cef_menu_item_type_t`.
public enum CEFMenuItemType: Int32 {
    /// CEF name: `MENUITEMTYPE_NONE`.
    case none
    /// CEF name: `MENUITEMTYPE_COMMAND`.
    case command
    /// CEF name: `MENUITEMTYPE_CHECK`.
    case check
    /// CEF name: `MENUITEMTYPE_RADIO`.
    case radio
    /// CEF name: `MENUITEMTYPE_SEPARATOR`.
    case separator
    /// CEF name: `MENUITEMTYPE_SUBMENU`.
    case submenu
}

extension CEFMenuItemType {
    static func fromCEF(_ value: cef_menu_item_type_t) -> CEFMenuItemType {
        return CEFMenuItemType(rawValue: Int32(value.rawValue))!
    }

    func toCEF() -> cef_menu_item_type_t {
        return cef_menu_item_type_t(rawValue: UInt32(rawValue))
    }
}

