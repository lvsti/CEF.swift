//
//  CEFCookie.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 02..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

/// Cookie information.
/// CEF name: `cef_cookie_t`
public struct CEFCookie {
    /// The cookie name.
    /// CEF name: `name`
    public var name: String = ""

    /// The cookie value.
    /// CEF name: `value`
    public var value: String = ""
    
    /// If |domain| is empty a host cookie will be created instead of a domain
    /// cookie. Domain cookies are stored with a leading "." and are visible to
    /// sub-domains whereas host cookies are not.
    /// CEF name: `domain`
    public var domain: String = ""
    
    /// If |path| is non-empty only URLs at or below the path will get the cookie
    /// value.
    /// CEF name: `path`
    public var path: String = ""
    
    /// If |secure| is true the cookie will only be sent for HTTPS requests.
    /// CEF name: `secure`
    public var isSecure: Bool = false
    
    /// If |httponly| is true the cookie will only be sent for HTTP requests.
    /// CEF name: `httponly`
    public var isHTTPOnly: Bool = false
    
    /// The cookie creation date. This is automatically populated by the system on
    /// cookie creation.
    /// CEF name: `creation`
    public var creationDate: Date = Date()
    
    /// The cookie last access date. This is automatically populated by the system
    /// on access.
    /// CEF name: `last_access`
    public var lastAccessDate: Date = Date()
    
    /// The cookie expiration date is only valid if |has_expires| is true.
    /// CEF name: `has_expires`
    public var hasExpiration: Bool {
        return expirationDate != nil
    }
    
    /// Cookie expiration date
    /// CEF name: `expires`
    public var expirationDate: Date? = nil
    
    public init() {
    }
}

extension CEFCookie {
    func toCEF() -> cef_cookie_t {
        var cefStruct = cef_cookie_t()

        CEFStringSetFromSwiftString(name, cefStringPtr: &cefStruct.name)
        CEFStringSetFromSwiftString(value, cefStringPtr: &cefStruct.value)
        CEFStringSetFromSwiftString(domain, cefStringPtr: &cefStruct.domain)
        CEFStringSetFromSwiftString(path, cefStringPtr: &cefStruct.path)
        cefStruct.secure = isSecure ? 1 : 0
        cefStruct.httponly = isHTTPOnly ? 1 : 0
        CEFTimeSetFromSwiftDate(creationDate, cefTimePtr: &cefStruct.creation)
        CEFTimeSetFromSwiftDate(lastAccessDate, cefTimePtr: &cefStruct.last_access)
        cefStruct.has_expires = expirationDate != nil ? 1 : 0
        if let expirationDate = expirationDate {
            CEFTimeSetFromSwiftDate(expirationDate, cefTimePtr: &cefStruct.expires)
        }
        
        return cefStruct
    }
    
    static func fromCEF(_ value: cef_cookie_t) -> CEFCookie {
        var cookie = CEFCookie()
        
        cookie.name = CEFStringToSwiftString(value.name)
        cookie.value = CEFStringToSwiftString(value.value)
        cookie.domain = CEFStringToSwiftString(value.domain)
        cookie.path = CEFStringToSwiftString(value.path)
        cookie.isSecure = value.secure != 0
        cookie.isHTTPOnly = value.httponly != 0
        cookie.creationDate = CEFTimeToSwiftDate(value.creation)
        cookie.lastAccessDate = CEFTimeToSwiftDate(value.last_access)
        if value.has_expires == 1 {
            cookie.expirationDate = CEFTimeToSwiftDate(value.expires)
        }
        
        return cookie
    }
}

extension cef_cookie_t {
    mutating func clear() {
        cef_string_utf16_clear(&name)
        cef_string_utf16_clear(&value)
        cef_string_utf16_clear(&domain)
        cef_string_utf16_clear(&path)
    }
}

