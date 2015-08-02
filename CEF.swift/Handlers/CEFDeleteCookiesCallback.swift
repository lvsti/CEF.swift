//
//  CEFDeleteCookiesCallback.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 02..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

public protocol CEFDeleteCookiesCallback {
    
    func onComplete(deletedCount: Int?)
    
}


public extension CEFDeleteCookiesCallback {
    
    func onComplete(deletedCount: Int?) {
    }
    
}
