//
//  ResourceBundleHandler+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_resource_bundle_handler.h.
//

import Foundation

extension cef_resource_bundle_handler_t: CEFObject {}

typealias ResourceBundleHandlerMarshaller = Marshaller<ResourceBundleHandler, cef_resource_bundle_handler_t>

extension ResourceBundleHandler {
    func toCEF() -> UnsafeMutablePointer<cef_resource_bundle_handler_t> {
        return ResourceBundleHandlerMarshaller.pass(self)
    }
}

extension cef_resource_bundle_handler_t: CallbackMarshalling {
    mutating func marshalCallbacks() {
        get_localized_string = ResourceBundleHandler_get_localized_string
        get_data_resource = ResourceBundleHandler_get_data_resource
    }
}
