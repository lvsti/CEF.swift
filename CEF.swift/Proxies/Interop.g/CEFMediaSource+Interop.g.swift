//
//  CEFMediaSource+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_media_router.h.
//

import Foundation

extension cef_media_source_t: CEFObject {}

/// Represents a source from which media can be routed. Instances of this object
/// are retrieved via CefMediaRouter::GetSource. The methods of this class may be
/// called on any browser process thread unless otherwise indicated.
/// CEF name: `CefMediaSource`
public final class CEFMediaSource: CEFProxy<cef_media_source_t> {
    override init?(ptr: UnsafeMutablePointer<cef_media_source_t>?) {
        super.init(ptr: ptr)
    }
    
    static func fromCEF(_ ptr: UnsafeMutablePointer<cef_media_source_t>?) -> CEFMediaSource? {
        return CEFMediaSource(ptr: ptr)
    }
}

