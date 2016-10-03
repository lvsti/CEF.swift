//
//  CEFRequestContext+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_request_context.h.
//

import Foundation

extension cef_request_context_t: CEFObject {}

/// A request context provides request handling for a set of related browser
/// or URL request objects. A request context can be specified when creating a
/// new browser via the CefBrowserHost static factory methods or when creating a
/// new URL request via the CefURLRequest static factory methods. Browser objects
/// with different request contexts will never be hosted in the same render
/// process. Browser objects with the same request context may or may not be
/// hosted in the same render process depending on the process model. Browser
/// objects created indirectly via the JavaScript window.open function or
/// targeted links will share the same render process and the same request
/// context as the source browser. When running in single-process mode there is
/// only a single render process (the main process) and so all browsers created
/// in single-process mode will share the same request context. This will be the
/// first request context passed into a CefBrowserHost static factory method and
/// all other request context objects will be ignored.
public class CEFRequestContext: CEFProxy<cef_request_context_t> {
    override init?(ptr: UnsafeMutablePointer<cef_request_context_t>?) {
        super.init(ptr: ptr)
    }
    
    static func fromCEF(_ ptr: UnsafeMutablePointer<cef_request_context_t>?) -> CEFRequestContext? {
        return CEFRequestContext(ptr: ptr)
    }
}

