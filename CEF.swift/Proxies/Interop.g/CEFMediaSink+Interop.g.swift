//
//  CEFMediaSink+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_media_router.h.
//

import Foundation

extension cef_media_sink_t: CEFObject {}

/// Represents a sink to which media can be routed. Instances of this object are
/// retrieved via CefMediaObserver::OnSinks. The methods of this class may
/// be called on any browser process thread unless otherwise indicated.
/// CEF name: `CefMediaSink`
public final class CEFMediaSink: CEFProxy<cef_media_sink_t> {
    override init?(ptr: UnsafeMutablePointer<cef_media_sink_t>?) {
        super.init(ptr: ptr)
    }
    
    static func fromCEF(_ ptr: UnsafeMutablePointer<cef_media_sink_t>?) -> CEFMediaSink? {
        return CEFMediaSink(ptr: ptr)
    }
}

