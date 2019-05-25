//
//  CEFMessageRouterBrowserSideHandler+Interop.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2019. 05. 22..
//  Copyright © 2019. Tamas Lustyik. All rights reserved.
//

import Foundation
import LibCEFWrapper

extension cef_message_router_browser_side_handler_t: CEFObject {}

typealias CEFMessageRouterBrowserSideHandlerMarshaller = CEFMarshaller<CEFMessageRouterBrowserSideHandler, cef_message_router_browser_side_handler_t>

extension CEFMessageRouterBrowserSideHandler {
    func toCEF() -> UnsafeMutablePointer<cef_message_router_browser_side_handler_t> {
        return CEFMessageRouterBrowserSideHandlerMarshaller.pass(self)
    }
}

extension cef_message_router_browser_side_handler_t: CEFCallbackMarshalling {
    mutating func marshalCallbacks() {
        on_query = CEFMessageRouterBrowserSideHandler_on_query
        on_query_canceled = CEFMessageRouterBrowserSideHandler_on_query_canceled
    }
}

func CEFMessageRouterBrowserSideHandler_on_query(ptr: UnsafeMutablePointer<cef_message_router_browser_side_handler_t>?,
                                                 browser: UnsafeMutablePointer<cef_browser_t>?,
                                                 frame: UnsafeMutablePointer<cef_frame_t>?,
                                                 queryID: Int64,
                                                 request: UnsafePointer<cef_string_t>?,
                                                 isPersistent: Int32,
                                                 callback: UnsafeMutablePointer<cef_message_router_browser_side_callback_t>?) -> Int32 {
    guard let obj = CEFMessageRouterBrowserSideHandlerMarshaller.get(ptr) else {
        return 0
    }
    
    let action = obj.onQuery(browser: CEFBrowser.fromCEF(browser)!,
                             frame: CEFFrame.fromCEF(frame)!,
                             queryID: queryID,
                             request: CEFStringToSwiftString(request!.pointee),
                             isPersistent: isPersistent != 0,
                             callback: CEFMessageRouterBrowserSideCallback.fromCEF(callback)!)
    
    return action == .consume ? 1 : 0
}

func CEFMessageRouterBrowserSideHandler_on_query_canceled(ptr: UnsafeMutablePointer<cef_message_router_browser_side_handler_t>?,
                                                          browser: UnsafeMutablePointer<cef_browser_t>?,
                                                          frame: UnsafeMutablePointer<cef_frame_t>?,
                                                          queryID: Int64) {
    guard let obj = CEFMessageRouterBrowserSideHandlerMarshaller.get(ptr) else {
        return
    }

    obj.onQueryCanceled(browser: CEFBrowser.fromCEF(browser)!,
                        frame: CEFFrame.fromCEF(frame)!,
                        queryID: queryID)
}
