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
    
    init() {
        super.init(pointer: cef_response_create())
    }
    
    override init(proxiedObject obj: cef_response_t) {
        super.init(proxiedObject: obj)
    }
    
    func isReadOnly() -> Bool {
        return object.is_read_only(cefSelf) != 0
    }

    func getStatus() -> Int {
        return Int(object.get_status(cefSelf))
    }
    
    func setStatus(status: Int) {
        object.set_status(cefSelf, Int32(status))
    }
    
    func getStatusText() -> String {
        let cefStrPtr = object.get_status_text(cefSelf)
        let retval = CEFStringToSwiftString(cefStrPtr.memory)
        cef_string_userfree_utf16_free(cefStrPtr)
        
        return retval
    }

    func setStatusText(statusText: String) {
        let cefStrPtr = CEFStringPtrFromSwiftString(statusText)
        object.set_status_text(cefSelf, cefStrPtr)
        cef_string_userfree_utf16_free(cefStrPtr)
    }

    func getMimeType() -> String {
        let cefStrPtr = object.get_status_text(cefSelf)
        let retval = CEFStringToSwiftString(cefStrPtr.memory)
        cef_string_userfree_utf16_free(cefStrPtr)
        
        return retval
    }
    
    func setMimeType(mimeType: String) {
        let cefStrPtr = CEFStringPtrFromSwiftString(mimeType)
        object.set_status_text(cefSelf, cefStrPtr)
        cef_string_userfree_utf16_free(cefStrPtr)
    }

    func getHeader(forKey key: String) -> String {
        let cefKeyPtr = CEFStringPtrFromSwiftString(key)
        let cefHeaderPtr = object.get_header(cefSelf, cefKeyPtr)
        cef_string_userfree_utf16_free(cefKeyPtr)
        
        let retval = CEFStringToSwiftString(cefHeaderPtr.memory)
        cef_string_userfree_utf16_free(cefHeaderPtr)
        
        return retval
    }
    
    func getHeaderMap() -> HeaderMap {
        let cefHeaderMap = cef_string_multimap_alloc()
        object.get_header_map(cefSelf, cefHeaderMap)
        
        let retval = CEFStringMultimapToSwiftDictionaryOfArrays(cefHeaderMap)
        cef_string_multimap_free(cefHeaderMap)
        
        return retval
    }
    
    func setHeaderMap(headerMap: HeaderMap) {
        let cefHeaderMap = CEFStringMultimapFromSwiftDictionaryOfArrays(headerMap)
        object.set_header_map(cefSelf, cefHeaderMap)
        cef_string_multimap_free(cefHeaderMap)
    }
}
