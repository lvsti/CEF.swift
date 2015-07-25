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


public class CEFRequest: CEFProxyBase<cef_request_t> {
    typealias HeaderMap = [String:[String]]
    
    struct URLRequestFlags: OptionSetType {
        let rawValue: UInt
        
        static let None = URLRequestFlags(rawValue: 0)
        static let SkipCache = URLRequestFlags(rawValue: 1 << 0)
        static let AllowCachedCredentials = URLRequestFlags(rawValue: 1 << 1)
        static let ReportUploadProgress = URLRequestFlags(rawValue: 1 << 3)
        static let ReportRawHeaders = URLRequestFlags(rawValue: 1 << 5)
        static let NoDownloadData = URLRequestFlags(rawValue: 1 << 6)
        static let NoRetryOn5XX = URLRequestFlags(rawValue: 1 << 7)

        static func fromCEF(value: cef_urlrequest_flags_t) -> URLRequestFlags {
            return URLRequestFlags(rawValue: UInt(value.rawValue))
        }
        
        func toCEF() -> cef_urlrequest_flags_t {
            return cef_urlrequest_flags_t(rawValue: UInt32(rawValue))
        }
    }
    
    enum ResourceType: UInt {
        case MainFrame = 0
        case Subframe
        case StyleSheet
        case Script
        case Image
        case FontResource
        case Subresource
        case Object
        case Media
        case Worker
        case SharedWorker
        case Prefetch
        case Favicon
        case XHR
        case Ping
        case ServiceWorker
        
        static func fromCEF(value: cef_resource_type_t) -> ResourceType {
            return ResourceType(rawValue: UInt(value.rawValue))!
        }
    }
    
    struct TransitionType: RawRepresentable {
        let rawValue: UInt
        
        enum Source: UInt8 {
            case Link = 0
            case Explicit
            case AutoSubframe
            case ManualSubframe
            case FormSubmit
            case Reload
        }
        
        struct Flags: OptionSetType {
            let rawValue: UInt
            
            static let Blocked = Flags(rawValue: 0x00800000)
            static let ForwardBack = Flags(rawValue: 0x01000000)
            static let ChainStart = Flags(rawValue: 0x10000000)
            static let ChainEnd = Flags(rawValue: 0x20000000)
            static let ClientRedirect = Flags(rawValue: 0x40000000)
            static let ServerRedirect = Flags(rawValue: 0x80000000)
            
            var isRedirect: Bool { return self.contains(.ClientRedirect) || self.contains(.ServerRedirect) }
        }
        
        var source: Source { get { return Source(rawValue: UInt8(UInt32(rawValue) & TT_SOURCE_MASK.rawValue))! } }
        var flags: Flags { get { return Flags(rawValue: UInt(UInt32(rawValue) & TT_QUALIFIER_MASK.rawValue)) } }
        
        init(rawValue: UInt) {
            self.rawValue = rawValue
        }
        
        static func fromCEF(value: cef_transition_type_t) -> TransitionType {
            return TransitionType(rawValue: UInt(value.rawValue))
        }
    }
    
    init?() {
        super.init(ptr: cef_request_create())
    }
    
    func isReadOnly() -> Bool {
        return cefObject.is_read_only(cefObjectPtr) != 0
    }
    
    func getURL() -> NSURL {
        let cefURLPtr = cefObject.get_url(cefObjectPtr)
        defer { CEFStringPtrRelease(cefURLPtr) }
        let urlStr = CEFStringToSwiftString(cefURLPtr.memory)
        
        return NSURL(string: urlStr)!
    }
    
    func setURL(url: NSURL) {
        let cefURLPtr = CEFStringPtrCreateFromSwiftString(url.absoluteString)
        defer { CEFStringPtrRelease(cefURLPtr) }
        cefObject.set_url(cefObjectPtr, cefURLPtr)
    }
    
    func getMethod() -> String {
        let cefMethodPtr = cefObject.get_method(cefObjectPtr)
        defer { CEFStringPtrRelease(cefMethodPtr) }
        return CEFStringToSwiftString(cefMethodPtr.memory)
    }
    
    func setMethod(method: String) {
        let cefMethodPtr = CEFStringPtrCreateFromSwiftString(method)
        defer { CEFStringPtrRelease(cefMethodPtr) }
        cefObject.set_method(cefObjectPtr, cefMethodPtr)
    }
    
    func getPOSTData() -> CEFPOSTData? {
        let cefPOSTDataPtr = cefObject.get_post_data(cefObjectPtr)
        return CEFPOSTData.fromCEF(cefPOSTDataPtr)
    }
    
    func setPOSTData(postData: CEFPOSTData) {
        cefObject.set_post_data(cefObjectPtr, postData.cefObjectPtr)
    }
    
    func getHeaderMap() -> HeaderMap {
        let cefHeaderMap = cef_string_multimap_alloc()
        defer { cef_string_multimap_free(cefHeaderMap) }
        cefObject.get_header_map(cefObjectPtr, cefHeaderMap)
        return CEFStringMultimapToSwiftDictionaryOfArrays(cefHeaderMap)
    }
    
    func setHeaderMap(headerMap: HeaderMap) {
        let cefHeaderMap = CEFStringMultimapCreateFromSwiftDictionaryOfArrays(headerMap)
        defer { cef_string_multimap_free(cefHeaderMap) }
        cefObject.set_header_map(cefObjectPtr, cefHeaderMap)
    }
    
    func set(url: NSURL, method: String, postData: CEFPOSTData, headerMap: HeaderMap) {
        let cefURLPtr = CEFStringPtrCreateFromSwiftString(url.absoluteString)
        let cefMethodPtr = CEFStringPtrCreateFromSwiftString(method)
        let cefHeaderMap = CEFStringMultimapCreateFromSwiftDictionaryOfArrays(headerMap)
        defer {
            CEFStringPtrRelease(cefURLPtr)
            CEFStringPtrRelease(cefMethodPtr)
            cef_string_multimap_free(cefHeaderMap)
        }
        
        cefObject.set(cefObjectPtr, cefURLPtr, cefMethodPtr, postData.cefObjectPtr, cefHeaderMap)
    }
    
    func getFlags() -> URLRequestFlags {
        let rawFlags = cefObject.get_flags(cefObjectPtr)
        return URLRequestFlags(rawValue: UInt(rawFlags))
    }
    
    func setFlags(flags: URLRequestFlags) {
        cefObject.set_flags(cefObjectPtr, Int32(flags.rawValue))
    }
    
    func getFirstPartyForCookies() -> NSURL {
        let cefURL = cefObject.get_first_party_for_cookies(cefObjectPtr)
        defer { CEFStringPtrRelease(cefURL) }

        let urlStr = CEFStringToSwiftString(cefURL.memory)
        return NSURL(string: urlStr)!
    }
    
    func setFirstPartyForCookies(url: NSURL) {
        let cefURLPtr = CEFStringPtrCreateFromSwiftString(url.absoluteString)
        defer { CEFStringPtrRelease(cefURLPtr) }
        cefObject.set_first_party_for_cookies(cefObjectPtr, cefURLPtr)
    }
    
    func getResourceType() -> ResourceType {
        let cefRT = cefObject.get_resource_type(cefObjectPtr)
        return ResourceType.fromCEF(cefRT)
    }
    
    func getTransitionType() -> TransitionType {
        let cefTT = cefObject.get_transition_type(cefObjectPtr)
        return TransitionType.fromCEF(cefTT)
    }
    
    func getIdentifier() -> UInt64 {
        return cefObject.get_identifier(cefObjectPtr)
    }

}

