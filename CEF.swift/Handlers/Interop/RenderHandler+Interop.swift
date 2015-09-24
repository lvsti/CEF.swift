//
//  RenderHandler.g.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 11..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

func RenderHandler_get_root_screen_rect(ptr: UnsafeMutablePointer<cef_render_handler_t>,
                                        browser: UnsafeMutablePointer<cef_browser_t>,
                                        cefRect: UnsafeMutablePointer<cef_rect_t>) -> Int32 {
    guard let obj = RenderHandlerMarshaller.get(ptr) else {
        return 0
    }

    let rect = obj.rootScreenRectForBrowser(Browser.fromCEF(browser)!)
    if let rect = rect {
        cefRect.memory = rect.toCEF()
    }
    
    return rect != nil ? 1 : 0
}

func RenderHandler_get_view_rect(ptr: UnsafeMutablePointer<cef_render_handler_t>,
                                 browser: UnsafeMutablePointer<cef_browser_t>,
                                 cefRect: UnsafeMutablePointer<cef_rect_t>) -> Int32 {
    guard let obj = RenderHandlerMarshaller.get(ptr) else {
        return 0
    }

    let rect = obj.viewRectForBrowser(Browser.fromCEF(browser)!)
    if let rect = rect {
        cefRect.memory = rect.toCEF()
    }
    
    return rect != nil ? 1 : 0
}

func RenderHandler_get_screen_point(ptr: UnsafeMutablePointer<cef_render_handler_t>,
                                    browser: UnsafeMutablePointer<cef_browser_t>,
                                    viewX: Int32,
                                    viewY: Int32,
                                    screenX: UnsafeMutablePointer<Int32>,
                                    screenY: UnsafeMutablePointer<Int32>) -> Int32 {
    guard let obj = RenderHandlerMarshaller.get(ptr) else {
        return 0
    }
    
    let point = obj.screenPointForBrowser(Browser.fromCEF(browser)!,
                                          viewPoint: NSPoint(x: Int(viewX), y: Int(viewY)))
    if let point = point {
        screenX.memory = Int32(point.x)
        screenY.memory = Int32(point.y)
    }
    
    return point != nil ? 1 : 0
}

func RenderHandler_get_screen_info(ptr: UnsafeMutablePointer<cef_render_handler_t>,
                                   browser: UnsafeMutablePointer<cef_browser_t>,
                                   cefInfo: UnsafeMutablePointer<cef_screen_info_t>) -> Int32 {
    guard let obj = RenderHandlerMarshaller.get(ptr) else {
        return 0
    }
    
    let info = obj.screenInfoForBrowser(Browser.fromCEF(browser)!)
    if let info = info {
        cefInfo.memory = info.toCEF()
    }
    
    return info != nil ? 1 : 0
}

func RenderHandler_on_popup_show(ptr: UnsafeMutablePointer<cef_render_handler_t>,
                                 browser: UnsafeMutablePointer<cef_browser_t>,
                                 showing: Int32) {
    guard let obj = RenderHandlerMarshaller.get(ptr) else {
        return
    }
    
    obj.onPopupShow(Browser.fromCEF(browser)!, showing: showing != 0)
}

func RenderHandler_on_popup_size(ptr: UnsafeMutablePointer<cef_render_handler_t>,
                                 browser: UnsafeMutablePointer<cef_browser_t>,
                                 rect: UnsafePointer<cef_rect_t>) {
    guard let obj = RenderHandlerMarshaller.get(ptr) else {
        return
    }
    
    obj.onPopupSize(Browser.fromCEF(browser)!, rect: NSRect.fromCEF(rect.memory))
}

func RenderHandler_on_paint(ptr: UnsafeMutablePointer<cef_render_handler_t>,
                            browser: UnsafeMutablePointer<cef_browser_t>,
                            type: cef_paint_element_type_t,
                            rectCount: size_t,
                            cefRects: UnsafePointer<cef_rect_t>,
                            buffer: UnsafePointer<Void>,
                            width: Int32,
                            height: Int32) {
    guard let obj = RenderHandlerMarshaller.get(ptr) else {
        return
    }
    
    var rects = [NSRect]()
    for i in 0..<rectCount {
        rects.append(NSRect.fromCEF(cefRects.advancedBy(i).memory))
    }
    
    obj.onPaint(Browser.fromCEF(browser)!,
                type: PaintElementType.fromCEF(type),
                dirtyRects: rects,
                buffer: buffer,
                size: NSSize(width: Int(width), height: Int(height)))
}

func RenderHandler_on_cursor_change(ptr: UnsafeMutablePointer<cef_render_handler_t>,
                                    browser: UnsafeMutablePointer<cef_browser_t>,
                                    cursor: UnsafeMutablePointer<Void>,
                                    type: cef_cursor_type_t,
                                    info: UnsafePointer<cef_cursor_info_t>) {
    guard let obj = RenderHandlerMarshaller.get(ptr) else {
        return
    }
    
    obj.onCursorChange(Browser.fromCEF(browser)!,
                       cursor: Unmanaged<CursorHandle>.fromOpaque(COpaquePointer(cursor)).takeUnretainedValue(),
                       type: CursorType.fromCEF(type),
                       cursorInfo: info != nil ? CursorInfo.fromCEF(info.memory) : nil)
}

func RenderHandler_start_dragging(ptr: UnsafeMutablePointer<cef_render_handler_t>,
                                  browser: UnsafeMutablePointer<cef_browser_t>,
                                  dragData: UnsafeMutablePointer<cef_drag_data_t>,
                                  opMask: cef_drag_operations_mask_t,
                                  x: Int32,
                                  y: Int32) -> Int32 {
    guard let obj = RenderHandlerMarshaller.get(ptr) else {
        return 0
    }
    
    return obj.onStartDragging(Browser.fromCEF(browser)!,
                               dragData: DragData.fromCEF(dragData)!,
                               operationMask: DragOperationsMask.fromCEF(opMask),
                               location: NSPoint(x: Int(x), y: Int(y))) ? 1 : 0
}

func RenderHandler_update_drag_cursor(ptr: UnsafeMutablePointer<cef_render_handler_t>,
                                      browser: UnsafeMutablePointer<cef_browser_t>,
                                      opMask: cef_drag_operations_mask_t) {
    guard let obj = RenderHandlerMarshaller.get(ptr) else {
        return
    }
    
    obj.onUpdateDragCursor(Browser.fromCEF(browser)!, operation: DragOperationsMask.fromCEF(opMask))
}

func RenderHandler_on_scroll_offset_changed(ptr: UnsafeMutablePointer<cef_render_handler_t>,
                                            browser: UnsafeMutablePointer<cef_browser_t>,
                                            x: Double,
                                            y: Double) {
    guard let obj = RenderHandlerMarshaller.get(ptr) else {
        return
    }
    
    obj.onScrollOffsetChanged(Browser.fromCEF(browser)!, offset: NSPoint(x: x, y: y))
}

