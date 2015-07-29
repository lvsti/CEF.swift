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


public class CEFResponse: CEFProxy<cef_response_t> {
    public typealias HeaderMap = [String: [String]]
    
    public init?() {
        super.init(ptr: cef_response_create())
    }
    
    public func isReadOnly() -> Bool {
        return cefObject.is_read_only(cefObjectPtr) != 0
    }

    public func getStatus() -> Int {
        return Int(cefObject.get_status(cefObjectPtr))
    }
    
    public func setStatus(status: Int) {
        cefObject.set_status(cefObjectPtr, Int32(status))
    }
    
    public func getStatusText() -> String {
        let cefStrPtr = cefObject.get_status_text(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr)}
        return CEFStringToSwiftString(cefStrPtr.memory)
    }

    public func setStatusText(statusText: String) {
        let cefStrPtr = CEFStringPtrCreateFromSwiftString(statusText)
        defer { CEFStringPtrRelease(cefStrPtr)}
        cefObject.set_status_text(cefObjectPtr, cefStrPtr)
    }

    public func getMimeType() -> String {
        let cefStrPtr = cefObject.get_status_text(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr)}
        return CEFStringToSwiftString(cefStrPtr.memory)
    }
    
    public func setMimeType(mimeType: String) {
        let cefStrPtr = CEFStringPtrCreateFromSwiftString(mimeType)
        defer { CEFStringPtrRelease(cefStrPtr)}
        cefObject.set_status_text(cefObjectPtr, cefStrPtr)
    }

    public func getHeader(forKey key: String) -> String {
        let cefKeyPtr = CEFStringPtrCreateFromSwiftString(key)
        let cefHeaderPtr = cefObject.get_header(cefObjectPtr, cefKeyPtr)
        defer {
            CEFStringPtrRelease(cefKeyPtr)
            CEFStringPtrRelease(cefHeaderPtr)
        }
        
        return CEFStringToSwiftString(cefHeaderPtr.memory)
    }
    
    public func getHeaderMap() -> HeaderMap {
        let cefHeaderMap = cef_string_multimap_alloc()
        defer { cef_string_multimap_free(cefHeaderMap) }

        cefObject.get_header_map(cefObjectPtr, cefHeaderMap)
        return CEFStringMultimapToSwiftDictionaryOfArrays(cefHeaderMap)
    }
    
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
