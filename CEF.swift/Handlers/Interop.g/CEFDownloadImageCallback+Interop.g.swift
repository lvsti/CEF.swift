//
//  CEFDownloadImageCallback+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_browser.h.
//

import Foundation

extension cef_download_image_callback_t: CEFObject {}

typealias CEFDownloadImageCallbackMarshaller = CEFMarshaller<CEFDownloadImageCallback, cef_download_image_callback_t>

extension CEFDownloadImageCallback {
    func toCEF() -> UnsafeMutablePointer<cef_download_image_callback_t> {
        return CEFDownloadImageCallbackMarshaller.pass(self)
    }
}

extension cef_download_image_callback_t: CEFCallbackMarshalling {
    mutating func marshalCallbacks() {
        on_download_image_finished = CEFDownloadImageCallback_on_download_image_finished
    }
}
