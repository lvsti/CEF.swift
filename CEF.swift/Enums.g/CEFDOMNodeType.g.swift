//
//  CEFDOMNodeType.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_types.h.
//

import Foundation

/// DOM node types.
/// CEF name: `cef_dom_node_type_t`.
public enum CEFDOMNodeType: Int32 {
    /// CEF name: `DOM_NODE_TYPE_UNSUPPORTED`.
    case unsupported = 0
    /// CEF name: `DOM_NODE_TYPE_ELEMENT`.
    case element
    /// CEF name: `DOM_NODE_TYPE_ATTRIBUTE`.
    case attribute
    /// CEF name: `DOM_NODE_TYPE_TEXT`.
    case text
    /// CEF name: `DOM_NODE_TYPE_CDATA_SECTION`.
    case cdataSection
    /// CEF name: `DOM_NODE_TYPE_PROCESSING_INSTRUCTIONS`.
    case processingInstructions
    /// CEF name: `DOM_NODE_TYPE_COMMENT`.
    case comment
    /// CEF name: `DOM_NODE_TYPE_DOCUMENT`.
    case document
    /// CEF name: `DOM_NODE_TYPE_DOCUMENT_TYPE`.
    case documentType
    /// CEF name: `DOM_NODE_TYPE_DOCUMENT_FRAGMENT`.
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

