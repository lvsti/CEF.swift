//
//  CEFCookieManager.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 02..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

extension cef_cookie_manager_t: CEFObject {
}


public class CEFCookieManager: CEFProxy<cef_cookie_manager_t> {

    public static func getGlobalManager(callback: CEFCompletionCallback? = nil) -> CEFCookieManager? {
        var cefCallbackPtr: UnsafeMutablePointer<cef_completion_callback_t> = nil
        if let callback = callback {
            cefCallbackPtr = callback.toCEF()
        }
        
        let cefCookieMgr = cef_cookie_manager_get_global_manager(cefCallbackPtr)
        return CEFCookieManager.fromCEF(cefCookieMgr)
    }

    public static func createManager(path: String? = nil,
                                     persistSessionCookies: Bool,
                                     callback: CEFCompletionCallback? = nil) -> CEFCookieManager? {
        let cefPathPtr = path != nil ? CEFStringPtrCreateFromSwiftString(path!) : nil
        defer { CEFStringPtrRelease(cefPathPtr) }
                                        
        var cefCallbackPtr: UnsafeMutablePointer<cef_completion_callback_t> = nil
        if let callback = callback {
            cefCallbackPtr = callback.toCEF()
        }
        
        let cefCookieMgr = cef_cookie_manager_create_manager(cefPathPtr, persistSessionCookies ? 1 : 0, cefCallbackPtr)
        return CEFCookieManager.fromCEF(cefCookieMgr)
    }
    
    public func setSupportedSchemes(schemes: [String], callback: CEFCompletionCallback? = nil) {
        let cefSchemes = CEFStringListCreateFromSwiftArray(schemes)
        defer { CEFStringListRelease(cefSchemes) }

        var cefCallbackPtr: UnsafeMutablePointer<cef_completion_callback_t> = nil
        if let callback = callback {
            cefCallbackPtr = callback.toCEF()
        }

        cefObject.set_supported_schemes(cefObjectPtr, cefSchemes, cefCallbackPtr)
    }

    public func visitAllCookies(visitor: CEFCookieVisitor) -> Bool {
        return cefObject.visit_all_cookies(cefObjectPtr, visitor.toCEF()) != 0
    }

    public func visitURLCookies(url: NSURL, includeHTTPOnly: Bool, visitor: CEFCookieVisitor) -> Bool {
        let cefURLPtr = CEFStringPtrCreateFromSwiftString(url.absoluteString)
        defer { CEFStringPtrRelease(cefURLPtr) }
        return cefObject.visit_url_cookies(cefObjectPtr, cefURLPtr, includeHTTPOnly ? 1 : 0, visitor.toCEF()) != 0
    }
    
    public func setCookie(url: NSURL, cookie: CEFCookie, callback: CEFSetCookieCallback? = nil) -> Bool {
        let cefURLPtr = CEFStringPtrCreateFromSwiftString(url.absoluteString)
        defer { CEFStringPtrRelease(cefURLPtr) }
        
        var cefCallbackPtr: UnsafeMutablePointer<cef_set_cookie_callback_t> = nil
        if let callback = callback {
            cefCallbackPtr = callback.toCEF()
        }

        var cefCookie = cookie.toCEF()
        return cefObject.set_cookie(cefObjectPtr, cefURLPtr, &cefCookie, cefCallbackPtr) != 0
    }
    
    public func deleteCookies(url: NSURL? = nil, name: String? = nil, callback: CEFDeleteCookiesCallback? = nil) -> Bool {
        let cefURLPtr = url != nil ? CEFStringPtrCreateFromSwiftString(url!.absoluteString) : nil
        let cefNamePtr = name != nil ? CEFStringPtrCreateFromSwiftString(name!) : nil
        defer {
            CEFStringPtrRelease(cefURLPtr)
            CEFStringPtrRelease(cefNamePtr)
        }

        var cefCallbackPtr: UnsafeMutablePointer<cef_delete_cookies_callback_t> = nil
        if let callback = callback {
            cefCallbackPtr = callback.toCEF()
        }
        
        return cefObject.delete_cookies(cefObjectPtr, cefURLPtr, cefNamePtr, cefCallbackPtr) != 0
    }
    
    public func setStoragePath(path: String? = nil, persistSessionCookies: Bool, callback: CEFCompletionCallback? = nil) -> Bool {
        let cefPathPtr = path != nil ? CEFStringPtrCreateFromSwiftString(path!) : nil
        defer { CEFStringPtrRelease(cefPathPtr) }
        
        var cefCallbackPtr: UnsafeMutablePointer<cef_completion_callback_t> = nil
        if let callback = callback {
            cefCallbackPtr = callback.toCEF()
        }
        
        return cefObject.set_storage_path(cefObjectPtr, cefPathPtr, persistSessionCookies ? 1 : 0, cefCallbackPtr) != 0
    }
    
    public func flushStore(callback: CEFCompletionCallback? = nil) -> Bool {
        var cefCallbackPtr: UnsafeMutablePointer<cef_completion_callback_t> = nil
        if let callback = callback {
            cefCallbackPtr = callback.toCEF()
        }
        
        return cefObject.flush_store(cefObjectPtr, cefCallbackPtr) != 0
    }
    
    // private
    
    override init?(ptr: ObjectPtrType) {
        super.init(ptr: ptr)
    }
    
    static func fromCEF(ptr: ObjectPtrType) -> CEFCookieManager? {
        return CEFCookieManager(ptr: ptr)
    }
}
