//
//  WebPluginUnstableCallback+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_web_plugin.h.
//

import Foundation

extension cef_web_plugin_unstable_callback_t: CEFObject {}

typealias WebPluginUnstableCallbackMarshaller = Marshaller<WebPluginUnstableCallback, cef_web_plugin_unstable_callback_t>

extension WebPluginUnstableCallback {
    func toCEF() -> UnsafeMutablePointer<cef_web_plugin_unstable_callback_t> {
        return WebPluginUnstableCallbackMarshaller.pass(self)
    }
}

extension cef_web_plugin_unstable_callback_t: CallbackMarshalling {
    mutating func marshalCallbacks() {
        is_unstable = WebPluginUnstableCallback_is_unstable
    }
}
