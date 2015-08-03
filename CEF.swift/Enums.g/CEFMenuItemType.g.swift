//
//  CEFMenuItemType.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_types.h.
//

import Foundation

///
// Supported menu item types.
///
public enum CEFMenuItemType: Int32 {
    case None
    case Command
    case Check
    case Radio
    case Separator
    case Submenu
}

extension CEFMenuItemType {
    static func fromCEF(value: cef_menu_item_type_t) -> CEFMenuItemType {
        return CEFMenuItemType(rawValue: Int32(value.rawValue))!
    }

    func toCEF() -> cef_menu_item_type_t {
        return cef_menu_item_type_t(rawValue: UInt32(rawValue))
    }
}

