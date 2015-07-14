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

struct CEFMainArgs {
    var arguments: [String]
    
    func toCEF() -> cef_main_args_t {
        return cef_main_args_t(argc: Int32(arguments.count),
                               argv: CEFMutableArgV(CEFArgVFromArguments(arguments)))
    }
}

extension cef_main_args_t {
    mutating func clear() {
        if argv == nil {
            return
        }
        
        for i in 0..<Int(argc) {
            let cstr = argv.advancedBy(i).memory
            if let str = String.fromCString(cstr) {
                let byteCount = str.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) + 1
                cstr.dealloc(byteCount)
            }
        }
        
        argv.dealloc(Int(argc))
    }
}

func CEFArgVFromArguments(arguments: [String]) -> CEFArgV {
    let argv = CEFArgV.alloc(arguments.count)
    
    for i in 0..<arguments.count {
        let utf8ByteCount = arguments[i].lengthOfBytesUsingEncoding(NSUTF8StringEncoding) + 1
        let ptr = UnsafeMutablePointer<Int8>.alloc(utf8ByteCount)
        arguments[i].withCString { cstr in
            ptr.initializeFrom(UnsafeMutablePointer<Int8>(cstr), count: utf8ByteCount)
            argv.advancedBy(i).memory = ptr
            return false
        }
    }
    
    return argv
}

