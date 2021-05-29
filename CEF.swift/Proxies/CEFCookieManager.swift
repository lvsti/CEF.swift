//
//  CEFCookieManager.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 02..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

public extension CEFCookieManager {

    /// Returns the global cookie manager. By default data will be stored at
    /// CefSettings.cache_path if specified or in memory otherwise. If |callback|
    /// is non-NULL it will be executed asnychronously on the UI thread after the
    /// manager's storage has been initialized. Using this method is equivalent to
    /// calling CefRequestContext::GetGlobalContext()->GetDefaultCookieManager().
    /// CEF name: `GetGlobalManager`
    public static func globalManager(callback: CEFCompletionCallback? = nil) -> CEFCookieManager {
        let cefCallbackPtr = callback?.toCEF()
        let cefCookieMgr = cef_cookie_manager_get_global_manager(cefCallbackPtr)
        return CEFCookieManager.fromCEF(cefCookieMgr)!
    }
    
    /// Visit all cookies on the UI thread. The returned cookies are ordered by
    /// longest path, then by earliest creation date. Returns false if cookies
    /// cannot be accessed.
    /// CEF name: `VisitAllCookies`
    @discardableResult
    public func enumerateAllCookies(with visitor: CEFCookieVisitor) -> Bool {
        return cefObject.visit_all_cookies(cefObjectPtr, visitor.toCEF()) != 0
    }

    /// Visit a subset of cookies on the UI thread. The results are filtered by the
    /// given url scheme, host, domain and path. If |includeHttpOnly| is true
    /// HTTP-only cookies will also be included in the results. The returned
    /// cookies are ordered by longest path, then by earliest creation date.
    /// Returns false if cookies cannot be accessed.
    /// CEF name: `VisitUrlCookies`
    @discardableResult
    public func enumerateCookies(for url: URL, includeHTTPOnly: Bool, with visitor: CEFCookieVisitor) -> Bool {
        let cefURLPtr = CEFStringPtrCreateFromSwiftString(url.absoluteString)
        defer { CEFStringPtrRelease(cefURLPtr) }
        return cefObject.visit_url_cookies(cefObjectPtr, cefURLPtr, includeHTTPOnly ? 1 : 0, visitor.toCEF()) != 0
    }
    
    /// Sets a cookie given a valid URL and explicit user-provided cookie
    /// attributes. This function expects each attribute to be well-formed. It will
    /// check for disallowed characters (e.g. the ';' character is disallowed
    /// within the cookie value attribute) and fail without setting the cookie if
    /// such characters are found. If |callback| is non-NULL it will be executed
    /// asnychronously on the UI thread after the cookie has been set. Returns
    /// false if an invalid URL is specified or if cookies cannot be accessed.
    /// CEF name: `SetCookie`
    @discardableResult
    public func setCookie(_ cookie: CEFCookie, for url: URL, callback: CEFSetCookieCallback? = nil) -> Bool {
        let cefURLPtr = CEFStringPtrCreateFromSwiftString(url.absoluteString)
        defer { CEFStringPtrRelease(cefURLPtr) }
        
        let cefCallbackPtr = callback?.toCEF()

        var cefCookie = cookie.toCEF()
        defer { cefCookie.clear() }
        
        return cefObject.set_cookie(cefObjectPtr, cefURLPtr, &cefCookie, cefCallbackPtr) != 0
    }
    
    /// Delete all cookies that match the specified parameters. If both |url| and
    /// |cookie_name| values are specified all host and domain cookies matching
    /// both will be deleted. If only |url| is specified all host cookies (but not
    /// domain cookies) irrespective of path will be deleted. If |url| is empty all
    /// cookies for all hosts and domains will be deleted. If |callback| is
    /// non-NULL it will be executed asnychronously on the UI thread after the
    /// cookies have been deleted. Returns false if a non-empty invalid URL is
    /// specified or if cookies cannot be accessed. Cookies can alternately be
    /// deleted using the Visit*Cookies() methods.
    /// CEF name: `DeleteCookies`
    @discardableResult
    public func deleteCookies(url: URL? = nil, name: String? = nil, callback: CEFDeleteCookiesCallback? = nil) -> Bool {
        let cefURLPtr = url != nil ? CEFStringPtrCreateFromSwiftString(url!.absoluteString) : nil
        let cefNamePtr = name != nil ? CEFStringPtrCreateFromSwiftString(name!) : nil
        defer {
            CEFStringPtrRelease(cefURLPtr)
            CEFStringPtrRelease(cefNamePtr)
        }

        let cefCallbackPtr = callback?.toCEF()
        
        return cefObject.delete_cookies(cefObjectPtr, cefURLPtr, cefNamePtr, cefCallbackPtr) != 0
    }
    
    /// Flush the backing store (if any) to disk. If |callback| is non-NULL it will
    /// be executed asnychronously on the UI thread after the flush is complete.
    /// Returns false if cookies cannot be accessed.
    /// CEF name: `FlushStore`
    @discardableResult
    public func flushStore(callback: CEFCompletionCallback? = nil) -> Bool {
        let cefCallbackPtr = callback?.toCEF()
        return cefObject.flush_store(cefObjectPtr, cefCallbackPtr) != 0
    }
    
}


public extension CEFCookieManager {

    /// Returns the global cookie manager. By default data will be stored at
    /// CefSettings.cache_path if specified or in memory otherwise. If |callback|
    /// is non-NULL it will be executed asnychronously on the UI thread after the
    /// manager's storage has been initialized. Using this method is equivalent to
    /// calling CefRequestContext::GetGlobalContext()->GetDefaultCookieManager().
    /// CEF name: `GetGlobalManager`
    public static func globalManager(block: @escaping CEFCompletionCallbackOnCompleteBlock) -> CEFCookieManager? {
        return CEFCookieManager.globalManager(callback: CEFCompletionCallbackBridge(block: block))
    }

    /// Visit all cookies on the UI thread. The returned cookies are ordered by
    /// longest path, then by earliest creation date. Returns false if cookies
    /// cannot be accessed.
    /// CEF name: `VisitAllCookies`
    @discardableResult
    public func enumerateAllCookies(block: @escaping CEFCookieVisitorVisitBlock) -> Bool {
        return enumerateAllCookies(with: CEFCookieVisitorBridge(block: block))
    }
    
    /// Visit a subset of cookies on the UI thread. The results are filtered by the
    /// given url scheme, host, domain and path. If |includeHttpOnly| is true
    /// HTTP-only cookies will also be included in the results. The returned
    /// cookies are ordered by longest path, then by earliest creation date.
    /// Returns false if cookies cannot be accessed.
    /// CEF name: `VisitUrlCookies`
    @discardableResult
    public func enumerateCookies(for url: URL, includeHTTPOnly: Bool, block: @escaping CEFCookieVisitorVisitBlock) -> Bool {
        return enumerateCookies(for: url, includeHTTPOnly: includeHTTPOnly, with: CEFCookieVisitorBridge(block: block))
    }

    /// Sets a cookie given a valid URL and explicit user-provided cookie
    /// attributes. This function expects each attribute to be well-formed. It will
    /// check for disallowed characters (e.g. the ';' character is disallowed
    /// within the cookie value attribute) and fail without setting the cookie if
    /// such characters are found. If |callback| is non-NULL it will be executed
    /// asnychronously on the UI thread after the cookie has been set. Returns
    /// false if an invalid URL is specified or if cookies cannot be accessed.
    /// CEF name: `SetCookie`
    @discardableResult
    public func setCookie(_ cookie: CEFCookie, for url: URL, block: @escaping CEFSetCookieCallbackOnCompleteBlock) -> Bool {
        return setCookie(cookie, for: url, callback: CEFSetCookieCallbackBridge(block: block))
    }
    
    /// Delete all cookies that match the specified parameters. If both |url| and
    /// |cookie_name| values are specified all host and domain cookies matching
    /// both will be deleted. If only |url| is specified all host cookies (but not
    /// domain cookies) irrespective of path will be deleted. If |url| is empty all
    /// cookies for all hosts and domains will be deleted. If |callback| is
    /// non-NULL it will be executed asnychronously on the UI thread after the
    /// cookies have been deleted. Returns false if a non-empty invalid URL is
    /// specified or if cookies cannot be accessed. Cookies can alternately be
    /// deleted using the Visit*Cookies() methods.
    /// CEF name: `DeleteCookies`
    @discardableResult
    public func deleteCookies(url: URL? = nil, name: String? = nil, block: @escaping CEFDeleteCookiesCallbackOnCompleteBlock) -> Bool {
        return deleteCookies(url: url,
                             name: name,
                             callback: CEFDeleteCookiesCallbackBridge(block: block))
    }

    /// Flush the backing store (if any) to disk. If |callback| is non-NULL it will
    /// be executed asnychronously on the UI thread after the flush is complete.
    /// Returns false if cookies cannot be accessed.
    /// CEF name: `FlushStore`
    @discardableResult
    public func flushStore(block: @escaping CEFCompletionCallbackOnCompleteBlock) -> Bool {
        return flushStore(callback: CEFCompletionCallbackBridge(block: block))
    }

}

