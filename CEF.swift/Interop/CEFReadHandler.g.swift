//
//  CEFReadHandler.g.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 13..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

extension cef_read_handler_t: CEFObject {
}

typealias CEFReadHandlerMarshaller = CEFMarshaller<CEFReadHandler, cef_read_handler_t>

extension CEFReadHandler {
    func toCEF() -> UnsafeMutablePointer<cef_read_handler_t> {
        return CEFReadHandlerMarshaller.pass(self)
    }
}

extension cef_read_handler_t: CEFCallbackMarshalling {
    mutating func marshalCallbacks() {
        read = CEFReadHandler_read
        seek = CEFReadHandler_seek
        tell = CEFReadHandler_tell
        eof = CEFReadHandler_isEOF
        may_block = CEFReadHandler_mayBlock
    }
}

func CEFReadHandler_read(ptr: UnsafeMutablePointer<cef_read_handler_t>,
                         buffer: UnsafeMutablePointer<Void>,
                         chunkSize: size_t,
                         count: size_t) -> size_t {
    guard let obj = CEFReadHandlerMarshaller.get(ptr) else {
        return 0
    }
    
    return obj.read(buffer, chunkSize: chunkSize, count: count)
}

func CEFReadHandler_seek(ptr: UnsafeMutablePointer<cef_read_handler_t>,
                         offset: Int64,
                         whence: Int32) -> Int32 {
    guard let obj = CEFReadHandlerMarshaller.get(ptr) else {
        return 1
    }
    
    return obj.seek(offset, whence: CEFSeekPosition(rawValue: whence)!) ? 0 : 1
}

func CEFReadHandler_tell(ptr: UnsafeMutablePointer<cef_read_handler_t>) -> Int64 {
    guard let obj = CEFReadHandlerMarshaller.get(ptr) else {
        return 0
    }
    
    return obj.tell()
}

func CEFReadHandler_isEOF(ptr: UnsafeMutablePointer<cef_read_handler_t>) -> Int32 {
    guard let obj = CEFReadHandlerMarshaller.get(ptr) else {
        return 1
    }
    
    return obj.isEOF() ? 1 : 0
}

func CEFReadHandler_mayBlock(ptr: UnsafeMutablePointer<cef_read_handler_t>) -> Int32 {
    guard let obj = CEFReadHandlerMarshaller.get(ptr) else {
        return 0
    }
    
    return obj.mayBlock() ? 1 : 0
}
