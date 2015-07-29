//
//  CEFNavigationEntry.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 07. 26..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

extension cef_navigation_entry_t: CEFObject {
}

public class CEFNavigationEntry: CEFProxy<cef_navigation_entry_t> {

    public typealias TransitionType = CEFTransitionType
    
    public func isValid() -> Bool {
        return cefObject.is_valid(cefObjectPtr) != 0
    }

    public func getURL() -> NSURL {
        let cefURLPtr = cefObject.get_url(cefObjectPtr)
        defer { CEFStringPtrRelease(cefURLPtr) }
        return NSURL(string: CEFStringToSwiftString(cefURLPtr.memory))!
    }

    public func getDisplayURL() -> NSURL {
        let cefURLPtr = cefObject.get_display_url(cefObjectPtr)
        defer { CEFStringPtrRelease(cefURLPtr) }
        return NSURL(string: CEFStringToSwiftString(cefURLPtr.memory))!
    }
    
    public func getOriginalURL() -> NSURL {
        let cefURLPtr = cefObject.get_original_url(cefObjectPtr)
        defer { CEFStringPtrRelease(cefURLPtr) }
        return NSURL(string: CEFStringToSwiftString(cefURLPtr.memory))!
    }
    
    public func getTitle() -> String {
        let cefStrPtr = cefObject.get_url(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return CEFStringToSwiftString(cefStrPtr.memory)
    }
    
    public func getTransitionType() -> TransitionType {
        let cefTT = cefObject.get_transition_type(cefObjectPtr)
        return TransitionType.fromCEF(cefTT)
    }
    
    public func hasPOSTData() -> Bool {
        return cefObject.has_post_data(cefObjectPtr) != 0
    }

    public func getFrameName() -> String {
        let cefStrPtr = cefObject.get_frame_name(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return CEFStringToSwiftString(cefStrPtr.memory)
    }
    
    public func getCompletionTime() -> NSDate {
        var cefTime = cefObject.get_completion_time(cefObjectPtr)
        return CEFTimeToNSDate(&cefTime)
    }

    public func getHTTPStatusCode() -> Int {
        return Int(cefObject.get_http_status_code(cefObjectPtr))
    }

    // private
    
    override init?(ptr: ObjectPtrType) {
        super.init(ptr: ptr)
    }
    
    static func fromCEF(ptr: ObjectPtrType) -> CEFNavigationEntry? {
        return CEFNavigationEntry(ptr: ptr)
    }
}

