//
//  CEFRequest.swift
//  cef
//
//  Created by Tamas Lustyik on 2015. 07. 12..
//
//

import Foundation

extension cef_request_t: CEFObject {
}


public class CEFRequest: CEFProxy<cef_request_t> {
    public typealias HeaderMap = [String:[String]]
    public typealias TransitionType = CEFTransitionType
    public typealias ResourceType = CEFResourceType
    
    public init?() {
        super.init(ptr: cef_request_create())
    }
    
    public func isReadOnly() -> Bool {
        return cefObject.is_read_only(cefObjectPtr) != 0
    }
    
    public func getURL() -> NSURL {
        let cefURLPtr = cefObject.get_url(cefObjectPtr)
        defer { CEFStringPtrRelease(cefURLPtr) }
        let urlStr = CEFStringToSwiftString(cefURLPtr.memory)
        
        return NSURL(string: urlStr)!
    }
    
    public func setURL(url: NSURL) {
        let cefURLPtr = CEFStringPtrCreateFromSwiftString(url.absoluteString)
        defer { CEFStringPtrRelease(cefURLPtr) }
        cefObject.set_url(cefObjectPtr, cefURLPtr)
    }
    
    public func getMethod() -> String {
        let cefMethodPtr = cefObject.get_method(cefObjectPtr)
        defer { CEFStringPtrRelease(cefMethodPtr) }
        return CEFStringToSwiftString(cefMethodPtr.memory)
    }
    
    public func setMethod(method: String) {
        let cefMethodPtr = CEFStringPtrCreateFromSwiftString(method)
        defer { CEFStringPtrRelease(cefMethodPtr) }
        cefObject.set_method(cefObjectPtr, cefMethodPtr)
    }
    
    public func getPOSTData() -> CEFPOSTData? {
        let cefPOSTDataPtr = cefObject.get_post_data(cefObjectPtr)
        return CEFPOSTData.fromCEF(cefPOSTDataPtr)
    }
    
    public func setPOSTData(postData: CEFPOSTData) {
        cefObject.set_post_data(cefObjectPtr, postData.toCEF())
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
    
    public func set(url: NSURL, method: String, postData: CEFPOSTData, headerMap: HeaderMap) {
        let cefURLPtr = CEFStringPtrCreateFromSwiftString(url.absoluteString)
        let cefMethodPtr = CEFStringPtrCreateFromSwiftString(method)
        let cefHeaderMap = CEFStringMultimapCreateFromSwiftDictionaryOfArrays(headerMap)
        defer {
            CEFStringPtrRelease(cefURLPtr)
            CEFStringPtrRelease(cefMethodPtr)
            cef_string_multimap_free(cefHeaderMap)
        }
        
        cefObject.set(cefObjectPtr, cefURLPtr, cefMethodPtr, postData.toCEF(), cefHeaderMap)
    }
    
    public func getFlags() -> URLRequestFlags {
        let rawFlags = cefObject.get_flags(cefObjectPtr)
        return URLRequestFlags(rawValue: UInt(rawFlags))
    }
    
    public func setFlags(flags: URLRequestFlags) {
        cefObject.set_flags(cefObjectPtr, Int32(flags.rawValue))
    }
    
    public func getFirstPartyForCookies() -> NSURL {
        let cefURL = cefObject.get_first_party_for_cookies(cefObjectPtr)
        defer { CEFStringPtrRelease(cefURL) }

        let urlStr = CEFStringToSwiftString(cefURL.memory)
        return NSURL(string: urlStr)!
    }
    
    public func setFirstPartyForCookies(url: NSURL) {
        let cefURLPtr = CEFStringPtrCreateFromSwiftString(url.absoluteString)
        defer { CEFStringPtrRelease(cefURLPtr) }
        cefObject.set_first_party_for_cookies(cefObjectPtr, cefURLPtr)
    }
    
    public func getResourceType() -> ResourceType {
        let cefRT = cefObject.get_resource_type(cefObjectPtr)
        return ResourceType.fromCEF(cefRT)
    }
    
    public func getTransitionType() -> TransitionType {
        let cefTT = cefObject.get_transition_type(cefObjectPtr)
        return TransitionType.fromCEF(cefTT)
    }
    
    public func getIdentifier() -> UInt64 {
        return cefObject.get_identifier(cefObjectPtr)
    }

    // private
    
    override init?(ptr: ObjectPtrType) {
        super.init(ptr: ptr)
    }
    
    static func fromCEF(ptr: ObjectPtrType) -> CEFRequest? {
        return CEFRequest(ptr: ptr)
    }
}

