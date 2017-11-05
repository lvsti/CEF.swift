//
//  CEFGetExtensionResourceCallback+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_extension_handler.h.
//

import Foundation

extension cef_get_extension_resource_callback_t: CEFObject {}

/// Callback interface used for asynchronous continuation of
/// CefExtensionHandler::GetExtensionResource.
/// CEF name: `CefGetExtensionResourceCallback`
public final class CEFGetExtensionResourceCallback: CEFProxy<cef_get_extension_resource_callback_t> {
    override init?(ptr: UnsafeMutablePointer<cef_get_extension_resource_callback_t>?) {
        super.init(ptr: ptr)
    }
    
    static func fromCEF(_ ptr: UnsafeMutablePointer<cef_get_extension_resource_callback_t>?) -> CEFGetExtensionResourceCallback? {
        return CEFGetExtensionResourceCallback(ptr: ptr)
    }
}

