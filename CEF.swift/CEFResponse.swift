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


public class CEFResponse: CEFProxyBase<cef_response_t> {
    typealias HeaderMap = [String: [String]]
    
    init?() {
        super.init(ptr: cef_response_create())
    }
    
    func isReadOnly() -> Bool {
        return cefObject.is_read_only(cefObjectPtr) != 0
    }

    func getStatus() -> Int {
        return Int(cefObject.get_status(cefObjectPtr))
    }
    
    func setStatus(status: Int) {
        cefObject.set_status(cefObjectPtr, Int32(status))
    }
    
    func getStatusText() -> String {
        let cefStrPtr = cefObject.get_status_text(cefObjectPtr)
        let retval = CEFStringToSwiftString(cefStrPtr.memory)
        CEFStringPtrRelease(cefStrPtr)
        
        return retval
    }

    func setStatusText(statusText: String) {
        let cefStrPtr = CEFStringPtrCreateFromSwiftString(statusText)
        cefObject.set_status_text(cefObjectPtr, cefStrPtr)
        CEFStringPtrRelease(cefStrPtr)
    }

    func getMimeType() -> String {
        let cefStrPtr = cefObject.get_status_text(cefObjectPtr)
        let retval = CEFStringToSwiftString(cefStrPtr.memory)
        CEFStringPtrRelease(cefStrPtr)
        
        return retval
    }
    
    func setMimeType(mimeType: String) {
        let cefStrPtr = CEFStringPtrCreateFromSwiftString(mimeType)
        cefObject.set_status_text(cefObjectPtr, cefStrPtr)
        CEFStringPtrRelease(cefStrPtr)
    }

    func getHeader(forKey key: String) -> String {
        let cefKeyPtr = CEFStringPtrCreateFromSwiftString(key)
        let cefHeaderPtr = cefObject.get_header(cefObjectPtr, cefKeyPtr)
        CEFStringPtrRelease(cefKeyPtr)
        
        let retval = CEFStringToSwiftString(cefHeaderPtr.memory)
        CEFStringPtrRelease(cefHeaderPtr)
        
        return retval
    }
    
    func getHeaderMap() -> HeaderMap {
        let cefHeaderMap = cef_string_multimap_alloc()
        cefObject.get_header_map(cefObjectPtr, cefHeaderMap)
        
        let retval = CEFStringMultimapToSwiftDictionaryOfArrays(cefHeaderMap)
        cef_string_multimap_free(cefHeaderMap)
        
        return retval
    }
    
    func setHeaderMap(headerMap: HeaderMap) {
        let cefHeaderMap = CEFStringMultimapCreateFromSwiftDictionaryOfArrays(headerMap)
        cefObject.set_header_map(cefObjectPtr, cefHeaderMap)
        cef_string_multimap_free(cefHeaderMap)
    }
}
