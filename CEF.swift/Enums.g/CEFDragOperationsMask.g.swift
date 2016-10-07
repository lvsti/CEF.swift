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
/// CEF name: `cef_drag_operations_mask_t`.
public struct CEFDragOperationsMask: OptionSet {
    public let rawValue: UInt32
    public init(rawValue: UInt32) {
        self.rawValue = rawValue
    }

    /// CEF name: `DRAG_OPERATION_NONE`.
    public static let none = CEFDragOperationsMask(rawValue: 0)
    /// CEF name: `DRAG_OPERATION_COPY`.
    public static let copy = CEFDragOperationsMask(rawValue: 1)
    /// CEF name: `DRAG_OPERATION_LINK`.
    public static let link = CEFDragOperationsMask(rawValue: 2)
    /// CEF name: `DRAG_OPERATION_GENERIC`.
    public static let generic = CEFDragOperationsMask(rawValue: 4)
    /// CEF name: `DRAG_OPERATION_PRIVATE`.
    public static let privateDrag = CEFDragOperationsMask(rawValue: 8)
    /// CEF name: `DRAG_OPERATION_MOVE`.
    public static let move = CEFDragOperationsMask(rawValue: 16)
    /// CEF name: `DRAG_OPERATION_DELETE`.
    public static let delete = CEFDragOperationsMask(rawValue: 32)
    /// CEF name: `DRAG_OPERATION_EVERY`.
    public static let any = CEFDragOperationsMask(rawValue: UInt32.max)
}

extension CEFDragOperationsMask {
    static func fromCEF(_ value: cef_drag_operations_mask_t) -> CEFDragOperationsMask {
        return CEFDragOperationsMask(rawValue: UInt32(value.rawValue))
    }

    func toCEF() -> cef_drag_operations_mask_t {
        return cef_drag_operations_mask_t(rawValue: UInt32(rawValue))
    }
}

