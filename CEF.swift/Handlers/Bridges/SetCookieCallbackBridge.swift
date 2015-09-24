//
//  SetCookieCallbackBridge.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 24..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

/// Method that will be called upon completion. |success| will be true if the
/// cookie was set successfully.
public typealias SetCookieCallbackOnCompleteBlock = (success: Bool) -> Void

class SetCookieCallbackBridge: SetCookieCallback {
    let block: SetCookieCallbackOnCompleteBlock
    
    init(block: SetCookieCallbackOnCompleteBlock) {
        self.block = block
    }
    
    func onComplete(success: Bool) {
        block(success: success)
    }
}
