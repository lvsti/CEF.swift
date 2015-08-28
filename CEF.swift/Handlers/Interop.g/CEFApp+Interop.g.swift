//
//  CEFApp+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_app.h.
//

import Foundation

extension cef_app_t: CEFObject {}

typealias CEFAppMarshaller = CEFMarshaller<CEFApp, cef_app_t>

extension cef_app_t {
    func toCEF() -> UnsafeMutablePointer<cef_app_t> {
        return CEFAppMarshaller.pass(self)
    }
}

extension cef_app_t: CEFCallbackMarshalling {
    mutating func marshalCallbacks() {
        on_before_command_line_processing = CEFApp_on_before_command_line_processing
        on_register_custom_schemes = CEFApp_on_register_custom_schemes
        get_resource_bundle_handler = CEFApp_get_resource_bundle_handler
        get_browser_process_handler = CEFApp_get_browser_process_handler
        get_render_process_handler = CEFApp_get_render_process_handler
    }
}
