//
//  CEFRequestContextSettings.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 02..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

public struct CEFRequestContextSettings {
    public var cachePath: String = ""
    public var persistSessionCookies: Bool = false
    public var ignoreCertificateErrors: Bool = false
    public var acceptLanguageList: String = ""
    
    public init() {
    }
}

extension CEFRequestContextSettings {
    func toCEF() -> cef_request_context_settings_t {
        var cefStruct = cef_request_context_settings_t()
        
        CEFStringSetFromSwiftString(cachePath, cefString: &cefStruct.cache_path)
        cefStruct.persist_session_cookies = persistSessionCookies ? 1 : 0
        cefStruct.ignore_certificate_errors = ignoreCertificateErrors ? 1 : 0
        CEFStringSetFromSwiftString(acceptLanguageList, cefString: &cefStruct.accept_language_list)
        
        return cefStruct
    }
}

extension cef_request_context_settings_t {
    mutating func clear() {
        cef_string_utf16_clear(&cache_path)
        cef_string_utf16_clear(&accept_language_list)
    }
}

