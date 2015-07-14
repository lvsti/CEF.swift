//
//  CEFResponse.swift
//  cef
//
//  Created by Tamas Lustyik on 2015. 07. 11..
//
//

import Foundation

extension cef_response_t: CEFObject {
    public var base: cef_base_t { get { return self.base } nonmutating set { } }
}


public class CEFResponse: CEFBase<cef_response_t> {
    typealias HeaderMap = [String: [String]]
    
    override init?(ptr: UnsafeMutablePointer<cef_response_t>) {
        super.init(ptr: ptr)
    }
    
    static func fromCEF(ptr: UnsafeMutablePointer<cef_response_t>) -> CEFResponse? {
        return CEFResponse(ptr: ptr)
    }
    
    func toCEF() -> UnsafeMutablePointer<cef_response_t> {
        addRef()
        return cefObjectPtr
    }
    
    static func create() -> CEFResponse? {
        return CEFResponse.fromCEF(cef_response_create())
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
        cef_string_userfree_utf16_free(cefStrPtr)
        
        return retval
    }

    func setStatusText(statusText: String) {
        let cefStrPtr = CEFStringPtrFromSwiftString(statusText)
        cefObject.set_status_text(cefObjectPtr, cefStrPtr)
        cef_string_userfree_utf16_free(cefStrPtr)
    }

    func getMimeType() -> String {
        let cefStrPtr = cefObject.get_status_text(cefObjectPtr)
        let retval = CEFStringToSwiftString(cefStrPtr.memory)
        cef_string_userfree_utf16_free(cefStrPtr)
        
        return retval
    }
    
    func setMimeType(mimeType: String) {
        let cefStrPtr = CEFStringPtrFromSwiftString(mimeType)
        cefObject.set_status_text(cefObjectPtr, cefStrPtr)
        cef_string_userfree_utf16_free(cefStrPtr)
    }

    func getHeader(forKey key: String) -> String {
        let cefKeyPtr = CEFStringPtrFromSwiftString(key)
        let cefHeaderPtr = cefObject.get_header(cefObjectPtr, cefKeyPtr)
        cef_string_userfree_utf16_free(cefKeyPtr)
        
        let retval = CEFStringToSwiftString(cefHeaderPtr.memory)
        cef_string_userfree_utf16_free(cefHeaderPtr)
        
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
        let cefHeaderMap = CEFStringMultimapFromSwiftDictionaryOfArrays(headerMap)
        cefObject.set_header_map(cefObjectPtr, cefHeaderMap)
        cef_string_multimap_free(cefHeaderMap)
    }
}
