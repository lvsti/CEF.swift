//
//  ReadHandler.g.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 13..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

func ReadHandler_read(ptr: UnsafeMutablePointer<cef_read_handler_t>,
                      buffer: UnsafeMutablePointer<Void>,
                      chunkSize: size_t,
                      count: size_t) -> size_t {
    guard let obj = ReadHandlerMarshaller.get(ptr) else {
        return 0
    }
    
    return obj.read(buffer, chunkSize: chunkSize, count: count)
}

func ReadHandler_seek(ptr: UnsafeMutablePointer<cef_read_handler_t>,
                      offset: Int64,
                      whence: Int32) -> Int32 {
    guard let obj = ReadHandlerMarshaller.get(ptr) else {
        return 1
    }
    
    return obj.seek(offset, whence: SeekPosition(rawValue: whence)!) ? 0 : 1
}

func ReadHandler_tell(ptr: UnsafeMutablePointer<cef_read_handler_t>) -> Int64 {
    guard let obj = ReadHandlerMarshaller.get(ptr) else {
        return 0
    }
    
    return obj.tell()
}

func ReadHandler_eof(ptr: UnsafeMutablePointer<cef_read_handler_t>) -> Int32 {
    guard let obj = ReadHandlerMarshaller.get(ptr) else {
        return 1
    }
    
    return obj.isEOF() ? 1 : 0
}

func ReadHandler_may_block(ptr: UnsafeMutablePointer<cef_read_handler_t>) -> Int32 {
    guard let obj = ReadHandlerMarshaller.get(ptr) else {
        return 0
    }
    
    return obj.mayBlock() ? 1 : 0
}
