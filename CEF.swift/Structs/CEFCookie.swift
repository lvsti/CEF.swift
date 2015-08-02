//
//  CEFCookie.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 02..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

public struct CEFCookie {
    public var name: String = ""
    public var value: String = ""
    public var domain: String = ""
    public var path: String = ""
    public var secure: Bool = false
    public var httpOnly: Bool = false
    public var creation: NSDate = NSDate()
    public var lastAccess: NSDate = NSDate()
    public var hasExpires: Bool = false
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
    
    static func fromCEF(cefStruct: cef_cookie_t) -> CEFCookie {
        var cookie = CEFCookie()
        
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

