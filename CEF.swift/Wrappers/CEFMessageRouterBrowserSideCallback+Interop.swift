//
//  CEFMessageRouterBrowserSideCallback+Interop.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2019. 05. 22..
//  Copyright © 2019. Tamas Lustyik. All rights reserved.
//

import Foundation
import LibCEFWrapper

extension cef_message_router_browser_side_callback_t: CEFObject {}

/// Callback associated with a single pending asynchronous query. Execute the
/// Success or Failure method to send an asynchronous response to the
/// associated JavaScript handler. It is a runtime error to destroy a Callback
/// object associated with an uncanceled query without first executing one of
/// the callback methods. The methods of this class may be called on any
/// browser process thread.
/// CEF name: `CefMessageRouterBrowserSide::Callback`
public final class CEFMessageRouterBrowserSideCallback: CEFProxy<cef_message_router_browser_side_callback_t> {
    override init?(ptr: UnsafeMutablePointer<cef_message_router_browser_side_callback_t>?) {
        super.init(ptr: ptr)
    }
    
    static func fromCEF(_ ptr: UnsafeMutablePointer<cef_message_router_browser_side_callback_t>?) -> CEFMessageRouterBrowserSideCallback? {
        return CEFMessageRouterBrowserSideCallback(ptr: ptr)
    }
}
