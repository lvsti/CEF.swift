//
//  CEFMediaRouter+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_media_router.h.
//

import Foundation

extension cef_media_router_t: CEFObject {}

/// Supports discovery of and communication with media devices on the local
/// network via the Cast and DIAL protocols. The methods of this class may be
/// called on any browser process thread unless otherwise indicated.
/// CEF name: `CefMediaRouter`
public final class CEFMediaRouter: CEFProxy<cef_media_router_t> {
    override init?(ptr: UnsafeMutablePointer<cef_media_router_t>?) {
        super.init(ptr: ptr)
    }
    
    static func fromCEF(_ ptr: UnsafeMutablePointer<cef_media_router_t>?) -> CEFMediaRouter? {
        return CEFMediaRouter(ptr: ptr)
    }
}

