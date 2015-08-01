//
//  CEFDOMDocumentType.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 01..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

public enum CEFDOMDocumentType: Int {
    case Unknown = 0
    case HTML
    case XHTML
    case Plugin
}

extension CEFDOMDocumentType {
    func toCEF() -> cef_dom_document_type_t {
        return cef_dom_document_type_t(rawValue: UInt32(rawValue))
    }
}

