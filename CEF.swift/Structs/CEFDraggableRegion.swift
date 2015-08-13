//
//  CEFDraggableRegion.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 11..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

public struct CEFDraggableRegion {
    public let bounds: NSRect
    public let isDraggable: Bool
}

extension CEFDraggableRegion {
    static func fromCEF(value: cef_draggable_region_t) -> CEFDraggableRegion {
        return CEFDraggableRegion(bounds: NSRect.fromCEF(value.bounds),
                                  isDraggable: value.draggable != 0)
    }
}

