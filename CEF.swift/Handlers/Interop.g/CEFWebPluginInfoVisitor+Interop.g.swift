//
//  CEFWebPluginInfoVisitor+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_web_plugin.h.
//

import Foundation

extension cef_web_plugin_info_visitor_t: CEFObject {}

typealias CEFWebPluginInfoVisitorMarshaller = CEFMarshaller<CEFWebPluginInfoVisitor, cef_web_plugin_info_visitor_t>

extension cef_web_plugin_info_visitor_t {
    func toCEF() -> UnsafeMutablePointer<cef_web_plugin_info_visitor_t> {
        return CEFWebPluginInfoVisitorMarshaller.pass(self)
    }
}

extension cef_web_plugin_info_visitor_t: CEFCallbackMarshalling {
    mutating func marshalCallbacks() {
        visit = CEFWebPluginInfoVisitor_visit
    }
}
