//
//  CEFNavigationEntry.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 07. 26..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

public extension CEFNavigationEntry {

    /// Returns true if this object is valid. Do not call any other methods if this
    /// function returns false.
    /// CEF name: `IsValid`
    public var isValid: Bool {
        return cefObject.is_valid(cefObjectPtr) != 0
    }

    /// Returns the actual URL of the page. For some pages this may be data: URL or
    /// similar. Use GetDisplayURL() to return a display-friendly version.
    /// CEF name: `GetURL`
    public var url: URL {
        let cefURLPtr = cefObject.get_url(cefObjectPtr)
        defer { CEFStringPtrRelease(cefURLPtr) }
        return URL(string: CEFStringToSwiftString(cefURLPtr!.pointee))!
    }

    /// Returns a display-friendly version of the URL.
    /// CEF name: `GetDisplayURL`
    public var displayURL: URL {
        let cefURLPtr = cefObject.get_display_url(cefObjectPtr)
        defer { CEFStringPtrRelease(cefURLPtr) }
        return URL(string: CEFStringToSwiftString(cefURLPtr!.pointee))!
    }
    
    /// Returns the original URL that was entered by the user before any redirects.
    /// CEF name: `GetOriginalURL`
    public var originalURL: URL {
        let cefURLPtr = cefObject.get_original_url(cefObjectPtr)
        defer { CEFStringPtrRelease(cefURLPtr) }
        return URL(string: CEFStringToSwiftString(cefURLPtr!.pointee))!
    }
    
    /// Returns the title set by the page. This value may be empty.
    /// CEF name: `GetTitle`
    public var title: String {
        let cefStrPtr = cefObject.get_url(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return CEFStringToSwiftString(cefStrPtr!.pointee)
    }
    
    /// Returns the transition type which indicates what the user did to move to
    /// this page from the previous page.
    /// CEF name: `GetTransitionType`
    public var transitionType: CEFTransitionType {
        let cefTT = cefObject.get_transition_type(cefObjectPtr)
        return CEFTransitionType.fromCEF(cefTT)
    }
    
    /// Returns true if this navigation includes post data.
    /// CEF name: `HasPostData`
    public var hasPOSTData: Bool {
        return cefObject.has_post_data(cefObjectPtr) != 0
    }

    /// Returns the time for the last known successful navigation completion. A
    /// navigation may be completed more than once if the page is reloaded. May be
    /// 0 if the navigation has not yet completed.
    /// CEF name: `GetCompletionTime`
    public var completionTime: Date {
        let cefTime = cefObject.get_completion_time(cefObjectPtr)
        return CEFTimeToSwiftDate(cefTime)
    }

    /// Returns the HTTP status code for the last known successful navigation
    /// response. May be 0 if the response has not yet been received or if the
    /// navigation has not yet completed.
    /// CEF name: `GetHttpStatusCode`
    public var httpStatusCode: Int {
        return Int(cefObject.get_http_status_code(cefObjectPtr))
    }

    /// Returns the SSL information for this navigation entry.
    /// CEF name: `GetSSLStatus`
    public var sslStatus: CEFSSLStatus {
        let cefStatus = cefObject.get_sslstatus(cefObjectPtr)
        return CEFSSLStatus.fromCEF(cefStatus)!
    }
}

