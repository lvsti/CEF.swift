//
//  CEFDOMNodeType.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_types.h.
//

import Foundation

/// DOM node types.
public enum CEFDOMNodeType: Int32 {
    case unsupported = 0
    case element
    case attribute
    case text
    case cdataSection
    case processingInstructions
    case comment
    case document
    case documentType
    case documentFragment
}

extension CEFDOMNodeType {
    static func fromCEF(_ value: cef_dom_node_type_t) -> CEFDOMNodeType {
        return CEFDOMNodeType(rawValue: Int32(value.rawValue))!
    }

    func toCEF() -> cef_dom_node_type_t {
        return cef_dom_node_type_t(rawValue: UInt32(rawValue))
    }
}

