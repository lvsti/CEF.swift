//
//  CEFPDFPrintCallback+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_browser.h.
//

import Foundation

extension cef_pdf_print_callback_t: CEFObject {}

typealias CEFPDFPrintCallbackMarshaller = CEFMarshaller<CEFPDFPrintCallback, cef_pdf_print_callback_t>

extension CEFPDFPrintCallback {
    func toCEF() -> UnsafeMutablePointer<cef_pdf_print_callback_t> {
        return CEFPDFPrintCallbackMarshaller.pass(self)
    }
}

extension cef_pdf_print_callback_t: CEFCallbackMarshalling {
    mutating func marshalCallbacks() {
        on_pdf_print_finished = CEFPDFPrintCallback_on_pdf_print_finished
    }
}
