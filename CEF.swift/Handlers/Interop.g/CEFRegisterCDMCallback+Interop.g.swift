//
//  CEFRegisterCDMCallback+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_web_plugin.h.
//

import Foundation

extension cef_register_cdm_callback_t: CEFObject {}

typealias CEFRegisterCDMCallbackMarshaller = CEFMarshaller<CEFRegisterCDMCallback, cef_register_cdm_callback_t>

extension CEFRegisterCDMCallback {
    func toCEF() -> UnsafeMutablePointer<cef_register_cdm_callback_t> {
        return CEFRegisterCDMCallbackMarshaller.pass(self)
    }
}

extension cef_register_cdm_callback_t: CEFCallbackMarshalling {
    mutating func marshalCallbacks() {
        on_cdm_registration_complete = CEFRegisterCDMCallback_on_cdm_registration_complete
    }
}
