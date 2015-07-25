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
    
    struct RequestFlags: OptionSetType {
        let rawValue: UInt
        
        static let None = RequestFlags(rawValue: 0)
        static let SkipCache = RequestFlags(rawValue: 1 << 0)
        static let AllowCachedCredentials = RequestFlags(rawValue: 1 << 1)
        static let ReportUploadProgress = RequestFlags(rawValue: 1 << 3)
        static let ReportRawHeaders = RequestFlags(rawValue: 1 << 5)
        static let NoDownloadData = RequestFlags(rawValue: 1 << 6)
        static let NoRetryOn5XX = RequestFlags(rawValue: 1 << 7)
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
    }
    
    struct TransitionType {
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
        
        let source: Source
        let flags: Flags
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
    
    func getFlags() -> RequestFlags {
        let rawFlags:UInt = UInt(cefObject.get_flags(cefObjectPtr))
        return RequestFlags(rawValue: rawFlags)
    }
    
    func setFlags(flags: RequestFlags) {
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
        let rawValue = cefObject.get_resource_type(cefObjectPtr).rawValue
        return ResourceType(rawValue: UInt(rawValue))!
    }
    
    func getTransitionType() -> TransitionType {
        let rawValue = cefObject.get_transition_type(cefObjectPtr).rawValue
        let source = TransitionType.Source(rawValue: UInt8(rawValue & TT_SOURCE_MASK.rawValue))!
        let flags = UInt(rawValue & TT_QUALIFIER_MASK.rawValue)
        return TransitionType(source: source, flags: TransitionType.Flags(rawValue: flags))
    }
    
    func getIdentifier() -> UInt64 {
        return cefObject.get_identifier(cefObjectPtr)
    }

}

