//
//  CEFMediaRoute+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_media_router.h.
//

import Foundation

extension cef_media_route_t: CEFObject {}

/// Represents the route between a media source and sink. Instances of this
/// object are created via CefMediaRouter::CreateRoute and retrieved via
/// CefMediaObserver::OnRoutes. Contains the status and metadata of a
/// routing operation. The methods of this class may be called on any browser
/// process thread unless otherwise indicated.
/// CEF name: `CefMediaRoute`
public final class CEFMediaRoute: CEFProxy<cef_media_route_t> {
    override init?(ptr: UnsafeMutablePointer<cef_media_route_t>?) {
        super.init(ptr: ptr)
    }
    
    static func fromCEF(_ ptr: UnsafeMutablePointer<cef_media_route_t>?) -> CEFMediaRoute? {
        return CEFMediaRoute(ptr: ptr)
    }
}

