//
//  CEFBeforeDownloadCallback+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_download_handler.h.
//

import Foundation

extension cef_before_download_callback_t: CEFObject {}

/// Callback interface used to asynchronously continue a download.
public class CEFBeforeDownloadCallback: CEFProxy<cef_before_download_callback_t> {
    override init?(ptr: UnsafeMutablePointer<cef_before_download_callback_t>?) {
        super.init(ptr: ptr)
    }
    
    static func fromCEF(_ ptr: UnsafeMutablePointer<cef_before_download_callback_t>?) -> CEFBeforeDownloadCallback? {
        return CEFBeforeDownloadCallback(ptr: ptr)
    }
}

