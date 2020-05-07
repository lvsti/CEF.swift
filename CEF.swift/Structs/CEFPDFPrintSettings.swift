//
//  CEFPDFPrintSettings.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 09. 08..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

/// Structure representing PDF print settings.
/// CEF name: `cef_pdf_print_settings_t`
public struct CEFPDFPrintSettings {
    public struct HeaderFooter {
        /// Page title to display in the header. Only used if |header_footer_enabled|
        /// is set to true (1).
        /// CEF name: `header_footer_title`
        public var title: String? = nil

        /// URL to display in the footer. Only used if |header_footer_enabled| is set
        /// to true (1).
        /// CEF name: `header_footer_url`
        public var url: URL? = nil
    }
    
    /// Set to true (1) to print headers and footers or false (0) to not print
    /// headers and footers.
    /// CEF name: `header_footer_enabled`
    public var headerFooter: HeaderFooter? = nil
    
    /// Output page size in microns. If either of these values is less than or
    /// equal to zero then the default paper size (A4) will be used.
    /// CEF name: `page_width`, `page_height`
    public var pageSize: NSSize = .zero
    
    /// The percentage to scale the PDF by before printing (e.g. 50 is 50%).
    /// If this value is less than or equal to zero the default value of 100
    /// will be used.
    /// CEF name: `scale_factor`
    public var scaleFactor: Int
    
    /// Margins in points. Only used if |margin_type| is set to
    /// PDF_PRINT_MARGIN_CUSTOM.
    /// CEF name: `margin_type`, `margin_top`, `margin_left`, `margin_bottom`, `margin_right`
    public var margins: CEFPDFPrintMargins = .default
    
    /// Set to true (1) to print the selection only or false (0) to print all.
    /// CEF name: `selection_only`
    public var printsSelectionOnly: Bool = false
    
    /// Set to true (1) for landscape mode or false (0) for portrait mode.
    /// CEF name: `landscape`
    public var orientation: CEFPageOrientation = .portrait
    
    /// Set to true (1) to print background graphics or false (0) to not print
    /// background graphics.
    /// CEF name: `backgrounds_enabled`
    public var printsBackground: Bool = false
    
}

extension CEFPDFPrintSettings {
    func toCEF() -> cef_pdf_print_settings_t {
        var cefStruct = cef_pdf_print_settings_t()
        
        if let headerFooter = headerFooter {
            cefStruct.header_footer_enabled = 1
            if headerFooter.title != nil {
                CEFStringSetFromSwiftString(headerFooter.title!, cefStringPtr: &cefStruct.header_footer_title)
            }
            if headerFooter.url != nil {
                CEFStringSetFromSwiftString(headerFooter.url!.absoluteString, cefStringPtr: &cefStruct.header_footer_title)
            }
        }
        
        cefStruct.page_width = Int32(pageSize.width)
        cefStruct.page_height = Int32(pageSize.height)
        cefStruct.scale_factor = Int32(scaleFactor)
        
        cefStruct.margin_type = margins.toCEF()
        if case .custom(let insets) = margins {
            cefStruct.margin_top = Int32(insets.top)
            cefStruct.margin_left = Int32(insets.left)
            cefStruct.margin_bottom = Int32(insets.bottom)
            cefStruct.margin_right = Int32(insets.right)
        }
        
        cefStruct.selection_only = printsSelectionOnly ? 1 : 0
        cefStruct.landscape = orientation == .landscape ? 1 : 0
        cefStruct.backgrounds_enabled = printsBackground ? 1 : 0
        
        return cefStruct
    }
}

extension cef_pdf_print_settings_t {
    mutating func clear() {
        cef_string_utf16_clear(&header_footer_title)
        cef_string_utf16_clear(&header_footer_url)
    }
}


