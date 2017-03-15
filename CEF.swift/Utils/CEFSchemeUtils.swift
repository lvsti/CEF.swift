//
//  CEFSchemeUtils.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 17..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

public struct CEFSchemeUtils {
    
    /// Register a scheme handler factory with the global request context. An empty
    /// |domain_name| value for a standard scheme will cause the factory to match all
    /// domain names. The |domain_name| value will be ignored for non-standard
    /// schemes. If |scheme_name| is a built-in scheme and no handler is returned by
    /// |factory| then the built-in scheme handler factory will be called. If
    /// |scheme_name| is a custom scheme then you must also implement the
    /// CefApp::OnRegisterCustomSchemes() method in all processes. This function may
    /// be called multiple times to change or remove the factory that matches the
    /// specified |scheme_name| and optional |domain_name|. Returns false if an error
    /// occurs. This function may be called on any thread in the browser process.
    /// Using this function is equivalent to calling
    /// CefRequestContext::GetGlobalContext()->RegisterSchemeHandlerFactory().
    /// CEF name: `CefRegisterSchemeHandlerFactory`
    @discardableResult
    public static func registerHandlerFactoryForScheme(scheme: String, domain: String? = nil, factory: CEFSchemeHandlerFactory? = nil) -> Bool {
        let cefSchemePtr = CEFStringPtrCreateFromSwiftString(scheme)
        let cefDomainPtr = domain != nil ? CEFStringPtrCreateFromSwiftString(domain!) : nil
        let cefFactory = factory?.toCEF()
        defer {
            CEFStringPtrRelease(cefSchemePtr)
        }
        return cef_register_scheme_handler_factory(cefSchemePtr, cefDomainPtr, cefFactory) != 0
    }

    /// Clear all scheme handler factories registered with the global request
    /// context. Returns false on error. This function may be called on any thread in
    /// the browser process. Using this function is equivalent to calling
    /// CefRequestContext::GetGlobalContext()->ClearSchemeHandlerFactories().
    /// CEF name: `CefClearSchemeHandlerFactories`
    @discardableResult
    public static func clearHandlerFactories() -> Bool {
        return cef_clear_scheme_handler_factories() != 0
    }

}
