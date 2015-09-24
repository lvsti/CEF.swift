//
//  ReadHandler+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_stream.h.
//

import Foundation

extension cef_read_handler_t: CEFObject {}

typealias ReadHandlerMarshaller = Marshaller<ReadHandler, cef_read_handler_t>

extension ReadHandler {
    func toCEF() -> UnsafeMutablePointer<cef_read_handler_t> {
        return ReadHandlerMarshaller.pass(self)
    }
}

extension cef_read_handler_t: CallbackMarshalling {
    mutating func marshalCallbacks() {
        read = ReadHandler_read
        seek = ReadHandler_seek
        tell = ReadHandler_tell
        eof = ReadHandler_eof
        may_block = ReadHandler_may_block
    }
}
