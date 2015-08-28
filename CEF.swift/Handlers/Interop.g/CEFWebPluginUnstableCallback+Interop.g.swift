//
//  CEFWebPluginUnstableCallback+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_web_plugin.h.
//

import Foundation

extension cef_web_plugin_unstable_callback_t: CEFObject {}

typealias CEFWebPluginUnstableCallbackMarshaller = CEFMarshaller<CEFWebPluginUnstableCallback, cef_web_plugin_unstable_callback_t>

extension CEFWebPluginUnstableCallback {
    func toCEF() -> UnsafeMutablePointer<cef_web_plugin_unstable_callback_t> {
        return CEFWebPluginUnstableCallbackMarshaller.pass(self)
    }
}

extension cef_web_plugin_unstable_callback_t: CEFCallbackMarshalling {
    mutating func marshalCallbacks() {
        is_unstable = CEFWebPluginUnstableCallback_is_unstable
    }
}
