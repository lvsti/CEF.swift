//
//  CEFXMLNodeType.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_types.h.
//

import Foundation

/// XML node types.
/// CEF name: `cef_xml_node_type_t`.
public enum CEFXMLNodeType: Int32 {
    /// CEF name: `XML_NODE_UNSUPPORTED`.
    case unsupported = 0
    /// CEF name: `XML_NODE_PROCESSING_INSTRUCTION`.
    case processingInstruction
    /// CEF name: `XML_NODE_DOCUMENT_TYPE`.
    case documentType
    /// CEF name: `XML_NODE_ELEMENT_START`.
    case elementStart
    /// CEF name: `XML_NODE_ELEMENT_END`.
    case elementEnd
    /// CEF name: `XML_NODE_ATTRIBUTE`.
    case attribute
    /// CEF name: `XML_NODE_TEXT`.
    case text
    /// CEF name: `XML_NODE_CDATA`.
    case cdata
    /// CEF name: `XML_NODE_ENTITY_REFERENCE`.
    case entityReference
    /// CEF name: `XML_NODE_WHITESPACE`.
    case whitespace
    /// CEF name: `XML_NODE_COMMENT`.
    case comment
}

extension CEFXMLNodeType {
    static func fromCEF(_ value: cef_xml_node_type_t) -> CEFXMLNodeType {
        return CEFXMLNodeType(rawValue: Int32(value.rawValue))!
    }

    func toCEF() -> cef_xml_node_type_t {
        return cef_xml_node_type_t(rawValue: UInt32(rawValue))
    }
}

