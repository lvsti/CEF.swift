//
//  CEFSSLContentStatus.g.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2016. 11. 01..
//  Copyright © 2016. Tamas Lustyik. All rights reserved.
//

import Foundation

/// Supported SSL content status flags. See content/public/common/ssl_status.h
/// for more information.
/// CEF name: `cef_ssl_content_status_t`
public struct CEFSSLContentStatus: OptionSet {
    public let rawValue: UInt32
    public init(rawValue: UInt32) {
        self.rawValue = rawValue
    }

    /// CEF name: `SSL_CONTENT_NORMAL_CONTENT`
    public static let normalContent = CEFSSLContentStatus([])
    
    /// CEF name: `SSL_CONTENT_DISPLAYED_INSECURE_CONTENT`
    public static let displayedInsecureContent = CEFSSLContentStatus(rawValue: 1 << 0)
    
    /// CEF name: `SSL_CONTENT_RAN_INSECURE_CONTENT`
    public static let ranInsecureContent = CEFSSLContentStatus(rawValue: 1 << 1)
}

extension CEFSSLContentStatus {
    static func fromCEF(_ value: cef_ssl_content_status_t) -> CEFSSLContentStatus {
        return CEFSSLContentStatus(rawValue: UInt32(value.rawValue))
    }
    
    func toCEF() -> cef_ssl_content_status_t {
        return cef_ssl_content_status_t(rawValue: UInt32(rawValue))
    }
}
