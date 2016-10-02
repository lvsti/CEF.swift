//
//  CEFDeleteCookiesCallbackBridge.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 24..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

/// Method that will be called upon completion. |num_deleted| will be the
/// number of cookies that were deleted or -1 if unknown.
public typealias CEFDeleteCookiesCallbackOnCompleteBlock = (_ deletedCount: Int?) -> Void

class CEFDeleteCookiesCallbackBridge: CEFDeleteCookiesCallback {
    let block: CEFDeleteCookiesCallbackOnCompleteBlock
    
    init(block: @escaping CEFDeleteCookiesCallbackOnCompleteBlock) {
        self.block = block
    }
    
    func onComplete(deletedCount: Int?) {
        block(deletedCount)
    }
}

