//
//  CEFStringVisitor.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 07. 29..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

public protocol CEFStringVisitor {

    func visit(string: String)

}


public extension CEFStringVisitor {
    
    func visit(string: String) {
    }
    
}
