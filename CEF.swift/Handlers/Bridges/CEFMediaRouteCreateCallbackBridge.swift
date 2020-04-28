//
//  CEFMediaRouteCreateCallbackBridge.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2020. 04. 28..
//  Copyright © 2020. Tamas Lustyik. All rights reserved.
//

import Foundation

/// Callback interface for CefMediaRouter::CreateRoute. The methods of this
/// class will be called on the browser process UI thread.
public typealias CEFMediaRouteCreateCallbackOnMediaRouteCreateFinishedBlock =
    (_ result: CEFMediaRouteCreateResult, _ error: String?, _ route: CEFMediaRoute?) -> Void

class CEFMediaRouteCreateCallbackBridge: CEFMediaRouteCreateCallback {
    let block: CEFMediaRouteCreateCallbackOnMediaRouteCreateFinishedBlock
    
    init(block: @escaping CEFMediaRouteCreateCallbackOnMediaRouteCreateFinishedBlock) {
        self.block = block
    }
    
    func onMediaRouteCreateFinished(result: CEFMediaRouteCreateResult, error: String?, route: CEFMediaRoute?) {
        block(result, error, route)
    }
}
