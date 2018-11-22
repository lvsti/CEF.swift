//
//  CEFMainArgs.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 07. 13..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

/// Structure representing CefExecuteProcess arguments.
/// CEF name: `cef_main_args_t`
public struct CEFMainArgs {
    /// CEF name: `argv`
    public let arguments: [String]
    
    public init(arguments: [String]) {
        self.arguments = arguments
    }
}


extension CEFMainArgs {
    func toCEF() -> cef_main_args_t {
        return cef_main_args_t(argc: Int32(arguments.count),
                               argv: CEFArgVFromArguments(arguments))
    }
}

extension cef_main_args_t {
    mutating func clear() {
        if argv == nil {
            return
        }
        
        for i in 0..<Int(argc) {
            if let cstr = argv.advanced(by: i).pointee {
                cstr.deallocate()
            }
        }
        
        argv.deallocate()
    }
}
