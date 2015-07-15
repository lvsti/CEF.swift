//
//  CEFRequest.swift
//  cef
//
//  Created by Tamas Lustyik on 2015. 07. 12..
//
//

import Foundation

extension cef_request_t: CEFObject {
    public var base: cef_base_t { get { return self.base } nonmutating set { } }
}


public class CEFRequest: CEFBase<cef_request_t> {
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
        let urlStr = CEFStringToSwiftString(cefURLPtr.memory)
        cef_string_userfree_utf16_free(cefURLPtr)
        
        return NSURL(string: urlStr)!
    }
    
    func setURL(url: NSURL) {
        let cefURLPtr = CEFStringPtrFromSwiftString(url.absoluteString)
        cefObject.set_url(cefObjectPtr, cefURLPtr)
        cef_string_userfree_utf16_free(cefURLPtr)
    }
    
    func getMethod() -> String {
        let cefMethodPtr = cefObject.get_method(cefObjectPtr)
        let retval = CEFStringToSwiftString(cefMethodPtr.memory)
        cef_string_userfree_utf16_free(cefMethodPtr)
        
        return retval
    }
    
    func setMethod(method: String) {
        let cefMethodPtr = CEFStringPtrFromSwiftString(method)
        cefObject.set_method(cefObjectPtr, cefMethodPtr)
        cef_string_userfree_utf16_free(cefMethodPtr)
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
    
    func set(url: NSURL, method: String, postData: CEFPOSTData, headerMap: HeaderMap) {
        let cefURLPtr = CEFStringPtrFromSwiftString(url.absoluteString)
        let cefMethodPtr = CEFStringPtrFromSwiftString(method)
        let cefHeaderMap = CEFStringMultimapFromSwiftDictionaryOfArrays(headerMap)
        
        cefObject.set(cefObjectPtr, cefURLPtr, cefMethodPtr, postData.cefObjectPtr, cefHeaderMap)
        
        cef_string_userfree_utf16_free(cefURLPtr)
        cef_string_userfree_utf16_free(cefMethodPtr)
        cef_string_multimap_free(cefHeaderMap)
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
        let urlStr = CEFStringToSwiftString(cefURL.memory)
        cef_string_userfree_utf16_free(cefURL)
        
        return NSURL(string: urlStr)!
    }
    
    func setFirstPartyForCookies(url: NSURL) {
        let cefURLPtr = CEFStringPtrFromSwiftString(url.absoluteString)
        cefObject.set_first_party_for_cookies(cefObjectPtr, cefURLPtr)
        cef_string_userfree_utf16_free(cefURLPtr)
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

