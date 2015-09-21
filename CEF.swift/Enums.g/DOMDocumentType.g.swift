//
//  DOMDocumentType.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_types.h.
//

import Foundation

/// DOM document types.
public enum DOMDocumentType: Int32 {
    case Unknown = 0
    case HTML
    case XHTML
    case Plugin
}

extension DOMDocumentType {
    static func fromCEF(value: cef_dom_document_type_t) -> DOMDocumentType {
        return DOMDocumentType(rawValue: Int32(value.rawValue))!
    }

    func toCEF() -> cef_dom_document_type_t {
        return cef_dom_document_type_t(rawValue: UInt32(rawValue))
    }
}

