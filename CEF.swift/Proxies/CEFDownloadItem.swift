//
//  CEFDownloadItem.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 08..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

extension cef_download_item_t: CEFObject {
}

///
// Class used to represent a download item.
///
public class CEFDownloadItem: CEFProxy<cef_download_item_t> {
    
    public typealias Identifier = UInt32
    
    ///
    // Returns true if this object is valid. Do not call any other methods if this
    // function returns false.
    ///
    public func isValid() -> Bool {
        return cefObject.is_valid(cefObjectPtr) != 0
    }

    ///
    // Returns true if the download is in progress.
    ///
    public func isInProgress() -> Bool {
        return cefObject.is_in_progress(cefObjectPtr) != 0
    }

    ///
    // Returns true if the download is complete.
    ///
    public func isComplete() -> Bool {
        return cefObject.is_complete(cefObjectPtr) != 0
    }

    ///
    // Returns true if the download has been canceled or interrupted.
    ///
    public func isCanceled() -> Bool {
        return cefObject.is_canceled(cefObjectPtr) != 0
    }

    ///
    // Returns a simple speed estimate in bytes/s.
    ///
    public func getCurrentSpeed() -> Int64 {
        return cefObject.get_current_speed(cefObjectPtr)
    }

    ///
    // Returns the rough percent complete or -1 if the receive total size is
    // unknown.
    ///
    public func getPercentComplete() -> Int {
        return Int(cefObject.get_percent_complete(cefObjectPtr))
    }

    ///
    // Returns the total number of bytes.
    ///
    public func getTotalBytes() -> Int64 {
        return cefObject.get_total_bytes(cefObjectPtr)
    }

    ///
    // Returns the number of received bytes.
    ///
    public func getReceivedBytes() -> Int64 {
        return cefObject.get_received_bytes(cefObjectPtr)
    }
    
    ///
    // Returns the time that the download started.
    ///
    public func getStartTime() -> NSDate {
        let cefTime = cefObject.get_start_time(cefObjectPtr)
        return CEFTimeToNSDate(cefTime)
    }

    ///
    // Returns the time that the download ended.
    ///
    public func getEndTime() -> NSDate {
        let cefTime = cefObject.get_end_time(cefObjectPtr)
        return CEFTimeToNSDate(cefTime)
    }
    
    ///
    // Returns the full path to the downloaded or downloading file.
    ///
    public func getFullPath() -> String {
        let cefStrPtr = cefObject.get_full_path(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return CEFStringToSwiftString(cefStrPtr.memory)
    }
    
    ///
    // Returns the unique identifier for this download.
    ///
    public func getID() -> Identifier {
        return cefObject.get_id(cefObjectPtr)
    }

    ///
    // Returns the URL.
    ///
    public func getURL() -> NSURL {
        let cefStrPtr = cefObject.get_url(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return NSURL(string: CEFStringToSwiftString(cefStrPtr.memory))!
    }
    
    ///
    // Returns the original URL before any redirections.
    ///
    public func getOriginalURL() -> NSURL {
        let cefStrPtr = cefObject.get_original_url(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return NSURL(string: CEFStringToSwiftString(cefStrPtr.memory))!
    }
    
    ///
    // Returns the suggested file name.
    ///
    public func getSuggestedFileName() -> String {
        let cefStrPtr = cefObject.get_suggested_file_name(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return CEFStringToSwiftString(cefStrPtr.memory)
    }
    
    ///
    // Returns the content disposition.
    ///
    public func getContentDisposition() -> String {
        let cefStrPtr = cefObject.get_content_disposition(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return CEFStringToSwiftString(cefStrPtr.memory)
    }
    
    ///
    // Returns the mime type.
    ///
    public func getMIMEType() -> String {
        let cefStrPtr = cefObject.get_mime_type(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return CEFStringToSwiftString(cefStrPtr.memory)
    }
    
    // private
    
    override init?(ptr: ObjectPtrType) {
        super.init(ptr: ptr)
    }
    
    static func fromCEF(ptr: ObjectPtrType) -> CEFDownloadItem? {
        return CEFDownloadItem(ptr: ptr)
    }
}

