//
//  CEFWebPluginInfoVisitor.g.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 07..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

extension cef_web_plugin_info_visitor_t: CEFObject {
}

typealias CEFWebPluginInfoVisitorMarshaller = CEFMarshaller<CEFWebPluginInfoVisitor, cef_web_plugin_info_visitor_t>

extension CEFWebPluginInfoVisitor {
    func toCEF() -> UnsafeMutablePointer<cef_web_plugin_info_visitor_t> {
        return CEFWebPluginInfoVisitorMarshaller.pass(self)
    }
}

extension cef_web_plugin_info_visitor_t: CEFCallbackMarshalling {
    mutating func marshalCallbacks() {
        visit = CEFWebPluginInfoVisitor_visit
    }
}

func CEFWebPluginInfoVisitor_visit(ptr: UnsafeMutablePointer<cef_web_plugin_info_visitor_t>,
                                   pluginInfo: UnsafeMutablePointer<cef_web_plugin_info_t>,
                                   index: Int32,
                                   totalCount: Int32) -> Int32 {
    guard let obj = CEFWebPluginInfoVisitorMarshaller.get(ptr) else {
        return 0
    }

    return obj.visit(CEFWebPluginInfo.fromCEF(pluginInfo)!, index: Int(index), totalCount: Int(totalCount)) ? 1 : 0
}

