//
//  CEFRenderHandler.g.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 11..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

extension cef_render_handler_t: CEFObject {
}

typealias CEFRenderHandlerMarshaller = CEFMarshaller<CEFRenderHandler, cef_render_handler_t>

extension CEFRenderHandler {
    func toCEF() -> UnsafeMutablePointer<cef_render_handler_t> {
        return CEFRenderHandlerMarshaller.pass(self)
    }
}

extension cef_render_handler_t: CEFCallbackMarshalling {
    mutating func marshalCallbacks() {
        get_root_screen_rect = CEFRenderHandler_getRootScreenRect
        get_view_rect = CEFRenderHandler_getViewRect
        get_screen_point = CEFRenderHandler_getScreenPoint
        get_screen_info = CEFRenderHandler_getScreenInfo
        on_popup_show = CEFRenderHandler_onPopupShow
        on_popup_size = CEFRenderHandler_onPopupSize
        on_paint = CEFRenderHandler_onPaint
        on_cursor_change = CEFRenderHandler_onCursorChange
        start_dragging = CEFRenderHandler_startDragging
        update_drag_cursor = CEFRenderHandler_updateDragCursor
        on_scroll_offset_changed = CEFRenderHandler_onScrollOffsetChanged
    }
}

func CEFRenderHandler_getRootScreenRect(ptr: UnsafeMutablePointer<cef_render_handler_t>,
                                        browser: UnsafeMutablePointer<cef_browser_t>,
                                        cefRect: UnsafeMutablePointer<cef_rect_t>) -> Int32 {
    guard let obj = CEFRenderHandlerMarshaller.get(ptr) else {
        return 0
    }
    
    var rect = NSRect()
    defer { cefRect.memory = rect.toCEF() }
    
    return obj.getRootScreenRect(CEFBrowser.fromCEF(browser)!, rect: &rect) ? 1 : 0
}

func CEFRenderHandler_getViewRect(ptr: UnsafeMutablePointer<cef_render_handler_t>,
                                  browser: UnsafeMutablePointer<cef_browser_t>,
                                  cefRect: UnsafeMutablePointer<cef_rect_t>) -> Int32 {
    guard let obj = CEFRenderHandlerMarshaller.get(ptr) else {
        return 0
    }

    var rect = NSRect()
    defer { cefRect.memory = rect.toCEF() }
    
    return obj.getRootScreenRect(CEFBrowser.fromCEF(browser)!, rect: &rect) ? 1 : 0
}

func CEFRenderHandler_getScreenPoint(ptr: UnsafeMutablePointer<cef_render_handler_t>,
                                     browser: UnsafeMutablePointer<cef_browser_t>,
                                     viewX: Int32,
                                     viewY: Int32,
                                     screenX: UnsafeMutablePointer<Int32>,
                                     screenY: UnsafeMutablePointer<Int32>) -> Int32 {
    guard let obj = CEFRenderHandlerMarshaller.get(ptr) else {
        return 0
    }
    
    var screenPoint = NSPoint()
    defer {
        screenX.memory = Int32(screenPoint.x)
        screenY.memory = Int32(screenPoint.y)
    }
    
    return obj.getScreenPoint(CEFBrowser.fromCEF(browser)!,
                              viewPoint: NSPoint(x: Int(viewX), y: Int(viewY)),
                              screenPoint: &screenPoint) ? 1 : 0
}

func CEFRenderHandler_getScreenInfo(ptr: UnsafeMutablePointer<cef_render_handler_t>,
                                    browser: UnsafeMutablePointer<cef_browser_t>,
                                    cefInfo: UnsafeMutablePointer<cef_screen_info_t>) -> Int32 {
    guard let obj = CEFRenderHandlerMarshaller.get(ptr) else {
        return 0
    }
    
    var info = CEFScreenInfo.fromCEF(cefInfo.memory)
    defer { cefInfo.memory = info.toCEF() }
    
    return obj.getScreenInfo(CEFBrowser.fromCEF(browser)!, screenInfo: &info) ? 1 : 0
}

func CEFRenderHandler_onPopupShow(ptr: UnsafeMutablePointer<cef_render_handler_t>,
                                  browser: UnsafeMutablePointer<cef_browser_t>,
                                  showing: Int32) {
    guard let obj = CEFRenderHandlerMarshaller.get(ptr) else {
        return
    }
    
    obj.onPopupShow(CEFBrowser.fromCEF(browser)!, showing: showing != 0)
}

func CEFRenderHandler_onPopupSize(ptr: UnsafeMutablePointer<cef_render_handler_t>,
                                  browser: UnsafeMutablePointer<cef_browser_t>,
                                  rect: UnsafePointer<cef_rect_t>) {
    guard let obj = CEFRenderHandlerMarshaller.get(ptr) else {
        return
    }
    
    obj.onPopupSize(CEFBrowser.fromCEF(browser)!, rect: NSRect.fromCEF(rect.memory))
}

func CEFRenderHandler_onPaint(ptr: UnsafeMutablePointer<cef_render_handler_t>,
                              browser: UnsafeMutablePointer<cef_browser_t>,
                              type: cef_paint_element_type_t,
                              rectCount: size_t,
                              cefRects: UnsafePointer<cef_rect_t>,
                              buffer: UnsafePointer<Void>,
                              width: Int32,
                              height: Int32) {
    guard let obj = CEFRenderHandlerMarshaller.get(ptr) else {
        return
    }
    
    var rects = [NSRect]()
    for i in 0..<rectCount {
        rects.append(NSRect.fromCEF(cefRects.advancedBy(i).memory))
    }
    
    obj.onPaint(CEFBrowser.fromCEF(browser)!,
        type: CEFPaintElementType.fromCEF(type),
        dirtyRects: rects,
        buffer: buffer,
        size: NSSize(width: Int(width), height: Int(height)))
}

func CEFRenderHandler_onCursorChange(ptr: UnsafeMutablePointer<cef_render_handler_t>,
                                     browser: UnsafeMutablePointer<cef_browser_t>,
                                     cursor: UnsafeMutablePointer<Void>,
                                     type: cef_cursor_type_t,
                                     info: UnsafePointer<cef_cursor_info_t>) {
    guard let obj = CEFRenderHandlerMarshaller.get(ptr) else {
        return
    }
    
    obj.onCursorChange(CEFBrowser.fromCEF(browser)!,
        cursor: Unmanaged<CEFCursorHandle>.fromOpaque(COpaquePointer(cursor)).takeUnretainedValue(),
        type: CEFCursorType.fromCEF(type),
        cursorInfo: info != nil ? CEFCursorInfo.fromCEF(info.memory) : nil)
}

func CEFRenderHandler_startDragging(ptr: UnsafeMutablePointer<cef_render_handler_t>,
                                    browser: UnsafeMutablePointer<cef_browser_t>,
                                    dragData: UnsafeMutablePointer<cef_drag_data_t>,
                                    opMask: cef_drag_operations_mask_t,
                                    x: Int32,
                                    y: Int32) -> Int32 {
    guard let obj = CEFRenderHandlerMarshaller.get(ptr) else {
        return 0
    }
    
    return obj.startDragging(CEFBrowser.fromCEF(browser)!,
        dragData: CEFDragData.fromCEF(dragData)!,
        operationMask: CEFDragOperationsMask.fromCEF(opMask),
        location: NSPoint(x: Int(x), y: Int(y))) ? 1 : 0
}

func CEFRenderHandler_updateDragCursor(ptr: UnsafeMutablePointer<cef_render_handler_t>,
                                       browser: UnsafeMutablePointer<cef_browser_t>,
                                       opMask: cef_drag_operations_mask_t) {
    guard let obj = CEFRenderHandlerMarshaller.get(ptr) else {
        return
    }
    
    obj.updateDragCursor(CEFBrowser.fromCEF(browser)!, operation: CEFDragOperationsMask.fromCEF(opMask))
}

func CEFRenderHandler_onScrollOffsetChanged(ptr: UnsafeMutablePointer<cef_render_handler_t>,
                                            browser: UnsafeMutablePointer<cef_browser_t>,
                                            x: Double,
                                            y: Double) {
    guard let obj = CEFRenderHandlerMarshaller.get(ptr) else {
        return
    }
    
    obj.onScrollOffsetChanged(CEFBrowser.fromCEF(browser)!, offset: NSPoint(x: x, y: y))
}

