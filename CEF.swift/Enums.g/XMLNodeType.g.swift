//
//  XMLNodeType.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_types.h.
//

import Foundation

/// XML node types.
public enum XMLNodeType: Int32 {
    case Unsupported = 0
    case ProcessingInstruction
    case DocumentType
    case ElementStart
    case ElementEnd
    case Attribute
    case Text
    case CDATA
    case EntityReference
    case Whitespace
    case Comment
}

extension XMLNodeType {
    static func fromCEF(value: cef_xml_node_type_t) -> XMLNodeType {
        return XMLNodeType(rawValue: Int32(value.rawValue))!
    }

    func toCEF() -> cef_xml_node_type_t {
        return cef_xml_node_type_t(rawValue: UInt32(rawValue))
    }
}

