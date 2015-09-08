//
//  CEFPDFPrintMarginType.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_types.h.
//

import Foundation

/// Margin type for PDF printing.
public enum CEFPDFPrintMarginType: Int32 {

    /// Default margins.
    case Default

    /// No margins.
    case None

    /// Minimum margins.
    case Minimum

    /// Custom margins using the |margin_*| values from cef_pdf_print_settings_t.
    case Custom
}

extension CEFPDFPrintMarginType {
    static func fromCEF(value: cef_pdf_print_margin_type_t) -> CEFPDFPrintMarginType {
        return CEFPDFPrintMarginType(rawValue: Int32(value.rawValue))!
    }

    func toCEF() -> cef_pdf_print_margin_type_t {
        return cef_pdf_print_margin_type_t(rawValue: UInt32(rawValue))
    }
}

