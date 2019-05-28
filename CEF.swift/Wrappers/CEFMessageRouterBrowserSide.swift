//
//  CEFMessageRouterBrowserSide.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2019. 05. 22..
//  Copyright © 2019. Tamas Lustyik. All rights reserved.
//

import Foundation
import LibCEFWrapper


extension cef_message_router_browser_side_t: CEFObject {}


public protocol CEFMessageRouterBrowserSideHandlerToken {}

class CEFMessageRouterBrowserSideHandlerTokenImpl: CEFMessageRouterBrowserSideHandlerToken {
    let handlerStructPtr: UnsafeMutablePointer<cef_message_router_browser_side_handler_t>
    
    init(handler: CEFMessageRouterBrowserSideHandler) {
        handlerStructPtr = CEFMessageRouterBrowserSideHandlerMarshaller.pass(handler)
    }
    
    deinit {
        _ = CEFMessageRouterBrowserSideHandlerMarshaller.take(handlerStructPtr)
    }
}

/// Implements the browser side of query routing. The methods of this class may
/// be called on any browser process thread unless otherwise indicated.
/// CEF name: `CefMessageRouterBrowserSide`
public class CEFMessageRouterBrowserSide: CEFProxy<cef_message_router_browser_side_t> {

    /// Create a new router with the specified configuration.
    /// CEF name: `Create`
    public init?(config: CEFMessageRouterConfig) {
        var cefConfig = config.toCEF()
        let ptr = cef_message_router_browser_side_create(&cefConfig)
        super.init(ptr: ptr)
    }

    /// Add a new query handler. If |first| is true it will be added as the first
    /// handler, otherwise it will be added as the last handler. Returns true if
    /// the handler is added successfully or false if the handler has already been
    /// added. Must be called on the browser process UI thread. The Handler object
    /// must either outlive the router or be removed before deletion.
    /// CEF name: `AddHandler`
    public func addHandler(_ handler: CEFMessageRouterBrowserSideHandler, asFirst: Bool) -> CEFMessageRouterBrowserSideHandlerToken? {
        let impl = CEFMessageRouterBrowserSideHandlerTokenImpl(handler: handler)
        let result = cefObject.add_handler(cefObjectPtr, impl.handlerStructPtr, asFirst ? 1 : 0)
        return result != 0 ? impl : nil
    }

    /// Remove an existing query handler. Any pending queries associated with the
    /// handler will be canceled. Handler::OnQueryCanceled will be called and the
    /// associated JavaScript onFailure callback will be executed with an error
    /// code of -1. Returns true if the handler is removed successfully or false
    /// if the handler is not found. Must be called on the browser process UI
    /// thread.
    /// CEF name: `RemoveHandler`
    @discardableResult
    public func removeHandler(withToken token: CEFMessageRouterBrowserSideHandlerToken) -> Bool {
        guard let impl = token as? CEFMessageRouterBrowserSideHandlerTokenImpl else {
            return false
        }
        return cefObject.remove_handler(cefObjectPtr, impl.handlerStructPtr) != 0
    }
    
    /// Cancel all pending queries associated with either |browser| or |handler|.
    /// If both |browser| and |handler| are NULL all pending queries will be
    /// canceled. Handler::OnQueryCanceled will be called and the associated
    /// JavaScript onFailure callback will be executed in all cases with an error
    /// code of -1.
    /// CEF name: `CancelPending`
    public func cancelPending(browser: CEFBrowser, handler: CEFMessageRouterBrowserSideHandler) {
        cefObject.cancel_pending(cefObjectPtr, browser.toCEF(), handler.toCEF())
    }
    
    /// Returns the number of queries currently pending for the specified |browser|
    /// and/or |handler|. Either or both values may be empty. Must be called on the
    /// browser process UI thread.
    /// CEF name: `GetPendingCount`
    public func pendingCount(browser: CEFBrowser?, handler: CEFMessageRouterBrowserSideHandler?) -> Int {
        return Int(cefObject.get_pending_count(cefObjectPtr, browser?.toCEF(), handler?.toCEF()))
    }
    
    // The below methods should be called from other CEF handlers. They must be
    // called exactly as documented for the router to function correctly.
    
    /// Call from CefLifeSpanHandler::OnBeforeClose. Any pending queries associated
    /// with |browser| will be canceled and Handler::OnQueryCanceled will be
    /// called. No JavaScript callbacks will be executed since this indicates
    /// destruction of the browser.
    /// CEF name: `OnBeforeClose`
    public func onBeforeClose(browser: CEFBrowser) {
        cefObject.on_before_close(cefObjectPtr, browser.toCEF())
    }
    
    /// Call from CefRequestHandler::OnRenderProcessTerminated. Any pending queries
    /// associated with |browser| will be canceled and Handler::OnQueryCanceled
    /// will be called. No JavaScript callbacks will be executed since this
    /// indicates destruction of the context.
    /// CEF name: `OnRenderProcessTerminated`
    public func onRenderProcessTerminated(browser: CEFBrowser) {
        cefObject.on_render_process_terminated(cefObjectPtr, browser.toCEF())
    }
    
    /// Call from CefRequestHandler::OnBeforeBrowse only if the navigation is
    /// allowed to proceed. If |frame| is the main frame then any pending queries
    /// associated with |browser| will be canceled and Handler::OnQueryCanceled
    /// will be called. No JavaScript callbacks will be executed since this
    /// indicates destruction of the context.
    /// CEF name: `OnBeforeBrowse`
    public func onBeforeBrowse(browser: CEFBrowser, frame: CEFFrame) {
        cefObject.on_before_browse(cefObjectPtr, browser.toCEF(), frame.toCEF())
    }
    
    /// Call from CefClient::OnProcessMessageReceived. Returns true if the message
    /// is handled by this router or false otherwise.
    /// CEF name: `OnProcessMessageReceived`
    public func onProcessMessageReceived(browser: CEFBrowser,
                                         processID: CEFProcessID,
                                         message: CEFProcessMessage) -> CEFOnProcessMessageReceivedAction {
        let retval = cefObject.on_process_message_received(cefObjectPtr,
                                                           browser.toCEF(),
                                                           processID.toCEF(),
                                                           message.toCEF())
        return retval != 0 ? .consume : .passThrough
        
    }
}

public extension CEFMessageRouterBrowserSide {
    /// Add a new query handler. If |first| is true it will be added as the first
    /// handler, otherwise it will be added as the last handler. Returns true if
    /// the handler is added successfully or false if the handler has already been
    /// added. Must be called on the browser process UI thread. The Handler object
    /// must either outlive the router or be removed before deletion.
    /// CEF name: `AddHandler`
    public func addHandler(asFirst: Bool,
                           onQuery: @escaping CEFMessageRouterBrowserSideHandlerOnQueryBlock,
                           onQueryCanceled: @escaping CEFMessageRouterBrowserSideHandlerOnQueryCanceledBlock) -> CEFMessageRouterBrowserSideHandlerToken? {
        let handler = CEFMessageRouterBrowserSideHandlerBridge(onQuery: onQuery, onQueryCanceled: onQueryCanceled)
        return addHandler(handler, asFirst: asFirst)
    }

}
