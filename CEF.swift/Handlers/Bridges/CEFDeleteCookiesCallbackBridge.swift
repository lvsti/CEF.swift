//
//  CEFDeleteCookiesCallbackBridge.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 24..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

public typealias CEFDeleteCookiesCallbackOnCompleteBlock = (deletedCount: Int?) -> ()

class CEFDeleteCookiesCallbackBridge: CEFDeleteCookiesCallback {
    let block: CEFDeleteCookiesCallbackOnCompleteBlock
    
    init(block: CEFDeleteCookiesCallbackOnCompleteBlock) {
        self.block = block
    }
    
    func onComplete(deletedCount: Int?) {
        block(deletedCount: deletedCount)
    }
}

