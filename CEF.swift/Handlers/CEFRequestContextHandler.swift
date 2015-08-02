//
//  CEFRequestContextHandler.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 02..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

public protocol CEFRequestContextHandler {
    
    func getCookieManager() -> CEFCookieManager?
    
}


public extension CEFRequestContextHandler {
    
    public func getCookieManager() -> CEFCookieManager? {
        return nil
    }
    
}

