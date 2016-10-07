//
//  CEFCrossOriginUtils.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 11..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

/// The same-origin policy restricts how scripts hosted from different origins
/// (scheme + domain + port) can communicate. By default, scripts can only access
/// resources with the same origin. Scripts hosted on the HTTP and HTTPS schemes
/// (but no other schemes) can use the "Access-Control-Allow-Origin" header to
/// allow cross-origin requests. For example, https://source.example.com can make
/// XMLHttpRequest requests on http://target.example.com if the
/// http://target.example.com request returns an "Access-Control-Allow-Origin:
/// https://source.example.com" response header.
/// Scripts in separate frames or iframes and hosted from the same protocol and
/// domain suffix can execute cross-origin JavaScript if both pages set the
/// document.domain value to the same domain suffix. For example,
/// scheme://foo.example.com and scheme://bar.example.com can communicate using
/// JavaScript if both domains set document.domain="example.com".
public struct CEFCrossOriginUtils {

    /// Add an entry to the cross-origin access whitelist.
    /// This method is used to allow access to origins that would otherwise violate
    /// the same-origin policy. Scripts hosted underneath the fully qualified
    /// |source_origin| URL (like http://www.example.com) will be allowed access to
    /// all resources hosted on the specified |target_protocol| and |target_domain|.
    /// If |target_domain| is non-empty and |allow_target_subdomains| if false only
    /// exact domain matches will be allowed. If |target_domain| contains a top-
    /// level domain component (like "example.com") and |allow_target_subdomains| is
    /// true sub-domain matches will be allowed. If |target_domain| is empty and
    /// |allow_target_subdomains| if true all domains and IP addresses will be
    /// allowed.
    /// This method cannot be used to bypass the restrictions on local or display
    /// isolated schemes. See the comments on CefRegisterCustomScheme for more
    /// information.
    /// This function may be called on any thread. Returns false if |source_origin|
    /// is invalid or the whitelist cannot be accessed.
    /// CEF name: `CefAddCrossOriginWhitelistEntry`
    public static func addWhitelistEntry(origin: NSURL,
                                         targetScheme: String,
                                         targetDomain: String? = nil,
                                         allowTargetSubdomains: Bool) -> Bool {
        let cefOriginPtr = CEFStringPtrCreateFromSwiftString(origin.absoluteString!)
        let cefSchemePtr = CEFStringPtrCreateFromSwiftString(targetScheme)
        let cefDomainPtr = targetDomain != nil ? CEFStringPtrCreateFromSwiftString(targetDomain!) : nil
        
        defer {
            CEFStringPtrRelease(cefOriginPtr)
            CEFStringPtrRelease(cefSchemePtr)
            CEFStringPtrRelease(cefDomainPtr)
        }
        
        return cef_add_cross_origin_whitelist_entry(cefOriginPtr,
                                                    cefSchemePtr,
                                                    cefDomainPtr,
                                                    allowTargetSubdomains ? 1 : 0) != 0
    }

    /// Remove an entry from the cross-origin access whitelist. Returns false if
    /// |source_origin| is invalid or the whitelist cannot be accessed.
    /// CEF name: `CefRemoveCrossOriginWhitelistEntry`
    public static func removeWhitelistEntry(origin: NSURL,
                                            targetScheme: String,
                                            targetDomain: String? = nil,
                                            allowTargetSubdomains: Bool) -> Bool {
        let cefOriginPtr = CEFStringPtrCreateFromSwiftString(origin.absoluteString!)
        let cefSchemePtr = CEFStringPtrCreateFromSwiftString(targetScheme)
        let cefDomainPtr = targetDomain != nil ? CEFStringPtrCreateFromSwiftString(targetDomain!) : nil
        
        defer {
            CEFStringPtrRelease(cefOriginPtr)
            CEFStringPtrRelease(cefSchemePtr)
            CEFStringPtrRelease(cefDomainPtr)
        }
        
        return cef_remove_cross_origin_whitelist_entry(cefOriginPtr,
                                                       cefSchemePtr,
                                                       cefDomainPtr,
                                                       allowTargetSubdomains ? 1 : 0) != 0
    }
    
    /// Remove all entries from the cross-origin access whitelist. Returns false if
    /// the whitelist cannot be accessed.
    /// CEF name: `CefClearCrossOriginWhitelist`
    public static func clearWhitelist() -> Bool {
        return cef_clear_cross_origin_whitelist() != 0
    }

}


