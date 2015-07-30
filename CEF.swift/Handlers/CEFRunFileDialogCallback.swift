//
//  CEFRunFileDialogCallback.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 07. 25..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

public protocol CEFRunFileDialogCallback {

    func onFileDialogDismissed(filterIndex: Int, filePaths: [String])

}


public extension CEFRunFileDialogCallback {
    
    public func onFileDialogDismissed(filterIndex: Int, filePaths: [String]) {
    }
    
}

