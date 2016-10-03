//
//  CEFPOSTData+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_request.h.
//

import Foundation

extension cef_post_data_t: CEFObject {}

/// Class used to represent post data for a web request. The methods of this
/// class may be called on any thread.
public class CEFPOSTData: CEFProxy<cef_post_data_t> {
    override init?(ptr: UnsafeMutablePointer<cef_post_data_t>?) {
        super.init(ptr: ptr)
    }
    
    static func fromCEF(_ ptr: UnsafeMutablePointer<cef_post_data_t>?) -> CEFPOSTData? {
        return CEFPOSTData(ptr: ptr)
    }
}

