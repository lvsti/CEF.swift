//
//  CEFPDFPrintMargins.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 09. 10..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

/// Margin type for PDF printing.
public enum CEFPDFPrintMargins {
    
    /// Default margins.
    case defaultMargins
    
    /// No margins.
    case none
    
    /// Minimum margins.
    case minimum
    
    /// Custom margins using the |margin_*| values from cef_pdf_print_settings_t.
    case custom(EdgeInsets)
}

extension CEFPDFPrintMargins {
    func toCEF() -> cef_pdf_print_margin_type_t {
        var rawValue: UInt32 = 0

        switch self {
        case .defaultMargins: rawValue = 0; break
        case .none: rawValue = 1; break
        case .minimum: rawValue = 2; break
        case .custom: rawValue = 3; break
        }
        
        return cef_pdf_print_margin_type_t(rawValue: rawValue)
    }
}
