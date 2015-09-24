//
//  App+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_app.h.
//

import Foundation

extension cef_app_t: CEFObject {}

typealias AppMarshaller = Marshaller<App, cef_app_t>

extension App {
    func toCEF() -> UnsafeMutablePointer<cef_app_t> {
        return AppMarshaller.pass(self)
    }
}

extension cef_app_t: CallbackMarshalling {
    mutating func marshalCallbacks() {
        on_before_command_line_processing = App_on_before_command_line_processing
        on_register_custom_schemes = App_on_register_custom_schemes
        get_resource_bundle_handler = App_get_resource_bundle_handler
        get_browser_process_handler = App_get_browser_process_handler
        get_render_process_handler = App_get_render_process_handler
    }
}
