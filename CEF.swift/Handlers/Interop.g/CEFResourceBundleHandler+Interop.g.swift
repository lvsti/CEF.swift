//
//  CEFResourceBundleHandler+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_resource_bundle_handler.h.
//

import Foundation

extension cef_resource_bundle_handler_t: CEFObject {}

typealias CEFResourceBundleHandlerMarshaller = CEFMarshaller<CEFResourceBundleHandler, cef_resource_bundle_handler_t>

extension CEFResourceBundleHandler {
    func toCEF() -> UnsafeMutablePointer<cef_resource_bundle_handler_t> {
        return CEFResourceBundleHandlerMarshaller.pass(self)
    }
}

extension cef_resource_bundle_handler_t: CEFCallbackMarshalling {
    mutating func marshalCallbacks() {
        get_localized_string = CEFResourceBundleHandler_get_localized_string
        get_data_resource = CEFResourceBundleHandler_get_data_resource
    }
}
