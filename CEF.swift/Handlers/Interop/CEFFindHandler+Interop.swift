//
//  CEFFindHandler.g.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 11..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

func CEFFindHandler_on_find_result(ptr: UnsafeMutablePointer<cef_find_handler_t>,
                                   browser: UnsafeMutablePointer<cef_browser_t>,
                                   identifier: Int32,
                                   count: Int32,
                                   rect: UnsafePointer<cef_rect_t>,
                                   currentIndex: Int32,
                                   isLastUpdate: Int32) {
    guard let obj = CEFFindHandlerMarshaller.get(ptr) else {
        return
    }
    
    obj.onFindResult(browser: CEFBrowser.fromCEF(browser)!,
                     identifier: identifier,
                     count: Int(count),
                     selectionRect: NSRect.fromCEF(rect.pointee),
                     currentIndex: Int(currentIndex),
                     isLastUpdate: isLastUpdate != 0)
}
