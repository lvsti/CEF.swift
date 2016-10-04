//
//  CEFPDFPrintSettings.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 09. 08..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

/// Structure representing PDF print settings.
public struct CEFPDFPrintSettings {
    public struct HeaderFooter {
        /// Page title to display in the header. Only used if |header_footer_enabled|
        /// is set to true (1).
        public var title: String? = nil

        /// URL to display in the footer. Only used if |header_footer_enabled| is set
        /// to true (1).
        public var url: NSURL? = nil
    }
    
    /// Set to true (1) to print headers and footers or false (0) to not print
    /// headers and footers.
    public var headerFooter: HeaderFooter? = nil
    
    /// Output page size in microns. If either of these values is less than or
    /// equal to zero then the default paper size (A4) will be used.
    public var pageSize: NSSize = NSSize.zero
    
    /// Margins in millimeters. Only used if |margin_type| is set to
    /// PDF_PRINT_MARGIN_CUSTOM.
    public var margins: CEFPDFPrintMargins = .defaultMargins
    
    /// Set to true (1) to print the selection only or false (0) to print all.
    public var selectionOnly: Bool = false
    
    /// Set to true (1) for landscape mode or false (0) for portrait mode.
    public var orientation: CEFPageOrientation = .portrait
    
    /// Set to true (1) to print background graphics or false (0) to not print
    /// background graphics.
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
                CEFStringSetFromSwiftString(headerFooter.url!.absoluteString!, cefStringPtr: &cefStruct.header_footer_title)
            }
        }
        
        cefStruct.page_width = Int32(pageSize.width)
        cefStruct.page_height = Int32(pageSize.height)
        
        cefStruct.margin_type = margins.toCEF()
        if case .custom(let insets) = margins {
            cefStruct.margin_top = Double(insets.top)
            cefStruct.margin_left = Double(insets.left)
            cefStruct.margin_bottom = Double(insets.bottom)
            cefStruct.margin_right = Double(insets.right)
        }
        
        cefStruct.selection_only = selectionOnly ? 1 : 0
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


