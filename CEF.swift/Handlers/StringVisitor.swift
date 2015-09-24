//
//  StringVisitor.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 07. 29..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

/// Implement this interface to receive string values asynchronously.
public protocol StringVisitor {

    /// Method that will be executed.
    func visit(string: String?)

}


public extension StringVisitor {
    
    func visit(string: String?) {
    }
    
}
