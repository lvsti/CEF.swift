//
//  DownloadItem.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 08..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

extension cef_download_item_t: CEFObject {
}

/// Class used to represent a download item.
public class DownloadItem: Proxy<cef_download_item_t> {
    
    public typealias Identifier = UInt32
    
    /// Returns true if this object is valid. Do not call any other methods if this
    /// function returns false.
    public var isValid: Bool {
        return cefObject.is_valid(cefObjectPtr) != 0
    }

    /// Returns true if the download is in progress.
    public var isInProgress: Bool {
        return cefObject.is_in_progress(cefObjectPtr) != 0
    }

    /// Returns true if the download is complete.
    public var isComplete: Bool {
        return cefObject.is_complete(cefObjectPtr) != 0
    }

    /// Returns true if the download has been canceled or interrupted.
    public var isCanceled: Bool {
        return cefObject.is_canceled(cefObjectPtr) != 0
    }

    /// Returns a simple speed estimate in bytes/s.
    public var currentSpeed: Int64 {
        return cefObject.get_current_speed(cefObjectPtr)
    }

    /// Returns the rough percent complete or -1 if the receive total size is
    /// unknown.
    public var percentComplete: Int? {
        let percent = cefObject.get_percent_complete(cefObjectPtr)
        return percent >= 0 ? Int(percent) : nil
    }

    /// Returns the total number of bytes.
    public var totalBytes: Int64 {
        return cefObject.get_total_bytes(cefObjectPtr)
    }

    /// Returns the number of received bytes.
    public var receivedBytes: Int64 {
        return cefObject.get_received_bytes(cefObjectPtr)
    }
    
    /// Returns the time that the download started.
    public var startTime: NSDate {
        let cefTime = cefObject.get_start_time(cefObjectPtr)
        return CEFTimeToNSDate(cefTime)
    }

    /// Returns the time that the download ended.
    public var endTime: NSDate {
        let cefTime = cefObject.get_end_time(cefObjectPtr)
        return CEFTimeToNSDate(cefTime)
    }
    
    /// Returns the full path to the downloaded or downloading file.
    public var fullPath: String {
        let cefStrPtr = cefObject.get_full_path(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return CEFStringToSwiftString(cefStrPtr.memory)
    }
    
    /// Returns the unique identifier for this download.
    public var identifier: Identifier {
        return cefObject.get_id(cefObjectPtr)
    }

    /// Returns the URL.
    public var url: NSURL {
        let cefStrPtr = cefObject.get_url(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return NSURL(string: CEFStringToSwiftString(cefStrPtr.memory))!
    }
    
    /// Returns the original URL before any redirections.
    public var originalURL: NSURL {
        let cefStrPtr = cefObject.get_original_url(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return NSURL(string: CEFStringToSwiftString(cefStrPtr.memory))!
    }
    
    /// Returns the suggested file name.
    public var suggestedFileName: String {
        let cefStrPtr = cefObject.get_suggested_file_name(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return CEFStringToSwiftString(cefStrPtr.memory)
    }
    
    /// Returns the content disposition.
    public var contentDisposition: String {
        let cefStrPtr = cefObject.get_content_disposition(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return CEFStringToSwiftString(cefStrPtr.memory)
    }
    
    /// Returns the mime type.
    public var mimeType: String {
        let cefStrPtr = cefObject.get_mime_type(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return CEFStringToSwiftString(cefStrPtr.memory)
    }
    
    // private
    
    override init?(ptr: ObjectPtrType) {
        super.init(ptr: ptr)
    }
    
    static func fromCEF(ptr: ObjectPtrType) -> DownloadItem? {
        return DownloadItem(ptr: ptr)
    }
}

