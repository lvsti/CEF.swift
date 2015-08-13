//
//  CEFWriteHandler.g.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 13..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

extension cef_write_handler_t: CEFObject {
}

typealias CEFWriteHandlerMarshaller = CEFMarshaller<CEFWriteHandler, cef_write_handler_t>

extension CEFWriteHandler {
    func toCEF() -> UnsafeMutablePointer<cef_write_handler_t> {
        return CEFWriteHandlerMarshaller.pass(self)
    }
}

extension cef_write_handler_t: CEFCallbackMarshalling {
    mutating func marshalCallbacks() {
        write = CEFWriteHandler_write
        seek = CEFWriteHandler_seek
        tell = CEFWriteHandler_tell
        flush = CEFWriteHandler_flush
        may_block = CEFWriteHandler_mayBlock
    }
}

func CEFWriteHandler_write(ptr: UnsafeMutablePointer<cef_write_handler_t>,
                           buffer: UnsafePointer<Void>,
                           chunkSize: size_t,
                           count: size_t) -> size_t {
    guard let obj = CEFWriteHandlerMarshaller.get(ptr) else {
        return 0
    }
    
    return obj.write(buffer, chunkSize: chunkSize, count: count)
}

func CEFWriteHandler_seek(ptr: UnsafeMutablePointer<cef_write_handler_t>,
                          offset: Int64,
                          whence: Int32) -> Int32 {
    guard let obj = CEFWriteHandlerMarshaller.get(ptr) else {
        return 1
    }
    
    return obj.seek(offset, whence: CEFSeekPosition(rawValue: whence)!) ? 0 : 1
}

func CEFWriteHandler_tell(ptr: UnsafeMutablePointer<cef_write_handler_t>) -> Int64 {
    guard let obj = CEFWriteHandlerMarshaller.get(ptr) else {
        return 0
    }
    
    return obj.tell()
}

func CEFWriteHandler_flush(ptr: UnsafeMutablePointer<cef_write_handler_t>) -> Int32 {
    guard let obj = CEFWriteHandlerMarshaller.get(ptr) else {
        return 0
    }
    
    return obj.flush() ? 1 : 0
}

func CEFWriteHandler_mayBlock(ptr: UnsafeMutablePointer<cef_write_handler_t>) -> Int32 {
    guard let obj = CEFWriteHandlerMarshaller.get(ptr) else {
        return 0
    }
    
    return obj.mayBlock() ? 1 : 0
}
