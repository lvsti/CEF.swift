//
//  CEFFrame+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_frame.h.
//

import Foundation

extension cef_frame_t: CEFObject {}

/// Class used to represent a frame in the browser window. When used in the
/// browser process the methods of this class may be called on any thread unless
/// otherwise indicated in the comments. When used in the render process the
/// methods of this class may only be called on the main thread.
public class CEFFrame: CEFProxy<cef_frame_t> {
    override init?(ptr: UnsafeMutablePointer<cef_frame_t>) {
        super.init(ptr: ptr)
    }
    
    static func fromCEF(ptr: UnsafeMutablePointer<cef_frame_t>) -> CEFFrame? {
        return CEFFrame(ptr: ptr)
    }
}

