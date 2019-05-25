//
//  CEFMessageRouterBrowserSideHandler.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2019. 05. 22..
//  Copyright © 2019. Tamas Lustyik. All rights reserved.
//

import Foundation

public enum CEFMessageRouterBrowserSideHandlerOnQueryAction {
    case consume
    case passThrough
}

/// Implement this interface to handle queries. All methods will be executed on
/// the browser process UI thread.
/// CEF name: `CefMessageRouterBrowserSide::Handler`
public protocol CEFMessageRouterBrowserSideHandler {
    /// Executed when a new query is received. |query_id| uniquely identifies the
    /// query for the life span of the router. Return true to handle the query
    /// or false to propagate the query to other registered handlers, if any. If
    /// no handlers return true from this method then the query will be
    /// automatically canceled with an error code of -1 delivered to the
    /// JavaScript onFailure callback. If this method returns true then a
    /// Callback method must be executed either in this method or asynchronously
    /// to complete the query.
    /// CEF name: `on_query`
    func onQuery(browser: CEFBrowser,
                 frame: CEFFrame,
                 queryID: Int64,
                 request: String,
                 isPersistent: Bool,
                 callback: CEFMessageRouterBrowserSideCallback) -> CEFMessageRouterBrowserSideHandlerOnQueryAction

    /// Executed when a query has been canceled either explicitly using the
    /// JavaScript cancel function or implicitly due to browser destruction,
    /// navigation or renderer process termination. It will only be called for
    /// the single handler that returned true from OnQuery for the same
    /// |query_id|. No references to the associated Callback object should be
    /// kept after this method is called, nor should any Callback methods be
    /// executed.
    /// CEF name: `on_query_canceled`
    func onQueryCanceled(browser: CEFBrowser,
                         frame: CEFFrame,
                         queryID: Int64) -> Void
}

public extension CEFMessageRouterBrowserSideHandler {
    func onQuery(browser: CEFBrowser,
                 frame: CEFFrame,
                 queryID: Int64,
                 request: String,
                 isPersistent: Bool,
                 callback: CEFMessageRouterBrowserSideCallback) -> CEFMessageRouterBrowserSideHandlerOnQueryAction {
        return .passThrough
    }
    
    func onQueryCanceled(browser: CEFBrowser,
                         frame: CEFFrame,
                         queryID: Int64) -> Void {
    }
}
