//
//  CEFDOMNodeType.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_types.h.
//

import Foundation

///
// DOM node types.
///
public enum CEFDOMNodeType: Int32 {
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
    static func fromCEF(value: cef_dom_node_type_t) -> CEFDOMNodeType {
        return CEFDOMNodeType(rawValue: Int32(value.rawValue))!
    }

    func toCEF() -> cef_dom_node_type_t {
        return cef_dom_node_type_t(rawValue: UInt32(rawValue))
    }
}

