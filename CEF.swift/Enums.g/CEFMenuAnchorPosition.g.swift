//
//  CEFMenuAnchorPosition.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_types.h.
//

import Foundation

/// Specifies how a menu will be anchored for non-RTL languages. The opposite
/// position will be used for RTL languages.
public enum CEFMenuAnchorPosition: Int32 {
    case topLeft
    case topRight
    case bottomCenter
}

extension CEFMenuAnchorPosition {
    static func fromCEF(_ value: cef_menu_anchor_position_t) -> CEFMenuAnchorPosition {
        return CEFMenuAnchorPosition(rawValue: Int32(value.rawValue))!
    }

    func toCEF() -> cef_menu_anchor_position_t {
        return cef_menu_anchor_position_t(rawValue: UInt32(rawValue))
    }
}

