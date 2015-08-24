//
//  CEFRunFileDialogCallbackBridge.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 24..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

public typealias CEFRunFileDialogCallbackOnFileDialogDismissedBlock = (filterIndex: Int, filePaths: [String]) -> ()

class CEFRunFileDialogCallbackBridge: CEFRunFileDialogCallback {
    let block: CEFRunFileDialogCallbackOnFileDialogDismissedBlock
    
    init(block: CEFRunFileDialogCallbackOnFileDialogDismissedBlock) {
        self.block = block
    }
    
    func onFileDialogDismissed(filterIndex: Int, filePaths: [String]) {
        block(filterIndex: filterIndex, filePaths: filePaths)
    }
}

