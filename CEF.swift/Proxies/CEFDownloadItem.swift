//
//  CEFDownloadItem.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 08..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

public extension CEFDownloadItem {
    
    public typealias Identifier = UInt32
    
    /// Returns true if this object is valid. Do not call any other methods if this
    /// function returns false.
    /// CEF name: `IsValid`
    public var isValid: Bool {
        return cefObject.is_valid(cefObjectPtr) != 0
    }

    /// Returns true if the download is in progress.
    /// CEF name: `IsInProgress`
    public var isInProgress: Bool {
        return cefObject.is_in_progress(cefObjectPtr) != 0
    }

    /// Returns true if the download is complete.
    /// CEF name: `IsComplete`
    public var isComplete: Bool {
        return cefObject.is_complete(cefObjectPtr) != 0
    }

    /// Returns true if the download has been canceled or interrupted.
    /// CEF name: `IsCanceled`
    public var isCanceled: Bool {
        return cefObject.is_canceled(cefObjectPtr) != 0
    }

    /// Returns a simple speed estimate in bytes/s.
    /// CEF name: `GetCurrentSpeed`
    public var currentSpeed: Int64 {
        return cefObject.get_current_speed(cefObjectPtr)
    }

    /// Returns the rough percent complete or -1 if the receive total size is
    /// unknown.
    /// CEF name: `GetPercentComplete`
    public var percentComplete: Int? {
        let percent = cefObject.get_percent_complete(cefObjectPtr)
        return percent >= 0 ? Int(percent) : nil
    }

    /// Returns the total number of bytes.
    /// CEF name: `GetTotalBytes`
    public var totalBytes: Int64 {
        return cefObject.get_total_bytes(cefObjectPtr)
    }

    /// Returns the number of received bytes.
    /// CEF name: `GetReceivedBytes`
    public var receivedBytes: Int64 {
        return cefObject.get_received_bytes(cefObjectPtr)
    }
    
    /// Returns the time that the download started.
    /// CEF name: `GetStartTime`
    public var startTime: NSDate {
        let cefTime = cefObject.get_start_time(cefObjectPtr)
        return CEFTimeToNSDate(cefTime)
    }

    /// Returns the time that the download ended.
    /// CEF name: `GetEndTime`
    public var endTime: NSDate {
        let cefTime = cefObject.get_end_time(cefObjectPtr)
        return CEFTimeToNSDate(cefTime)
    }
    
    /// Returns the full path to the downloaded or downloading file.
    /// CEF name: `GetFullPath`
    public var fullPath: String {
        let cefStrPtr = cefObject.get_full_path(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return CEFStringToSwiftString(cefStrPtr!.pointee)
    }
    
    /// Returns the unique identifier for this download.
    /// CEF name: `GetId`
    public var identifier: Identifier {
        return cefObject.get_id(cefObjectPtr)
    }

    /// Returns the URL.
    /// CEF name: `GetURL`
    public var url: NSURL {
        let cefStrPtr = cefObject.get_url(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return NSURL(string: CEFStringToSwiftString(cefStrPtr!.pointee))!
    }
    
    /// Returns the original URL before any redirections.
    /// CEF name: `GetOriginalUrl`
    public var originalURL: NSURL {
        let cefStrPtr = cefObject.get_original_url(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return NSURL(string: CEFStringToSwiftString(cefStrPtr!.pointee))!
    }
    
    /// Returns the suggested file name.
    /// CEF name: `GetSuggestedFileName`
    public var suggestedFileName: String {
        let cefStrPtr = cefObject.get_suggested_file_name(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return CEFStringToSwiftString(cefStrPtr!.pointee)
    }
    
    /// Returns the content disposition.
    /// CEF name: `GetContentDisposition`
    public var contentDisposition: String {
        let cefStrPtr = cefObject.get_content_disposition(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return CEFStringToSwiftString(cefStrPtr!.pointee)
    }
    
    /// Returns the mime type.
    /// CEF name: `GetMimeType`
    public var mimeType: String {
        let cefStrPtr = cefObject.get_mime_type(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return CEFStringToSwiftString(cefStrPtr!.pointee)
    }
    
}

