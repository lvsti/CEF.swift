//
//  CEFCursorType.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_types.h.
//

import Foundation

///
// Cursor type values.
///
public enum CEFCursorType: Int32 {
    case Pointer = 0
    case Cross
    case Hand
    case IBeam
    case Wait
    case Help
    case EastResize
    case NorthResize
    case NEResize
    case NWResize
    case SouthResize
    case SEResize
    case SWResize
    case WestResize
    case NSResize
    case EWResize
    case NESWResize
    case NWSEResize
    case ColumnResize
    case RowResize
    case MiddlePanning
    case EastPanning
    case NorthPanning
    case NEPanning
    case NWPanning
    case SouthPanning
    case SEPanning
    case SWPanning
    case WestPanning
    case Move
    case VerticalText
    case Cell
    case ContextMenu
    case Alias
    case Progress
    case NoDrop
    case Copy
    case None
    case NotAllowed
    case ZoomIn
    case ZoomOut
    case Grab
    case Grabbing
    case Custom
}

extension CEFCursorType {
    static func fromCEF(value: cef_cursor_type_t) -> CEFCursorType {
        return CEFCursorType(rawValue: Int32(value.rawValue))!
    }

    func toCEF() -> cef_cursor_type_t {
        return cef_cursor_type_t(rawValue: UInt32(rawValue))
    }
}

