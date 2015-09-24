//
//  DragHandler.g.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 11..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

func DragHandler_on_drag_enter(ptr: UnsafeMutablePointer<cef_drag_handler_t>,
                               browser: UnsafeMutablePointer<cef_browser_t>,
                               dragData: UnsafeMutablePointer<cef_drag_data_t>,
                               mask: cef_drag_operations_mask_t) -> Int32 {
    guard let obj = DragHandlerMarshaller.get(ptr) else {
        return 0
    }
    
    return obj.onDragEnter(Browser.fromCEF(browser)!,
                           dragData: DragData.fromCEF(dragData)!,
                           operationMask: DragOperationsMask.fromCEF(mask)) ? 1 : 0
}

func DragHandler_on_draggable_regions_changed(ptr: UnsafeMutablePointer<cef_drag_handler_t>,
                                              browser: UnsafeMutablePointer<cef_browser_t>,
                                              count: size_t,
                                              cefRegions: UnsafePointer<cef_draggable_region_t>) {
    guard let obj = DragHandlerMarshaller.get(ptr) else {
        return
    }
    
    var regions = [DraggableRegion]()
    for i in 0..<count {
        regions.append(DraggableRegion.fromCEF(cefRegions.advancedBy(i).memory))
    }
    
    obj.onDraggableRegionsChanged(Browser.fromCEF(browser)!, regions: regions)
}

