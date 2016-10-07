//
//  CEFDownloadItem+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_download_item.h.
//

import Foundation

extension cef_download_item_t: CEFObject {}

/// Class used to represent a download item.
/// CEF name: `CefDownloadItem`
public class CEFDownloadItem: CEFProxy<cef_download_item_t> {
    override init?(ptr: UnsafeMutablePointer<cef_download_item_t>?) {
        super.init(ptr: ptr)
    }
    
    static func fromCEF(_ ptr: UnsafeMutablePointer<cef_download_item_t>?) -> CEFDownloadItem? {
        return CEFDownloadItem(ptr: ptr)
    }
}

