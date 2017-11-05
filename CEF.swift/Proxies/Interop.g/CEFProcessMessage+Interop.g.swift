//
//  CEFProcessMessage+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_process_message.h.
//

import Foundation

extension cef_process_message_t: CEFObject {}

/// Class representing a message. Can be used on any process and thread.
/// CEF name: `CefProcessMessage`
public final class CEFProcessMessage: CEFProxy<cef_process_message_t> {
    override init?(ptr: UnsafeMutablePointer<cef_process_message_t>?) {
        super.init(ptr: ptr)
    }
    
    static func fromCEF(_ ptr: UnsafeMutablePointer<cef_process_message_t>?) -> CEFProcessMessage? {
        return CEFProcessMessage(ptr: ptr)
    }
}

