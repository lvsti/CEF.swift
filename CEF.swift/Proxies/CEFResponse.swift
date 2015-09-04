//
//  CEFResponse.swift
//  cef
//
//  Created by Tamas Lustyik on 2015. 07. 11..
//
//

import Foundation

extension cef_response_t: CEFObject {
}


/// Class used to represent a web response. The methods of this class may be
/// called on any thread.
public class CEFResponse: CEFProxy<cef_response_t> {
    public typealias HeaderMap = [String: [String]]
    
    /// Create a new CefResponse object.
    public init?() {
        super.init(ptr: cef_response_create())
    }
    
    /// Returns true if this object is read-only.
    public var isReadOnly: Bool {
        return cefObject.is_read_only(cefObjectPtr) != 0
    }

    /// Response status code.
    public var status: Int {
        get { return Int(cefObject.get_status(cefObjectPtr)) }
        set { cefObject.set_status(cefObjectPtr, Int32(status)) }
    }

    /// Response status text.
    public var statusText: String {
        get {
            let cefStrPtr = cefObject.get_status_text(cefObjectPtr)
            defer { CEFStringPtrRelease(cefStrPtr)}
            return CEFStringToSwiftString(cefStrPtr.memory)
        }
        set {
            let cefStrPtr = CEFStringPtrCreateFromSwiftString(newValue)
            defer { CEFStringPtrRelease(cefStrPtr)}
            cefObject.set_status_text(cefObjectPtr, cefStrPtr)
        }
    }

    /// Get the response mime type.
    public var mimeType: String {
        get {
            let cefStrPtr = cefObject.get_status_text(cefObjectPtr)
            defer { CEFStringPtrRelease(cefStrPtr)}
            return CEFStringToSwiftString(cefStrPtr.memory)
        }
        set {
            let cefStrPtr = CEFStringPtrCreateFromSwiftString(newValue)
            defer { CEFStringPtrRelease(cefStrPtr)}
            cefObject.set_status_text(cefObjectPtr, cefStrPtr)
        }
    }
    
    /// Get the value for the specified response header field.
    public func headerForKey(key: String) -> String? {
        let cefKeyPtr = CEFStringPtrCreateFromSwiftString(key)
        let cefHeaderPtr = cefObject.get_header(cefObjectPtr, cefKeyPtr)
        defer {
            CEFStringPtrRelease(cefKeyPtr)
            CEFStringPtrRelease(cefHeaderPtr)
        }
        
        return cefHeaderPtr != nil ? CEFStringToSwiftString(cefHeaderPtr.memory) : nil
    }
    
    /// Response header fields.
    public var headers: HeaderMap {
        get {
            let cefHeaderMap = cef_string_multimap_alloc()
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

    // private
    
    override init?(ptr: ObjectPtrType) {
        super.init(ptr: ptr)
    }
    
    static func fromCEF(ptr: ObjectPtrType) -> CEFResponse? {
        return CEFResponse(ptr: ptr)
    }
}
