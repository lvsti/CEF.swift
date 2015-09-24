//
//  DownloadHandler+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_download_handler.h.
//

import Foundation

extension cef_download_handler_t: CEFObject {}

typealias DownloadHandlerMarshaller = Marshaller<DownloadHandler, cef_download_handler_t>

extension DownloadHandler {
    func toCEF() -> UnsafeMutablePointer<cef_download_handler_t> {
        return DownloadHandlerMarshaller.pass(self)
    }
}

extension cef_download_handler_t: CallbackMarshalling {
    mutating func marshalCallbacks() {
        on_before_download = DownloadHandler_on_before_download
        on_download_updated = DownloadHandler_on_download_updated
    }
}
