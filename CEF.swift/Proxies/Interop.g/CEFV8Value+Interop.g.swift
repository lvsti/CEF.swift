//
//  CEFV8Value+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_v8.h.
//

import Foundation

extension cef_v8value_t: CEFObject {}

/// Class representing a V8 value handle. V8 handles can only be accessed from
/// the thread on which they are created. Valid threads for creating a V8 handle
/// include the render process main thread (TID_RENDERER) and WebWorker threads.
/// A task runner for posting tasks on the associated thread can be retrieved via
/// the CefV8Context::GetTaskRunner() method.
public class CEFV8Value: CEFProxy<cef_v8value_t> {
    override init?(ptr: UnsafeMutablePointer<cef_v8value_t>) {
        super.init(ptr: ptr)
    }
    
    static func fromCEF(ptr: UnsafeMutablePointer<cef_v8value_t>) -> CEFV8Value? {
        return CEFV8Value(ptr: ptr)
    }
}

