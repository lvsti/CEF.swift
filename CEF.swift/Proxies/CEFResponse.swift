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
    public func isReadOnly() -> Bool {
        return cefObject.is_read_only(cefObjectPtr) != 0
    }

    /// Get the response status code.
    public func getStatus() -> Int {
        return Int(cefObject.get_status(cefObjectPtr))
    }
    
    /// Set the response status code.
    public func setStatus(status: Int) {
        cefObject.set_status(cefObjectPtr, Int32(status))
    }
    
    /// Get the response status text.
    public func getStatusText() -> String {
        let cefStrPtr = cefObject.get_status_text(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr)}
        return CEFStringToSwiftString(cefStrPtr.memory)
    }

    /// Set the response status text.
    public func setStatusText(statusText: String) {
        let cefStrPtr = CEFStringPtrCreateFromSwiftString(statusText)
        defer { CEFStringPtrRelease(cefStrPtr)}
        cefObject.set_status_text(cefObjectPtr, cefStrPtr)
    }

    /// Get the response mime type.
    public func getMimeType() -> String {
        let cefStrPtr = cefObject.get_status_text(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr)}
        return CEFStringToSwiftString(cefStrPtr.memory)
    }
    
    /// Set the response mime type.
    public func setMimeType(mimeType: String) {
        let cefStrPtr = CEFStringPtrCreateFromSwiftString(mimeType)
        defer { CEFStringPtrRelease(cefStrPtr)}
        cefObject.set_status_text(cefObjectPtr, cefStrPtr)
    }

    /// Get the value for the specified response header field.
    public func getHeader(forKey key: String) -> String {
        let cefKeyPtr = CEFStringPtrCreateFromSwiftString(key)
        let cefHeaderPtr = cefObject.get_header(cefObjectPtr, cefKeyPtr)
        defer {
            CEFStringPtrRelease(cefKeyPtr)
            CEFStringPtrRelease(cefHeaderPtr)
        }
        
        return CEFStringToSwiftString(cefHeaderPtr.memory)
    }
    
    /// Get all response header fields.
    public func getHeaderMap() -> HeaderMap {
        let cefHeaderMap = cef_string_multimap_alloc()
        defer { cef_string_multimap_free(cefHeaderMap) }

        cefObject.get_header_map(cefObjectPtr, cefHeaderMap)
        return CEFStringMultimapToSwiftDictionaryOfArrays(cefHeaderMap)
    }
    
    /// Set all response header fields.
    public func setHeaderMap(headerMap: HeaderMap) {
        let cefHeaderMap = CEFStringMultimapCreateFromSwiftDictionaryOfArrays(headerMap)
        defer { cef_string_multimap_free(cefHeaderMap) }
        cefObject.set_header_map(cefObjectPtr, cefHeaderMap)
    }

    // private
    
    override init?(ptr: ObjectPtrType) {
        super.init(ptr: ptr)
    }
    
    static func fromCEF(ptr: ObjectPtrType) -> CEFResponse? {
        return CEFResponse(ptr: ptr)
    }
}
