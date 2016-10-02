//
//  CEFMenuItemType.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_types.h.
//

import Foundation

/// Supported menu item types.
public enum CEFMenuItemType: Int32 {
    case none
    case command
    case check
    case radio
    case separator
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

