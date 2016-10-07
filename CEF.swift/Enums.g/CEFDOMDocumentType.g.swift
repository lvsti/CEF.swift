//
//  CEFDOMDocumentType.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_types.h.
//

import Foundation

/// DOM document types.
/// CEF name: `cef_dom_document_type_t`.
public enum CEFDOMDocumentType: Int32 {
    /// CEF name: `DOM_DOCUMENT_TYPE_UNKNOWN`.
    case unknown = 0
    /// CEF name: `DOM_DOCUMENT_TYPE_HTML`.
    case html
    /// CEF name: `DOM_DOCUMENT_TYPE_XHTML`.
    case xhtml
    /// CEF name: `DOM_DOCUMENT_TYPE_PLUGIN`.
    case plugin
}

extension CEFDOMDocumentType {
    static func fromCEF(_ value: cef_dom_document_type_t) -> CEFDOMDocumentType {
        return CEFDOMDocumentType(rawValue: Int32(value.rawValue))!
    }

    func toCEF() -> cef_dom_document_type_t {
        return cef_dom_document_type_t(rawValue: UInt32(rawValue))
    }
}

