//
//  CEFCursorType.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_types.h.
//

import Foundation

/// Cursor type values.
public enum CEFCursorType: Int32 {
    case pointer = 0
    case cross
    case hand
    case iBeam
    case wait
    case help
    case eastResize
    case northResize
    case neResize
    case nwResize
    case southResize
    case seResize
    case swResize
    case westResize
    case nsResize
    case ewResize
    case neswResize
    case nwseResize
    case columnResize
    case rowResize
    case middlePanning
    case eastPanning
    case northPanning
    case nePanning
    case nwPanning
    case southPanning
    case sePanning
    case swPanning
    case westPanning
    case move
    case verticalText
    case cell
    case contextMenu
    case alias
    case progress
    case noDrop
    case copy
    case none
    case notAllowed
    case zoomIn
    case zoomOut
    case grab
    case grabbing
    case custom
}

extension CEFCursorType {
    static func fromCEF(value: cef_cursor_type_t) -> CEFCursorType {
        return CEFCursorType(rawValue: Int32(value.rawValue))!
    }

    func toCEF() -> cef_cursor_type_t {
        return cef_cursor_type_t(rawValue: UInt32(rawValue))
    }
}

