//
//  CEFResponse.swift
//  cef
//
//  Created by Tamas Lustyik on 2015. 07. 11..
//
//

import Foundation


public extension CEFResponse {
    public typealias HeaderMap = [String: [String]]
    
    /// Create a new CefResponse object.
    /// CEF name: `Create`
    public convenience init?() {
        self.init(ptr: cef_response_create())
    }
    
    /// Returns true if this object is read-only.
    /// CEF name: `IsReadOnly`
    public var isReadOnly: Bool {
        return cefObject.is_read_only(cefObjectPtr) != 0
    }

    /// Set the response error code. This can be used by custom scheme handlers
    /// to return errors during initial request processing.
    /// CEF name: `GetError`, `SetError`
    public var error: CEFErrorCode? {
        /// Get the response error code. Returns nil if there was no error.
        get {
            let cefError = cefObject.get_error(cefObjectPtr).rawValue
            return cefError != 0 ? CEFErrorCode.fromCEF(cefError) : nil
        }
        set {
            let cefError = newValue?.toCEF() ?? Int32(0)
            cefObject.set_error(cefObjectPtr, cef_errorcode_t(cefError))
        }
    }

    /// Response status code.
    /// CEF name: `GetStatus`, `SetStatus`
    public var status: Int {
        get { return Int(cefObject.get_status(cefObjectPtr)) }
        set { cefObject.set_status(cefObjectPtr, Int32(newValue)) }
    }

    /// Response status text.
    /// CEF name: `GetStatusText`, `SetStatusText`
    public var statusText: String? {
        get {
            let cefStrPtr = cefObject.get_status_text(cefObjectPtr)
            defer { CEFStringPtrRelease(cefStrPtr)}
            return cefStrPtr != nil ? CEFStringToSwiftString(cefStrPtr!.pointee) : nil
        }
        set {
            let cefStrPtr = newValue != nil ? CEFStringPtrCreateFromSwiftString(newValue!) : nil
            defer { CEFStringPtrRelease(cefStrPtr)}
            cefObject.set_status_text(cefObjectPtr, cefStrPtr)
        }
    }

    /// Get the response mime type.
    /// CEF name: `GetMimeType`, `SetMimeType`
    public var mimeType: String? {
        get {
            let cefStrPtr = cefObject.get_mime_type(cefObjectPtr)
            defer { CEFStringPtrRelease(cefStrPtr)}
            return cefStrPtr != nil ? CEFStringToSwiftString(cefStrPtr!.pointee) : nil
        }
        set {
            let cefStrPtr = newValue != nil ? CEFStringPtrCreateFromSwiftString(newValue!) : nil
            defer { CEFStringPtrRelease(cefStrPtr)}
            cefObject.set_mime_type(cefObjectPtr, cefStrPtr)
        }
    }
    
    /// Get the response charset.
    /// CEF name: `GetCharset`, `SetCharset`
    public var charset: String? {
        get {
            let cefStrPtr = cefObject.get_charset(cefObjectPtr)
            defer { CEFStringPtrRelease(cefStrPtr)}
            return cefStrPtr != nil ? CEFStringToSwiftString(cefStrPtr!.pointee) : nil
        }
        set {
            let cefStrPtr = newValue != nil ? CEFStringPtrCreateFromSwiftString(newValue!) : nil
            defer { CEFStringPtrRelease(cefStrPtr)}
            cefObject.set_charset(cefObjectPtr, cefStrPtr)
        }
    }
    
    /// Get the value for the specified response header field.
    /// CEF name: `GetHeaderByName`
    public func header(for name: String) -> String? {
        let cefNamePtr = CEFStringPtrCreateFromSwiftString(name)
        let cefHeaderPtr = cefObject.get_header_by_name(cefObjectPtr, cefNamePtr)
        defer {
            CEFStringPtrRelease(cefNamePtr)
            CEFStringPtrRelease(cefHeaderPtr)
        }
        
        return CEFStringPtrToSwiftString(cefHeaderPtr)
    }
    
    /// Set the header |name| to |value|. If |overwrite| is true any existing
    /// values will be replaced with the new value. If |overwrite| is false any
    /// existing values will not be overwritten.
    /// CEF name: `SetHeaderByName`
    public func setHeader(_ value: String?, for name: String, overwritingExisting: Bool = true) {
        let cefNamePtr = CEFStringPtrCreateFromSwiftString(name)
        let cefValuePtr = value != nil ? CEFStringPtrCreateFromSwiftString(value!) : nil
        defer {
            CEFStringPtrRelease(cefNamePtr)
            CEFStringPtrRelease(cefValuePtr)
        }
        cefObject.set_header_by_name(cefObjectPtr, cefNamePtr, cefValuePtr, overwritingExisting ? 1 : 0)
    }
    
    /// Response header fields.
    /// CEF name: `GetHeaderMap`, `SetHeaderMap`
    public var headers: HeaderMap {
        get {
            let cefHeaderMap = cef_string_multimap_alloc()!
            defer { cef_string_multimap_free(cefHeaderMap) }

            cefObject.get_header_map(cefObjectPtr, cefHeaderMap)
            return CEFStringMultimapToSwiftDictionaryOfArrays(cefHeaderMap)
        }
        set {
            let cefHeaderMap = CEFStringMultimapCreateFromSwiftDictionaryOfArrays(newValue)
            defer { cef_string_multimap_free(cefHeaderMap) }
            cefObject.set_header_map(cefObjectPtr, cefHeaderMap)
        }
    }

    /// Get the resolved URL after redirects or changed as a result of HSTS.
    /// CEF name: `GetURL`, `SetURL`
    public var url: URL? {
        get {
            let cefStrPtr = cefObject.get_url(cefObjectPtr)
            defer { CEFStringPtrRelease(cefStrPtr)}
            return cefStrPtr != nil ? URL(string: CEFStringToSwiftString(cefStrPtr!.pointee)) : nil
        }
        set {
            let cefStrPtr = newValue != nil ? CEFStringPtrCreateFromSwiftString(newValue!.absoluteString) : nil
            defer { CEFStringPtrRelease(cefStrPtr)}
            cefObject.set_url(cefObjectPtr, cefStrPtr)
        }
    }

}
