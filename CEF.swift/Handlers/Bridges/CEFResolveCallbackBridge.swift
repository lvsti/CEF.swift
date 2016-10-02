//
//  CEFResolveCallbackBridge.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2016. 04. 03..
//  Copyright © 2016. Tamas Lustyik. All rights reserved.
//

import Foundation

/// Called after the ResolveHost request has completed. |result| will be the
/// result code. |resolved_ips| will be the list of resolved IP addresses or
/// empty if the resolution failed.
public typealias CEFResolveCallbackOnResolveCompletedBlock = (_ results: [String]?, _ errorCode: CEFErrorCode) -> Void

class CEFResolveCallbackBridge: CEFResolveCallback {
    let block: CEFResolveCallbackOnResolveCompletedBlock
    
    init(block: @escaping CEFResolveCallbackOnResolveCompletedBlock) {
        self.block = block
    }
    
    func onResolveCompleted(results: [String]?, errorCode: CEFErrorCode) {
        block(results, errorCode)
    }
}
