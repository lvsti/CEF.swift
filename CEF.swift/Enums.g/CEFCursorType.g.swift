//
//  CEFCursorType.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_types.h.
//

import Foundation

/// Cursor type values.
/// CEF name: `cef_cursor_type_t`.
public enum CEFCursorType: Int32 {
    /// CEF name: `CT_POINTER`.
    case pointer = 0
    /// CEF name: `CT_CROSS`.
    case cross
    /// CEF name: `CT_HAND`.
    case hand
    /// CEF name: `CT_IBEAM`.
    case iBeam
    /// CEF name: `CT_WAIT`.
    case wait
    /// CEF name: `CT_HELP`.
    case help
    /// CEF name: `CT_EASTRESIZE`.
    case eastResize
    /// CEF name: `CT_NORTHRESIZE`.
    case northResize
    /// CEF name: `CT_NORTHEASTRESIZE`.
    case neResize
    /// CEF name: `CT_NORTHWESTRESIZE`.
    case nwResize
    /// CEF name: `CT_SOUTHRESIZE`.
    case southResize
    /// CEF name: `CT_SOUTHEASTRESIZE`.
    case seResize
    /// CEF name: `CT_SOUTHWESTRESIZE`.
    case swResize
    /// CEF name: `CT_WESTRESIZE`.
    case westResize
    /// CEF name: `CT_NORTHSOUTHRESIZE`.
    case nsResize
    /// CEF name: `CT_EASTWESTRESIZE`.
    case ewResize
    /// CEF name: `CT_NORTHEASTSOUTHWESTRESIZE`.
    case neswResize
    /// CEF name: `CT_NORTHWESTSOUTHEASTRESIZE`.
    case nwseResize
    /// CEF name: `CT_COLUMNRESIZE`.
    case columnResize
    /// CEF name: `CT_ROWRESIZE`.
    case rowResize
    /// CEF name: `CT_MIDDLEPANNING`.
    case middlePanning
    /// CEF name: `CT_EASTPANNING`.
    case eastPanning
    /// CEF name: `CT_NORTHPANNING`.
    case northPanning
    /// CEF name: `CT_NORTHEASTPANNING`.
    case nePanning
    /// CEF name: `CT_NORTHWESTPANNING`.
    case nwPanning
    /// CEF name: `CT_SOUTHPANNING`.
    case southPanning
    /// CEF name: `CT_SOUTHEASTPANNING`.
    case sePanning
    /// CEF name: `CT_SOUTHWESTPANNING`.
    case swPanning
    /// CEF name: `CT_WESTPANNING`.
    case westPanning
    /// CEF name: `CT_MOVE`.
    case move
    /// CEF name: `CT_VERTICALTEXT`.
    case verticalText
    /// CEF name: `CT_CELL`.
    case cell
    /// CEF name: `CT_CONTEXTMENU`.
    case contextMenu
    /// CEF name: `CT_ALIAS`.
    case alias
    /// CEF name: `CT_PROGRESS`.
    case progress
    /// CEF name: `CT_NODROP`.
    case noDrop
    /// CEF name: `CT_COPY`.
    case copy
    /// CEF name: `CT_NONE`.
    case none
    /// CEF name: `CT_NOTALLOWED`.
    case notAllowed
    /// CEF name: `CT_ZOOMIN`.
    case zoomIn
    /// CEF name: `CT_ZOOMOUT`.
    case zoomOut
    /// CEF name: `CT_GRAB`.
    case grab
    /// CEF name: `CT_GRABBING`.
    case grabbing
    /// CEF name: `CT_MIDDLE_PANNING_VERTICAL`.
    case middlePanningVertical
    /// CEF name: `CT_MIDDLE_PANNING_HORIZONTAL`.
    case middlePanningHorizontal
    /// CEF name: `CT_CUSTOM`.
    case custom
    /// CEF name: `CT_DND_NONE`.
    case dndNone
    /// CEF name: `CT_DND_MOVE`.
    case dndMove
    /// CEF name: `CT_DND_COPY`.
    case dndCopy
    /// CEF name: `CT_DND_LINK`.
    case dndLink
}

extension CEFCursorType {
    static func fromCEF(_ value: cef_cursor_type_t) -> CEFCursorType {
        return CEFCursorType(rawValue: Int32(value.rawValue))!
    }

    func toCEF() -> cef_cursor_type_t {
        return cef_cursor_type_t(rawValue: UInt32(rawValue))
    }
}

