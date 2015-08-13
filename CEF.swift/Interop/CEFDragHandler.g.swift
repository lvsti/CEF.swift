//
//  CEFDragHandler.g.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 11..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

extension cef_drag_handler_t: CEFObject {
}

typealias CEFDragHandlerMarshaller = CEFMarshaller<CEFDragHandler, cef_drag_handler_t>

extension CEFDragHandler {
    func toCEF() -> UnsafeMutablePointer<cef_drag_handler_t> {
        return CEFDragHandlerMarshaller.pass(self)
    }
}

extension cef_drag_handler_t: CEFCallbackMarshalling {
    mutating func marshalCallbacks() {
        on_drag_enter = CEFDragHandler_onDragEnter
        on_draggable_regions_changed = CEFDragHandler_onDraggableRegionsChanged
    }
}


func CEFDragHandler_onDragEnter(ptr: UnsafeMutablePointer<cef_drag_handler_t>,
                                browser: UnsafeMutablePointer<cef_browser_t>,
                                dragData: UnsafeMutablePointer<cef_drag_data_t>,
                                mask: cef_drag_operations_mask_t) -> Int32 {
    guard let obj = CEFDragHandlerMarshaller.get(ptr) else {
        return 0
    }
    
    return obj.onDragEnter(CEFBrowser.fromCEF(browser)!,
                           dragData: CEFDragData.fromCEF(dragData)!,
                           operationMask: CEFDragOperationsMask.fromCEF(mask)) ? 1 : 0
}

func CEFDragHandler_onDraggableRegionsChanged(ptr: UnsafeMutablePointer<cef_drag_handler_t>,
                                              browser: UnsafeMutablePointer<cef_browser_t>,
                                              count: size_t,
                                              cefRegions: UnsafePointer<cef_draggable_region_t>) {
    guard let obj = CEFDragHandlerMarshaller.get(ptr) else {
        return
    }
    
    var regions = [CEFDraggableRegion]()
    for i in 0..<count {
        regions.append(CEFDraggableRegion.fromCEF(cefRegions.advancedBy(i).memory))
    }
    
    obj.onDraggableRegionsChanged(CEFBrowser.fromCEF(browser)!, regions: regions)
}

