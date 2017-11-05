//
//  CEFDOMDocument+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_dom.h.
//

import Foundation

extension cef_domdocument_t: CEFObject {}

/// Class used to represent a DOM document. The methods of this class should only
/// be called on the render process main thread thread.
/// CEF name: `CefDOMDocument`
public final class CEFDOMDocument: CEFProxy<cef_domdocument_t> {
    override init?(ptr: UnsafeMutablePointer<cef_domdocument_t>?) {
        super.init(ptr: ptr)
    }
    
    static func fromCEF(_ ptr: UnsafeMutablePointer<cef_domdocument_t>?) -> CEFDOMDocument? {
        return CEFDOMDocument(ptr: ptr)
    }
}

