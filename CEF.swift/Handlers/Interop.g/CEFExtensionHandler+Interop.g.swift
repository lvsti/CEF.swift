//
//  CEFExtensionHandler+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_extension_handler.h.
//

import Foundation

extension cef_extension_handler_t: CEFObject {}

typealias CEFExtensionHandlerMarshaller = CEFMarshaller<CEFExtensionHandler, cef_extension_handler_t>

extension CEFExtensionHandler {
    func toCEF() -> UnsafeMutablePointer<cef_extension_handler_t> {
        return CEFExtensionHandlerMarshaller.pass(self)
    }
}

extension cef_extension_handler_t: CEFCallbackMarshalling {
    mutating func marshalCallbacks() {
        on_extension_load_failed = CEFExtensionHandler_on_extension_load_failed
        on_extension_loaded = CEFExtensionHandler_on_extension_loaded
        on_extension_unloaded = CEFExtensionHandler_on_extension_unloaded
        on_before_background_browser = CEFExtensionHandler_on_before_background_browser
        on_before_browser = CEFExtensionHandler_on_before_browser
        get_active_browser = CEFExtensionHandler_get_active_browser
        can_access_browser = CEFExtensionHandler_can_access_browser
        get_extension_resource = CEFExtensionHandler_get_extension_resource
    }
}
