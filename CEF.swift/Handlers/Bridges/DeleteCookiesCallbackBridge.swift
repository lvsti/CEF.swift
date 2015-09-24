//
//  DeleteCookiesCallbackBridge.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 24..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

/// Method that will be called upon completion. |num_deleted| will be the
/// number of cookies that were deleted or -1 if unknown.
public typealias DeleteCookiesCallbackOnCompleteBlock = (deletedCount: Int?) -> Void

class DeleteCookiesCallbackBridge: DeleteCookiesCallback {
    let block: DeleteCookiesCallbackOnCompleteBlock
    
    init(block: DeleteCookiesCallbackOnCompleteBlock) {
        self.block = block
    }
    
    func onComplete(deletedCount: Int?) {
        block(deletedCount: deletedCount)
    }
}

