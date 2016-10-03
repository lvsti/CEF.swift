//
//  CEFMainArgs.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 07. 13..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

/// Structure representing CefExecuteProcess arguments.
public struct CEFMainArgs {
    public let arguments: [String]
    
    public init(arguments: [String]) {
        self.arguments = arguments
    }
}


typealias CEFArgV = UnsafeMutablePointer<UnsafeMutablePointer<Int8>?>

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
            if let cstr = argv.advanced(by: i).pointee,
               let str = String(validatingUTF8: cstr) {
                let byteCount = str.lengthOfBytes(using: String.Encoding.utf8) + 1
                cstr.deallocate(capacity: byteCount)
            }
        }
        
        argv.deallocate(capacity: Int(argc))
    }
}

func CEFArgVFromArguments(_ arguments: [String]) -> CEFArgV {
    let argv = CEFArgV.allocate(capacity: arguments.count)
    
    for i in 0..<arguments.count {
        let utf8ByteCount = arguments[i].lengthOfBytes(using: String.Encoding.utf8) + 1
        let ptr = arguments[i].withCString { (cstr: UnsafePointer<Int8>) -> UnsafeMutablePointer<Int8> in
            let ptr = UnsafeMutablePointer<Int8>.allocate(capacity: utf8ByteCount)
            ptr.initialize(from: UnsafeMutablePointer<Int8>(mutating: cstr), count: utf8ByteCount)
            return ptr
        }
        argv.advanced(by: i).pointee = UnsafeMutablePointer<Int8>(ptr)
    }
    
    return argv
}

