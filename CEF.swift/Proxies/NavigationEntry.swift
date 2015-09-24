//
//  NavigationEntry.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 07. 26..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

extension cef_navigation_entry_t: CEFObject {
}

/// Class used to represent an entry in navigation history.
public class NavigationEntry: Proxy<cef_navigation_entry_t> {

    /// Returns true if this object is valid. Do not call any other methods if this
    /// function returns false.
    public var isValid: Bool {
        return cefObject.is_valid(cefObjectPtr) != 0
    }

    /// Returns the actual URL of the page. For some pages this may be data: URL or
    /// similar. Use GetDisplayURL() to return a display-friendly version.
    public var url: NSURL {
        let cefURLPtr = cefObject.get_url(cefObjectPtr)
        defer { CEFStringPtrRelease(cefURLPtr) }
        return NSURL(string: CEFStringToSwiftString(cefURLPtr.memory))!
    }

    /// Returns a display-friendly version of the URL.
    public var displayURL: NSURL {
        let cefURLPtr = cefObject.get_display_url(cefObjectPtr)
        defer { CEFStringPtrRelease(cefURLPtr) }
        return NSURL(string: CEFStringToSwiftString(cefURLPtr.memory))!
    }
    
    /// Returns the original URL that was entered by the user before any redirects.
    public var originalURL: NSURL {
        let cefURLPtr = cefObject.get_original_url(cefObjectPtr)
        defer { CEFStringPtrRelease(cefURLPtr) }
        return NSURL(string: CEFStringToSwiftString(cefURLPtr.memory))!
    }
    
    /// Returns the title set by the page. This value may be empty.
    public var title: String {
        let cefStrPtr = cefObject.get_url(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return CEFStringToSwiftString(cefStrPtr.memory)
    }
    
    /// Returns the transition type which indicates what the user did to move to
    /// this page from the previous page.
    public var transitionType: TransitionType {
        let cefTT = cefObject.get_transition_type(cefObjectPtr)
        return TransitionType.fromCEF(cefTT)
    }
    
    /// Returns true if this navigation includes post data.
    public var hasPOSTData: Bool {
        return cefObject.has_post_data(cefObjectPtr) != 0
    }

    /// Returns the name of the sub-frame that navigated or an empty value if the
    /// main frame navigated.
    public var frameName: String {
        let cefStrPtr = cefObject.get_frame_name(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return CEFStringToSwiftString(cefStrPtr.memory)
    }
    
    /// Returns the time for the last known successful navigation completion. A
    /// navigation may be completed more than once if the page is reloaded. May be
    /// 0 if the navigation has not yet completed.
    public var completionTime: NSDate {
        let cefTime = cefObject.get_completion_time(cefObjectPtr)
        return CEFTimeToNSDate(cefTime)
    }

    /// Returns the HTTP status code for the last known successful navigation
    /// response. May be 0 if the response has not yet been received or if the
    /// navigation has not yet completed.
    public var httpStatusCode: Int {
        return Int(cefObject.get_http_status_code(cefObjectPtr))
    }

    // private
    
    override init?(ptr: ObjectPtrType) {
        super.init(ptr: ptr)
    }
    
    static func fromCEF(ptr: ObjectPtrType) -> NavigationEntry? {
        return NavigationEntry(ptr: ptr)
    }
}

