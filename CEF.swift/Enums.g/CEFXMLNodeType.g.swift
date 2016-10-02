//
//  CEFXMLNodeType.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_types.h.
//

import Foundation

/// XML node types.
public enum CEFXMLNodeType: Int32 {
    case unsupported = 0
    case processingInstruction
    case documentType
    case elementStart
    case elementEnd
    case attribute
    case text
    case cdata
    case entityReference
    case whitespace
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

