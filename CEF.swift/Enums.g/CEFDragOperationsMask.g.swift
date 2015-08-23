//
//  CEFDragOperationsMask.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_types.h.
//

import Foundation

/// "Verb" of a drag-and-drop operation as negotiated between the source and
/// destination. These constants match their equivalents in WebCore's
/// DragActions.h and should not be renumbered.
public struct CEFDragOperationsMask: OptionSetType {
    public let rawValue: UInt32
    public init(rawValue: UInt32) {
        self.rawValue = rawValue
    }

    public static let None = CEFDragOperationsMask(rawValue: 0)
    public static let Copy = CEFDragOperationsMask(rawValue: 1)
    public static let Link = CEFDragOperationsMask(rawValue: 2)
    public static let Generic = CEFDragOperationsMask(rawValue: 4)
    public static let Private = CEFDragOperationsMask(rawValue: 8)
    public static let Move = CEFDragOperationsMask(rawValue: 16)
    public static let Delete = CEFDragOperationsMask(rawValue: 32)
    public static let Every = CEFDragOperationsMask(rawValue: UInt32.max)
}

extension CEFDragOperationsMask {
    static func fromCEF(value: cef_drag_operations_mask_t) -> CEFDragOperationsMask {
        return CEFDragOperationsMask(rawValue: UInt32(value.rawValue))
    }

    func toCEF() -> cef_drag_operations_mask_t {
        return cef_drag_operations_mask_t(rawValue: UInt32(rawValue))
    }
}

