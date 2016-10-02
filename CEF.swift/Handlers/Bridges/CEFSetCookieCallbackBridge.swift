//
//  CEFSetCookieCallbackBridge.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 24..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

/// Method that will be called upon completion. |success| will be true if the
/// cookie was set successfully.
public typealias CEFSetCookieCallbackOnCompleteBlock = (_ success: Bool) -> Void

class CEFSetCookieCallbackBridge: CEFSetCookieCallback {
    let block: CEFSetCookieCallbackOnCompleteBlock
    
    init(block: @escaping CEFSetCookieCallbackOnCompleteBlock) {
        self.block = block
    }
    
    func onComplete(success: Bool) {
        block(success)
    }
}
