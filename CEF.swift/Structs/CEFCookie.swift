//
//  CEFCookie.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 02..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

/// Cookie information.
public struct CEFCookie {
    /// The cookie name.
    public var name: String = ""

    /// The cookie value.
    public var value: String = ""
    
    /// If |domain| is empty a host cookie will be created instead of a domain
    /// cookie. Domain cookies are stored with a leading "." and are visible to
    /// sub-domains whereas host cookies are not.
    public var domain: String = ""
    
    /// If |path| is non-empty only URLs at or below the path will get the cookie
    /// value.
    public var path: String = ""
    
    /// If |secure| is true the cookie will only be sent for HTTPS requests.
    public var secure: Bool = false
    
    /// If |httponly| is true the cookie will only be sent for HTTP requests.
    public var httpOnly: Bool = false
    
    /// The cookie creation date. This is automatically populated by the system on
    /// cookie creation.
    public var creation: NSDate = NSDate()
    
    /// The cookie last access date. This is automatically populated by the system
    /// on access.
    public var lastAccess: NSDate = NSDate()
    
    /// The cookie expiration date is only valid if |has_expires| is true.
    public var hasExpires: Bool = false
    
    /// Cookie expiration date
    public var expires: NSDate = NSDate()
    
    public init() {
    }
}

extension CEFCookie {
    func toCEF() -> cef_cookie_t {
        var cefStruct = cef_cookie_t()

        CEFStringSetFromSwiftString(name, cefString: &cefStruct.name)
        CEFStringSetFromSwiftString(value, cefString: &cefStruct.value)
        CEFStringSetFromSwiftString(domain, cefString: &cefStruct.domain)
        CEFStringSetFromSwiftString(path, cefString: &cefStruct.path)
        cefStruct.secure = secure ? 1 : 0
        cefStruct.httponly = httpOnly ? 1 : 0
        CEFTimeSetFromNSDate(creation, cefTime: &cefStruct.creation)
        CEFTimeSetFromNSDate(lastAccess, cefTime: &cefStruct.last_access)
        cefStruct.has_expires = hasExpires ? 1 : 0
        CEFTimeSetFromNSDate(expires, cefTime: &cefStruct.expires)
        
        return cefStruct
    }
    
    static func fromCEF(_ value: cef_cookie_t) -> CEFCookie {
        var cookie = CEFCookie()
        
        cookie.name = CEFStringToSwiftString(value.name)
        cookie.value = CEFStringToSwiftString(value.value)
        cookie.domain = CEFStringToSwiftString(value.domain)
        cookie.path = CEFStringToSwiftString(value.path)
        cookie.secure = value.secure != 0
        cookie.httpOnly = value.httponly != 0
        cookie.creation = CEFTimeToNSDate(value.creation)
        cookie.lastAccess = CEFTimeToNSDate(value.last_access)
        cookie.hasExpires = value.has_expires != 0
        cookie.expires = CEFTimeToNSDate(value.expires)
        
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

