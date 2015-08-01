//
//  CEFResourceType.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 01..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

public enum CEFResourceType: Int {
    case MainFrame = 0
    case Subframe
    case StyleSheet
    case Script
    case Image
    case FontResource
    case Subresource
    case Object
    case Media
    case Worker
    case SharedWorker
    case Prefetch
    case Favicon
    case XHR
    case Ping
    case ServiceWorker
}

extension CEFResourceType {
    static func fromCEF(value: cef_resource_type_t) -> CEFResourceType {
        return CEFResourceType(rawValue: Int(value.rawValue))!
    }
}

