//
//  CEFRequestContextSettings.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 02..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

/// Request context initialization settings. Specify NULL or 0 to get the
/// recommended default values.
/// CEF name: `cef_request_context_settings_t`
public struct CEFRequestContextSettings {
    /// The location where cache data will be stored on disk. If empty then
    /// browsers will be created in "incognito mode" where in-memory caches are
    /// used for storage and no data is persisted to disk. HTML5 databases such as
    /// localStorage will only persist across sessions if a cache path is
    /// specified. To share the global browser cache and related configuration set
    /// this value to match the CefSettings.cache_path value.
    /// CEF name: `cache_path`
    public var cachePath: String = ""

    /// To persist session cookies (cookies without an expiry date or validity
    /// interval) by default when using the global cookie manager set this value to
    /// true (1). Session cookies are generally intended to be transient and most
    /// Web browsers do not persist them. Can be set globally using the
    /// CefSettings.persist_session_cookies value. This value will be ignored if
    /// |cache_path| is empty or if it matches the CefSettings.cache_path value.
    /// CEF name: `persist_session_cookies`
    public var persistSessionCookies: Bool = false
    
    /// To persist user preferences as a JSON file in the cache path directory set
    /// this value to true (1). Can be set globally using the
    /// CefSettings.persist_user_preferences value. This value will be ignored if
    /// |cache_path| is empty or if it matches the CefSettings.cache_path value.
    /// CEF name: `persist_user_preferences`
    public var persistUserPreferences: Bool = false

    /// Set to true (1) to ignore errors related to invalid SSL certificates.
    /// Enabling this setting can lead to potential security vulnerabilities like
    /// "man in the middle" attacks. Applications that load content from the
    /// internet should not enable this setting. Can be set globally using the
    /// CefSettings.ignore_certificate_errors value. This value will be ignored if
    /// |cache_path| matches the CefSettings.cache_path value.
    /// CEF name: `ignore_certificate_errors`
    public var ignoreCertificateErrors: Bool = false
    
    /// Comma delimited ordered list of language codes without any whitespace that
    /// will be used in the "Accept-Language" HTTP header. Can be set globally
    /// using the CefSettings.accept_language_list value or overridden on a per-
    /// browser basis using the CefBrowserSettings.accept_language_list value. If
    /// all values are empty then "en-US,en" will be used. This value will be
    /// ignored if |cache_path| matches the CefSettings.cache_path value.
    /// CEF name: `accept_language_list`
    public var acceptLanguageList: String = ""
    
    public init() {
    }
}

extension CEFRequestContextSettings {
    func toCEF() -> cef_request_context_settings_t {
        var cefStruct = cef_request_context_settings_t()
        
        CEFStringSetFromSwiftString(cachePath, cefStringPtr: &cefStruct.cache_path)
        cefStruct.persist_session_cookies = persistSessionCookies ? 1 : 0
        cefStruct.persist_user_preferences = persistUserPreferences ? 1 : 0
        cefStruct.ignore_certificate_errors = ignoreCertificateErrors ? 1 : 0
        CEFStringSetFromSwiftString(acceptLanguageList, cefStringPtr: &cefStruct.accept_language_list)
        
        return cefStruct
    }
}

extension cef_request_context_settings_t {
    mutating func clear() {
        cef_string_utf16_clear(&cache_path)
        cef_string_utf16_clear(&accept_language_list)
    }
}

