//
//  CEFSchemeHandlerFactory.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 02..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

public protocol CEFSchemeHandlerFactory {
    
    func create(browser: CEFBrowser?, frame: CEFFrame?, scheme: String, request: CEFRequest) -> CEFResourceHandler?
    
}

public extension CEFSchemeHandlerFactory {
    
    func create(browser: CEFBrowser?, frame: CEFFrame?, scheme: String, request: CEFRequest) -> CEFResourceHandler? {
        return nil
    }
    
}