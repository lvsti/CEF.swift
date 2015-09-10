//
//  CEFPDFPrintCallbackBridge.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 09. 08..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

public typealias CEFPDFPrintCallbackOnPDFPrintFinishedBlock = (path: String, successfully: Bool) -> Void

class CEFPDFPrintCallbackBridge: CEFPDFPrintCallback {
    let block: CEFPDFPrintCallbackOnPDFPrintFinishedBlock
    
    init(block: CEFPDFPrintCallbackOnPDFPrintFinishedBlock) {
        self.block = block
    }
    
    func onPDFPrintFinishedForPath(path: String, successfully: Bool) {
        block(path: path, successfully: successfully)
    }
}

