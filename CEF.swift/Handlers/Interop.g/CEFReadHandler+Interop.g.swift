//
//  CEFReadHandler+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_stream.h.
//

import Foundation

extension cef_read_handler_t: CEFObject {}

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
        eof = CEFReadHandler_eof
        may_block = CEFReadHandler_may_block
    }
}
