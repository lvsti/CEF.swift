//
//  CEFV8ArrayBufferReleaseCallback.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2018. 04. 20..
//  Copyright © 2018. Tamas Lustyik. All rights reserved.
//

import Foundation

/// Callback interface that is passed to CefV8Value::CreateArrayBuffer.
/// CEF name: `CefV8ArrayBufferReleaseCallback`
public protocol CEFV8ArrayBufferReleaseCallback {

    /// Called to release |buffer| when the ArrayBuffer JS object is garbage
    /// collected. |buffer| is the value that was passed to CreateArrayBuffer along
    /// with this object.
    /// CEF name: `ReleaseBuffer`
    func releaseBuffer(_ buffer: UnsafeMutableRawPointer?)

}

public extension CEFV8ArrayBufferReleaseCallback {
    
    func releaseBuffer(_ buffer: UnsafeMutableRawPointer?) {
    }
    
}
