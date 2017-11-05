//
//  CEFPOSTDataElement+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_request.h.
//

import Foundation

extension cef_post_data_element_t: CEFObject {}

/// Class used to represent a single element in the request post data. The
/// methods of this class may be called on any thread.
/// CEF name: `CefPostDataElement`
public final class CEFPOSTDataElement: CEFProxy<cef_post_data_element_t> {
    override init?(ptr: UnsafeMutablePointer<cef_post_data_element_t>?) {
        super.init(ptr: ptr)
    }
    
    static func fromCEF(_ ptr: UnsafeMutablePointer<cef_post_data_element_t>?) -> CEFPOSTDataElement? {
        return CEFPOSTDataElement(ptr: ptr)
    }
}

