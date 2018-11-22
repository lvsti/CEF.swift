//
//  CEFArgV.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2018. 11. 01..
//  Copyright © 2018. Tamas Lustyik. All rights reserved.
//

import Foundation

typealias CEFArgV = UnsafeMutablePointer<UnsafeMutablePointer<Int8>?>

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
