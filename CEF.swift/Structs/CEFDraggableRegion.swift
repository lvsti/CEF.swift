//
//  CEFDraggableRegion.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 11..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

/// Structure representing a draggable region.
/// CEF name: `cef_draggable_region_t`
public struct CEFDraggableRegion {
    /// Bounds of the region.
    /// CEF name: `bounds`
    public let bounds: NSRect

    /// True (1) this this region is draggable and false (0) otherwise.
    /// CEF name: `draggable`
    public let isDraggable: Bool
}

extension CEFDraggableRegion {
    static func fromCEF(_ value: cef_draggable_region_t) -> CEFDraggableRegion {
        return CEFDraggableRegion(bounds: NSRect.fromCEF(value.bounds),
                                  isDraggable: value.draggable != 0)
    }
}

