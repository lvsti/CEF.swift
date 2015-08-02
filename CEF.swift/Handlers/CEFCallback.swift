//
//  CEFCallback.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 02..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

public protocol CEFCallback {
    
    func doContinue()
    func cancel()
    
}

public extension CEFCallback {

    func doContinue() {
    }
    
    func cancel() {
    }

}

