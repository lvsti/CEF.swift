//
//  CEFContextMenuParams+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_context_menu_handler.h.
//

import Foundation

extension cef_context_menu_params_t: CEFObject {}

/// Provides information about the context menu state. The ethods of this class
/// can only be accessed on browser process the UI thread.
/// CEF name: `CefContextMenuParams`
public class CEFContextMenuParams: CEFProxy<cef_context_menu_params_t> {
    override init?(ptr: UnsafeMutablePointer<cef_context_menu_params_t>?) {
        super.init(ptr: ptr)
    }
    
    static func fromCEF(_ ptr: UnsafeMutablePointer<cef_context_menu_params_t>?) -> CEFContextMenuParams? {
        return CEFContextMenuParams(ptr: ptr)
    }
}

