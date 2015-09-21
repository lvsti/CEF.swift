//
//  DragOperationsMask.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_types.h.
//

import Foundation

/// "Verb" of a drag-and-drop operation as negotiated between the source and
/// destination. These constants match their equivalents in WebCore's
/// DragActions.h and should not be renumbered.
public struct DragOperationsMask: OptionSetType {
    public let rawValue: UInt32
    public init(rawValue: UInt32) {
        self.rawValue = rawValue
    }

    public static let None = DragOperationsMask(rawValue: 0)
    public static let Copy = DragOperationsMask(rawValue: 1)
    public static let Link = DragOperationsMask(rawValue: 2)
    public static let Generic = DragOperationsMask(rawValue: 4)
    public static let Private = DragOperationsMask(rawValue: 8)
    public static let Move = DragOperationsMask(rawValue: 16)
    public static let Delete = DragOperationsMask(rawValue: 32)
    public static let Every = DragOperationsMask(rawValue: UInt32.max)
}

extension DragOperationsMask {
    static func fromCEF(value: cef_drag_operations_mask_t) -> DragOperationsMask {
        return DragOperationsMask(rawValue: UInt32(value.rawValue))
    }

    func toCEF() -> cef_drag_operations_mask_t {
        return cef_drag_operations_mask_t(rawValue: UInt32(rawValue))
    }
}

