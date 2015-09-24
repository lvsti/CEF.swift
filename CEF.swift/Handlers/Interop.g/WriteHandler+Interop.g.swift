//
//  WriteHandler+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_stream.h.
//

import Foundation

extension cef_write_handler_t: CEFObject {}

typealias WriteHandlerMarshaller = Marshaller<WriteHandler, cef_write_handler_t>

extension WriteHandler {
    func toCEF() -> UnsafeMutablePointer<cef_write_handler_t> {
        return WriteHandlerMarshaller.pass(self)
    }
}

extension cef_write_handler_t: CallbackMarshalling {
    mutating func marshalCallbacks() {
        write = WriteHandler_write
        seek = WriteHandler_seek
        tell = WriteHandler_tell
        flush = WriteHandler_flush
        may_block = WriteHandler_may_block
    }
}
