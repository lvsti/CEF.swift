//
//  CEFMainArgs.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 07. 13..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

///
// Structure representing CefExecuteProcess arguments.
///
public struct CEFMainArgs {
    public let arguments: [String]
}


typealias CEFArgV = UnsafeMutablePointer<UnsafePointer<Int8>>
typealias CEFMutableArgV = UnsafeMutablePointer<UnsafeMutablePointer<Int8>>

extension CEFMainArgs {
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
        let ptr = arguments[i].withCString { (cstr: UnsafePointer<Int8>) -> UnsafeMutablePointer<Int8> in
            let ptr = UnsafeMutablePointer<Int8>.alloc(utf8ByteCount)
            ptr.initializeFrom(UnsafeMutablePointer<Int8>(cstr), count: utf8ByteCount)
            return ptr
        }
        argv.advancedBy(i).memory = UnsafePointer<Int8>(ptr)
    }
    
    return argv
}

