//
//  CEFDOMNodeType.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 01..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

public enum CEFDOMNodeType: Int {
    case Unsupported = 0
    case Element
    case Attribute
    case Text
    case CDATASection
    case ProcessingInstructions
    case Comment
    case Document
    case DocumentType
    case DocumentFragment
}

extension CEFDOMNodeType {
    func toCEF() -> cef_dom_node_type_t {
        return cef_dom_node_type_t(rawValue: UInt32(rawValue))
    }
}

