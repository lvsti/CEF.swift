//
//  CEFSchemeRegistrar.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 07. 12..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

public extension CEFSchemeRegistrar {
    
    /// Register a custom scheme. This method should not be called for the built-in
    /// HTTP, HTTPS, FILE, FTP, ABOUT and DATA schemes.
    ///
    /// See cef_scheme_options_t for possible values for |options|.
    ///
    /// This function may be called on any thread. It should only be called once
    /// per unique |scheme_name| value. If |scheme_name| is already registered or
    /// if an error occurs this method will return false.
    /// CEF name: `AddCustomScheme`
    @discardableResult
    public func addCustomScheme(_ name: String, options: CEFSchemeOptions = .none) -> Bool {
        let cefStrPtr = CEFStringPtrCreateFromSwiftString(name)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return cefObject.add_custom_scheme(cefObjectPtr, cefStrPtr, Int32(options.toCEF().rawValue)) != 0
    }
    
}
