//
//  CEFDragHandler.g.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 11..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

func CEFDragHandler_on_drag_enter(ptr: UnsafeMutablePointer<cef_drag_handler_t>?,
                                  browser: UnsafeMutablePointer<cef_browser_t>?,
                                  dragData: UnsafeMutablePointer<cef_drag_data_t>?,
                                  mask: cef_drag_operations_mask_t) -> Int32 {
    guard let obj = CEFDragHandlerMarshaller.get(ptr) else {
        return 0
    }
    
    let action = obj.onDragEnter(browser: CEFBrowser.fromCEF(browser)!,
                                 dragData: CEFDragData.fromCEF(dragData)!,
                                 operationMask: CEFDragOperationsMask.fromCEF(mask))
    return action == .cancel ? 1 : 0
}

func CEFDragHandler_on_draggable_regions_changed(ptr: UnsafeMutablePointer<cef_drag_handler_t>?,
                                                 browser: UnsafeMutablePointer<cef_browser_t>?,
                                                 frame: UnsafeMutablePointer<cef_frame_t>?,
                                                 count: size_t,
                                                 cefRegions: UnsafePointer<cef_draggable_region_t>?) {
    guard let obj = CEFDragHandlerMarshaller.get(ptr) else {
        return
    }
    
    var regions = [CEFDraggableRegion]()
    for i in 0..<count {
        regions.append(CEFDraggableRegion.fromCEF(cefRegions!.advanced(by: i).pointee))
    }
    
    obj.onDraggableRegionsChanged(browser: CEFBrowser.fromCEF(browser)!,
                                  frame: CEFFrame.fromCEF(frame)!,
                                  regions: regions)
}

