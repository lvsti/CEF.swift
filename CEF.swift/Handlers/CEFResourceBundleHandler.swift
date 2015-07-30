//
//  CEFResourceBundleHandler.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 07. 15..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

public class CEFResourceBundleHandler: CEFHandler {
    
    public override init() {
        super.init()
    }
    
    public func getLocalizedString(stringID: Int) -> String? {
        return nil
    }
    
    public func getDataResource(resourceID: Int) -> (dataBufferPtr: UnsafeMutablePointer<Void>, dataSize: size_t)? {
        return nil
    }
    
}

