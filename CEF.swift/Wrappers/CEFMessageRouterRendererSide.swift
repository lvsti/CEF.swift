//
//  CEFMessageRouterRendererSide.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2019. 05. 06..
//  Copyright © 2019. Tamas Lustyik. All rights reserved.
//

import Foundation
import LibCEFWrapper

extension cef_message_router_renderer_side_t: CEFObject {}

/// Implements the renderer side of query routing. The methods of this class must
/// be called on the render process main thread.
/// CEF name: `CefMessageRouterRendererSide`
public class CEFMessageRouterRendererSide: CEFProxy<cef_message_router_renderer_side_t> {
    
    /// Create a new router with the specified configuration.
    /// CEF name: `Create`
    public init?(config: CEFMessageRouterConfig) {
        var cefConfig = config.toCEF()
        let ptr = cef_message_router_renderer_side_create(&cefConfig)
        super.init(ptr: ptr)
    }
    
    /// Returns the number of queries currently pending for the specified |browser|
    /// and/or |context|. Either or both values may be empty.
    /// CEF name: `GetPendingCount`
    public func pendingQueryCount(browser: CEFBrowser, context: CEFV8Context) -> Int {
        return Int(cefObject.get_pending_count(cefObjectPtr, browser.toCEF(), context.toCEF()))
    }
    
    // The below methods should be called from other CEF handlers. They must be
    // called exactly as documented for the router to function correctly.
    
    /// Call from CefRenderProcessHandler::OnContextCreated. Registers the
    /// JavaScripts functions with the new context.
    /// CEF name: `OnContextCreated`
    public func onContextCreated(browser: CEFBrowser, frame: CEFFrame, context: CEFV8Context) {
        cefObject.on_context_created(cefObjectPtr, browser.toCEF(), frame.toCEF(), context.toCEF())
    }
    
    /// Call from CefRenderProcessHandler::OnContextReleased. Any pending queries
    /// associated with the released context will be canceled and
    /// Handler::OnQueryCanceled will be called in the browser process.
    /// CEF name: `OnContextReleased`
    public func onContextReleased(browser: CEFBrowser, frame: CEFFrame, context: CEFV8Context) {
        cefObject.on_context_released(cefObjectPtr, browser.toCEF(), frame.toCEF(), context.toCEF())
    }
    
    /// Call from CefRenderProcessHandler::OnProcessMessageReceived. Returns true
    /// if the message is handled by this router or false otherwise.
    /// CEF name: `OnProcessMessageReceived`
    public func onProcessMessageReceived(browser: CEFBrowser, processID: CEFProcessID, message: CEFProcessMessage) -> CEFOnProcessMessageReceivedAction {
        let retval = cefObject.on_process_message_received(cefObjectPtr, browser.toCEF(),
                                                           cef_process_id_t(rawValue: UInt32(processID.rawValue)),
                                                           message.toCEF())
        
        return retval != 0 ? .consume : .passThrough
    }
    
}
