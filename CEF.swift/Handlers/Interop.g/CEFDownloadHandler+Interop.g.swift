//
//  CEFDownloadHandler+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_download_handler.h.
//

import Foundation

extension cef_download_handler_t: CEFObject {}

typealias CEFDownloadHandlerMarshaller = CEFMarshaller<CEFDownloadHandler, cef_download_handler_t>

extension cef_download_handler_t {
    func toCEF() -> UnsafeMutablePointer<cef_download_handler_t> {
        return CEFDownloadHandlerMarshaller.pass(self)
    }
}

extension cef_download_handler_t: CEFCallbackMarshalling {
    mutating func marshalCallbacks() {
        on_before_download = CEFDownloadHandler_on_before_download
        on_download_updated = CEFDownloadHandler_on_download_updated
    }
}
