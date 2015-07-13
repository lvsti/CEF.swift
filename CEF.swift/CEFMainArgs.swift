//
//  CEFMainArgs.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 07. 13..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

typealias CEFArgV = UnsafeMutablePointer<UnsafePointer<Int8>>
typealias CEFMutableArgV = UnsafeMutablePointer<UnsafeMutablePointer<Int8>>

class CEFMainArgs: CEFStruct<cef_main_args_t> {
    var arguments: [String] {
        didSet {
            self.cefStruct = cef_main_args_t(argc: Int32(arguments.count),
                                             argv: CEFMutableArgV(CEFArgVFromArguments(arguments)))
        }
    }
    
    init(arguments: [String]) {
        super.init(cefStruct: cef_main_args_t())
        self.arguments = arguments
    }
}

func CEFArgVFromArguments(arguments: [String]) -> CEFArgV {
    let argv = CEFArgV.alloc(arguments.count)
    let utf8Strings = arguments.map { NSString(string: $0).UTF8String }
    
    for i in 0..<arguments.count {
        argv.advancedBy(i).memory = utf8Strings[i]
    }
    
    return argv
}

