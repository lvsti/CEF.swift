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


/// Class used to represent a web request. The methods of this class may be
/// called on any thread.
public class CEFRequest: CEFProxy<cef_request_t> {
    public typealias HeaderMap = [String:[String]]
    
    /// Create a new CefRequest object.
    public init?() {
        super.init(ptr: cef_request_create())
    }
    
    /// Returns true if this object is read-only.
    public func isReadOnly() -> Bool {
        return cefObject.is_read_only(cefObjectPtr) != 0
    }
    
    /// Get the fully qualified URL.
    public func getURL() -> NSURL {
        let cefURLPtr = cefObject.get_url(cefObjectPtr)
        defer { CEFStringPtrRelease(cefURLPtr) }
        let urlStr = CEFStringToSwiftString(cefURLPtr.memory)
        
        return NSURL(string: urlStr)!
    }
    
    /// Set the fully qualified URL.
    public func setURL(url: NSURL) {
        let cefURLPtr = CEFStringPtrCreateFromSwiftString(url.absoluteString)
        defer { CEFStringPtrRelease(cefURLPtr) }
        cefObject.set_url(cefObjectPtr, cefURLPtr)
    }
    
    /// Get the request method type. The value will default to POST if post data
    /// is provided and GET otherwise.
    public func getMethod() -> String {
        let cefMethodPtr = cefObject.get_method(cefObjectPtr)
        defer { CEFStringPtrRelease(cefMethodPtr) }
        return CEFStringToSwiftString(cefMethodPtr.memory)
    }
    
    /// Set the request method type.
    public func setMethod(method: String) {
        let cefMethodPtr = CEFStringPtrCreateFromSwiftString(method)
        defer { CEFStringPtrRelease(cefMethodPtr) }
        cefObject.set_method(cefObjectPtr, cefMethodPtr)
    }
    
    /// Get the post data.
    public func getPOSTData() -> CEFPOSTData? {
        let cefPOSTDataPtr = cefObject.get_post_data(cefObjectPtr)
        return CEFPOSTData.fromCEF(cefPOSTDataPtr)
    }
    
    /// Set the post data.
    public func setPOSTData(postData: CEFPOSTData) {
        cefObject.set_post_data(cefObjectPtr, postData.toCEF())
    }
    
    /// Get the header values.
    public func getHeaderMap() -> HeaderMap {
        let cefHeaderMap = cef_string_multimap_alloc()
        defer { cef_string_multimap_free(cefHeaderMap) }
        cefObject.get_header_map(cefObjectPtr, cefHeaderMap)
        return CEFStringMultimapToSwiftDictionaryOfArrays(cefHeaderMap)
    }
    
    /// Set the header values.
    public func setHeaderMap(headerMap: HeaderMap) {
        let cefHeaderMap = CEFStringMultimapCreateFromSwiftDictionaryOfArrays(headerMap)
        defer { cef_string_multimap_free(cefHeaderMap) }
        cefObject.set_header_map(cefObjectPtr, cefHeaderMap)
    }
    
    /// Set all values at one time.
    public func set(url: NSURL, method: String, postData: CEFPOSTData? = nil, headerMap: HeaderMap) {
        let cefURLPtr = CEFStringPtrCreateFromSwiftString(url.absoluteString)
        let cefMethodPtr = CEFStringPtrCreateFromSwiftString(method)
        let cefHeaderMap = CEFStringMultimapCreateFromSwiftDictionaryOfArrays(headerMap)
        let cefData = postData != nil ? postData!.toCEF() : nil
        defer {
            CEFStringPtrRelease(cefURLPtr)
            CEFStringPtrRelease(cefMethodPtr)
            cef_string_multimap_free(cefHeaderMap)
        }
        
        cefObject.set(cefObjectPtr, cefURLPtr, cefMethodPtr, cefData, cefHeaderMap)
    }
    
    /// Get the flags used in combination with CefURLRequest. See
    /// cef_urlrequest_flags_t for supported values.
    public func getFlags() -> CEFURLRequestFlags {
        let cefFlags = cefObject.get_flags(cefObjectPtr)
        return CEFURLRequestFlags(rawValue: UInt32(cefFlags))
    }
    
    /// Set the flags used in combination with CefURLRequest.  See
    /// cef_urlrequest_flags_t for supported values.
    public func setFlags(flags: CEFURLRequestFlags) {
        cefObject.set_flags(cefObjectPtr, Int32(flags.rawValue))
    }
    
    /// Set the URL to the first party for cookies used in combination with
    /// CefURLRequest.
    public func getFirstPartyForCookies() -> NSURL {
        let cefURL = cefObject.get_first_party_for_cookies(cefObjectPtr)
        defer { CEFStringPtrRelease(cefURL) }

        let urlStr = CEFStringToSwiftString(cefURL.memory)
        return NSURL(string: urlStr)!
    }
    
    /// Get the URL to the first party for cookies used in combination with
    /// CefURLRequest.
    public func setFirstPartyForCookies(url: NSURL) {
        let cefURLPtr = CEFStringPtrCreateFromSwiftString(url.absoluteString)
        defer { CEFStringPtrRelease(cefURLPtr) }
        cefObject.set_first_party_for_cookies(cefObjectPtr, cefURLPtr)
    }
    
    /// Get the resource type for this request. Only available in the browser
    /// process.
    public func getResourceType() -> CEFResourceType {
        let cefRT = cefObject.get_resource_type(cefObjectPtr)
        return CEFResourceType.fromCEF(cefRT)
    }
    
    /// Get the transition type for this request. Only available in the browser
    /// process and only applies to requests that represent a main frame or
    /// sub-frame navigation.
    public func getTransitionType() -> CEFTransitionType {
        let cefTT = cefObject.get_transition_type(cefObjectPtr)
        return CEFTransitionType.fromCEF(cefTT)
    }
    
    /// Returns the globally unique identifier for this request or 0 if not
    /// specified. Can be used by CefRequestHandler implementations in the browser
    /// process to track a single request across multiple callbacks.
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

