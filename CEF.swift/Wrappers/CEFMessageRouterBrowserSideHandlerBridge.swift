//
//  CEFMessageRouterBrowserSideHandlerBridge.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2019. 05. 22..
//  Copyright © 2019. Tamas Lustyik. All rights reserved.
//

import Foundation

public typealias CEFMessageRouterBrowserSideHandlerOnQueryBlock = (
    _ browser: CEFBrowser,
    _ frame: CEFFrame,
    _ queryID: Int64,
    _ request: String,
    _ isPersistent: Bool,
    _ callback: CEFMessageRouterBrowserSideCallback) -> CEFMessageRouterBrowserSideHandlerOnQueryAction

public typealias CEFMessageRouterBrowserSideHandlerOnQueryCanceledBlock = (
    _ browser: CEFBrowser,
    _ frame: CEFFrame,
    _ queryID: Int64) -> Void

class CEFMessageRouterBrowserSideHandlerBridge: CEFMessageRouterBrowserSideHandler {
    let onQueryBlock: CEFMessageRouterBrowserSideHandlerOnQueryBlock
    let onQueryCanceledBlock: CEFMessageRouterBrowserSideHandlerOnQueryCanceledBlock
    
    init(onQuery: @escaping CEFMessageRouterBrowserSideHandlerOnQueryBlock,
         onQueryCanceled: @escaping CEFMessageRouterBrowserSideHandlerOnQueryCanceledBlock) {
        self.onQueryBlock = onQuery
        self.onQueryCanceledBlock = onQueryCanceled
    }
    
    func onQuery(browser: CEFBrowser,
                 frame: CEFFrame,
                 queryID: Int64,
                 request: String,
                 isPersistent: Bool,
                 callback: CEFMessageRouterBrowserSideCallback) -> CEFMessageRouterBrowserSideHandlerOnQueryAction {
        return onQueryBlock(browser, frame, queryID, request, isPersistent, callback)
    }
    
    func onQueryCanceled(browser: CEFBrowser,
                         frame: CEFFrame,
                         queryID: Int64) -> Void {
        onQueryCanceledBlock(browser, frame, queryID)
    }
}
