//
//  CEFRequest.swift
//  cef
//
//  Created by Tamas Lustyik on 2015. 07. 12..
//
//

import Foundation

public extension CEFRequest {
    public typealias HeaderMap = [String: [String]]
    
    /// Create a new CefRequest object.
    /// CEF name: `Create`
    public convenience init?() {
        self.init(ptr: cef_request_create())
    }
    
    /// Returns true if this object is read-only.
    /// CEF name: `IsReadOnly`
    public var isReadOnly: Bool {
        return cefObject.is_read_only(cefObjectPtr) != 0
    }
    
    /// Fully qualified URL.
    /// CEF name: `GetURL`, `SetURL`
    public var url: URL? {
        get { return getURL() }
        set { setURL(newValue) }
    }
    
    /// Get the fully qualified URL.
    private func getURL() -> URL? {
        let cefURLPtr = cefObject.get_url(cefObjectPtr)
        defer { CEFStringPtrRelease(cefURLPtr) }

        guard let urlStr = CEFStringPtrToSwiftString(cefURLPtr) else {
            return nil
        }
        return URL(string: urlStr)
    }
    
    /// Set the fully qualified URL.
    private func setURL(_ url: URL?) {
        let cefURLPtr = CEFStringPtrCreateFromSwiftString(url?.absoluteString ?? "")
        defer { CEFStringPtrRelease(cefURLPtr) }
        cefObject.set_url(cefObjectPtr, cefURLPtr)
    }
    
    /// Request method type. The value will default to POST if post data
    /// is provided and GET otherwise.
    /// CEF name: `GetMethod`, `SetMethod`
    public var method: String {
        get { return getMethod() }
        set { setMethod(newValue) }
    }
    
    /// Get the request method type. The value will default to POST if post data
    /// is provided and GET otherwise.
    private func getMethod() -> String {
        let cefMethodPtr = cefObject.get_method(cefObjectPtr)
        defer { CEFStringPtrRelease(cefMethodPtr) }
        return CEFStringToSwiftString(cefMethodPtr!.pointee)
    }
    
    /// Set the request method type.
    private func setMethod(_ method: String) {
        let cefMethodPtr = CEFStringPtrCreateFromSwiftString(method)
        defer { CEFStringPtrRelease(cefMethodPtr) }
        cefObject.set_method(cefObjectPtr, cefMethodPtr)
    }
    
    /// Set the referrer URL and policy. If non-empty the referrer URL must be
    /// fully qualified with an HTTP or HTTPS scheme component. Any username,
    /// password or ref component will be removed.
    /// CEF name: `GetReferrerURL`, `SetReferrer`
    public var referrerURL: URL? {
        get { return getReferrerURL() }
        set { setReferrerURL(newValue, policy: referrerPolicy) }
    }
    
    /// Get the referrer policy.
    /// CEF name: `GetReferrerPolicy`, `SetReferrer`
    public var referrerPolicy: CEFReferrerPolicy {
        get { return getReferrerPolicy() }
        set { setReferrerURL(referrerURL, policy: newValue) }
    }
    
    private func getReferrerURL() -> URL? {
        let cefURLPtr = cefObject.get_referrer_url(cefObjectPtr)
        defer { CEFStringPtrRelease(cefURLPtr) }
        guard let str = CEFStringPtrToSwiftString(cefURLPtr) else {
            return nil
        }
        return URL(string: str)
    }
    
    private func getReferrerPolicy() -> CEFReferrerPolicy {
        let cefPolicy = cefObject.get_referrer_policy(cefObjectPtr)
        return CEFReferrerPolicy.fromCEF(cefPolicy)
    }
    
    private func setReferrerURL(_ url: URL?, policy: CEFReferrerPolicy) {
        let cefURLPtr = url != nil ? CEFStringPtrCreateFromSwiftString(url!.absoluteString) : nil
        defer { CEFStringPtrRelease(cefURLPtr) }
        cefObject.set_referrer(cefObjectPtr, cefURLPtr, policy.toCEF())
    }

    /// Get the post data.
    /// CEF name: `GetPostData`, `SetPostData`
    public var postData: CEFPOSTData? {
        get {
            let cefPOSTDataPtr = cefObject.get_post_data(cefObjectPtr)
            return CEFPOSTData.fromCEF(cefPOSTDataPtr)
        }
        set { cefObject.set_post_data(cefObjectPtr, newValue != nil ? newValue!.toCEF() : nil) }
    }
    
    /// Header values. Will not include the Referer value if any.
    /// CEF name: `GetHeaderMap`, `SetHeaderMap`
    public var headers: HeaderMap {
        get { return getHeaderMap() }
        set { setHeaderMap(newValue) }
    }
    
    /// Get the header values. Will not include the Referer value if any.
    private func getHeaderMap() -> HeaderMap {
        let cefHeaderMap = cef_string_multimap_alloc()
        defer { cef_string_multimap_free(cefHeaderMap) }
        cefObject.get_header_map(cefObjectPtr, cefHeaderMap)
        return CEFStringMultimapToSwiftDictionaryOfArrays(cefHeaderMap)
    }
    
    /// Set the header values. If a Referer value exists in the header map it will
    /// be removed and ignored.
    private func setHeaderMap(_ headerMap: HeaderMap) {
        let cefHeaderMap = CEFStringMultimapCreateFromSwiftDictionaryOfArrays(headerMap)
        defer { cef_string_multimap_free(cefHeaderMap) }
        cefObject.set_header_map(cefObjectPtr, cefHeaderMap)
    }
    
    /// Set all values at one time.
    /// CEF name: `Set`
    public func set(url: URL, method: String, postData: CEFPOSTData? = nil, headers: HeaderMap) {
        let cefURLPtr = CEFStringPtrCreateFromSwiftString(url.absoluteString)
        let cefMethodPtr = CEFStringPtrCreateFromSwiftString(method)
        let cefHeaderMap = CEFStringMultimapCreateFromSwiftDictionaryOfArrays(headers)
        let cefData = postData?.toCEF()
        defer {
            CEFStringPtrRelease(cefURLPtr)
            CEFStringPtrRelease(cefMethodPtr)
            cef_string_multimap_free(cefHeaderMap)
        }
        
        cefObject.set(cefObjectPtr, cefURLPtr, cefMethodPtr, cefData, cefHeaderMap)
    }
    
    /// The flags used in combination with CefURLRequest. See
    /// cef_urlrequest_flags_t for supported values.
    /// CEF name: `GetFlags`, `SetFlags`
    public var flags: CEFURLRequestFlags {
        get {
            let cefFlags = cefObject.get_flags(cefObjectPtr)
            return CEFURLRequestFlags(rawValue: UInt32(cefFlags))
        }
        set { cefObject.set_flags(cefObjectPtr, Int32(flags.rawValue)) }
    }

    /// The URL to the first party for cookies used in combination with
    /// CefURLRequest.
    /// CEF name: `GetFirstPartyForCookies`, `SetFirstPartyForCookies`
    public var firstPartyURLForCookies: URL {
        get { return getFirstPartyURLForCookies() }
        set { setFirstPartyURLForCookies(newValue) }
    }

    /// Set the URL to the first party for cookies used in combination with
    /// CefURLRequest.
    private func getFirstPartyURLForCookies() -> URL {
        let cefURL = cefObject.get_first_party_for_cookies(cefObjectPtr)
        defer { CEFStringPtrRelease(cefURL) }

        let urlStr = CEFStringToSwiftString(cefURL!.pointee)
        return URL(string: urlStr)!
    }
    
    /// Get the URL to the first party for cookies used in combination with
    /// CefURLRequest.
    private func setFirstPartyURLForCookies(_ url: URL) {
        let cefURLPtr = CEFStringPtrCreateFromSwiftString(url.absoluteString)
        defer { CEFStringPtrRelease(cefURLPtr) }
        cefObject.set_first_party_for_cookies(cefObjectPtr, cefURLPtr)
    }
    
    /// Get the resource type for this request. Only available in the browser
    /// process.
    /// CEF name: `GetResourceType`
    public var resourceType: CEFResourceType {
        let cefRT = cefObject.get_resource_type(cefObjectPtr)
        return CEFResourceType.fromCEF(cefRT)
    }
    
    /// Get the transition type for this request. Only available in the browser
    /// process and only applies to requests that represent a main frame or
    /// sub-frame navigation.
    /// CEF name: `GetTransitionType`
    public var transitionType: CEFTransitionType {
        let cefTT = cefObject.get_transition_type(cefObjectPtr)
        return CEFTransitionType.fromCEF(cefTT)
    }
    
    /// Returns the globally unique identifier for this request or 0 if not
    /// specified. Can be used by CefRequestHandler implementations in the browser
    /// process to track a single request across multiple callbacks.
    /// CEF name: `GetIdentifier`
    public var identifier: UInt64? {
        let cefID = cefObject.get_identifier(cefObjectPtr)
        return cefID != 0 ? cefID : nil
    }

}

