//
//  CEFResourceBundle+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_resource_bundle.h.
//

import Foundation

extension cef_resource_bundle_t: CEFObject {}

/// Class used for retrieving resources from the resource bundle (*.pak) files
/// loaded by CEF during startup or via the CefResourceBundleHandler returned
/// from CefApp::GetResourceBundleHandler. See CefSettings for additional options
/// related to resource bundle loading. The methods of this class may be called
/// on any thread unless otherwise indicated.
/// CEF name: `CefResourceBundle`
public final class CEFResourceBundle: CEFProxy<cef_resource_bundle_t> {
    override init?(ptr: UnsafeMutablePointer<cef_resource_bundle_t>?) {
        super.init(ptr: ptr)
    }
    
    static func fromCEF(_ ptr: UnsafeMutablePointer<cef_resource_bundle_t>?) -> CEFResourceBundle? {
        return CEFResourceBundle(ptr: ptr)
    }
}

