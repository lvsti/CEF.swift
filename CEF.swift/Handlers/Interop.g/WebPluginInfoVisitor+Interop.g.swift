//
//  WebPluginInfoVisitor+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_web_plugin.h.
//

import Foundation

extension cef_web_plugin_info_visitor_t: CEFObject {}

typealias WebPluginInfoVisitorMarshaller = Marshaller<WebPluginInfoVisitor, cef_web_plugin_info_visitor_t>

extension WebPluginInfoVisitor {
    func toCEF() -> UnsafeMutablePointer<cef_web_plugin_info_visitor_t> {
        return WebPluginInfoVisitorMarshaller.pass(self)
    }
}

extension cef_web_plugin_info_visitor_t: CallbackMarshalling {
    mutating func marshalCallbacks() {
        visit = WebPluginInfoVisitor_visit
    }
}
