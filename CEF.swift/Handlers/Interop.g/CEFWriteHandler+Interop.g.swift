//
//  CEFWriteHandler+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_stream.h.
//

import Foundation

extension cef_write_handler_t: CEFObject {}

typealias CEFWriteHandlerMarshaller = CEFMarshaller<CEFWriteHandler, cef_write_handler_t>

extension cef_write_handler_t {
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
        may_block = CEFWriteHandler_may_block
    }
}
