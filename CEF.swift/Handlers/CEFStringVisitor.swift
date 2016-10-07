//
//  CEFStringVisitor.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 07. 29..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

/// Implement this interface to receive string values asynchronously.
/// CEF name: `CefStringVisitor`
public protocol CEFStringVisitor {

    /// Method that will be executed.
    /// CEF name: `Visit`
    func visit(string: String?)

}


public extension CEFStringVisitor {
    
    func visit(string: String?) {
    }
    
}
