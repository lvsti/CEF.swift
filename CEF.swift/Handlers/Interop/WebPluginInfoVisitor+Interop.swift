//
//  WebPluginInfoVisitor.g.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 07..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

func WebPluginInfoVisitor_visit(ptr: UnsafeMutablePointer<cef_web_plugin_info_visitor_t>,
                                pluginInfo: UnsafeMutablePointer<cef_web_plugin_info_t>,
                                index: Int32,
                                totalCount: Int32) -> Int32 {
    guard let obj = WebPluginInfoVisitorMarshaller.get(ptr) else {
        return 0
    }

    return obj.visit(WebPluginInfo.fromCEF(pluginInfo)!, index: Int(index), totalCount: Int(totalCount)) ? 1 : 0
}

