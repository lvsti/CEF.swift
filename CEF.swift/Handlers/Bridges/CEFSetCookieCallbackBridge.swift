//
//  CEFSetCookieCallbackBridge.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 24..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

public typealias CEFSetCookieCallbackOnCompleteBlock = (success: Bool) -> Void

class CEFSetCookieCallbackBridge: CEFSetCookieCallback {
    let block: CEFSetCookieCallbackOnCompleteBlock
    
    init(block: CEFSetCookieCallbackOnCompleteBlock) {
        self.block = block
    }
    
    func onComplete(success: Bool) {
        block(success: success)
    }
}
