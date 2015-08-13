//
//  CEFFindHandler.g.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 11..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

extension cef_find_handler_t: CEFObject {
}

typealias CEFindHandlerMarshaller = CEFMarshaller<CEFFindHandler, cef_find_handler_t>

extension CEFFindHandler {
    func toCEF() -> UnsafeMutablePointer<cef_find_handler_t> {
        return CEFindHandlerMarshaller.pass(self)
    }
}

extension cef_find_handler_t: CEFCallbackMarshalling {
    mutating func marshalCallbacks() {
        on_find_result = CEFFindHandler_onFindResult
    }
}


func CEFFindHandler_onFindResult(ptr: UnsafeMutablePointer<cef_find_handler_t>,
                                 browser: UnsafeMutablePointer<cef_browser_t>,
                                 identifier: Int32,
                                 count: Int32,
                                 rect: UnsafePointer<cef_rect_t>,
                                 currentIndex: Int32,
                                 isLastUpdate: Int32) {
    guard let obj = CEFindHandlerMarshaller.get(ptr) else {
        return
    }
    
    obj.onFindResult(CEFBrowser.fromCEF(browser)!,
                     identifier: identifier,
                     count: Int(count),
                     selectionRect: NSRect.fromCEF(rect.memory),
                     currentIndex: Int(currentIndex),
                     isLastUpdate: isLastUpdate != 0)
}
