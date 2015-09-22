//
//  Cookie.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 02..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

/// Cookie information.
public struct Cookie {
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

extension Cookie {
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
    
    static func fromCEF(cefStruct: cef_cookie_t) -> Cookie {
        var cookie = Cookie()
        
        cookie.name = CEFStringToSwiftString(cefStruct.name)
        cookie.value = CEFStringToSwiftString(cefStruct.value)
        cookie.domain = CEFStringToSwiftString(cefStruct.domain)
        cookie.path = CEFStringToSwiftString(cefStruct.path)
        cookie.secure = cefStruct.secure != 0
        cookie.httpOnly = cefStruct.httponly != 0
        cookie.creation = CEFTimeToNSDate(cefStruct.creation)
        cookie.lastAccess = CEFTimeToNSDate(cefStruct.last_access)
        cookie.hasExpires = cefStruct.has_expires != 0
        cookie.expires = CEFTimeToNSDate(cefStruct.expires)
        
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

