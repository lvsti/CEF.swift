//
//  CEFSSLVersion.g.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2016. 11. 01..
//  Copyright © 2016. Tamas Lustyik. All rights reserved.
//

import Foundation

/// Supported SSL version values. See net/ssl/ssl_connection_status_flags.h
/// for more information.
/// CEF name: `cef_ssl_version_t`
public enum CEFSSLVersion: Int32 {
    /// Unknown SSL version.
    /// CEF name: `SSL_CONNECTION_VERSION_UNKNOWN`
    case unknown = 0
    
    /// CEF name: `SSL_CONNECTION_VERSION_SSL2`
    case ssl2 = 1
    
    /// CEF name: `SSL_CONNECTION_VERSION_SSL3`
    case ssl3 = 2
    
    /// CEF name: `SSL_CONNECTION_VERSION_TLS1`
    case tls1 = 3
    
    /// CEF name: `SSL_CONNECTION_VERSION_TLS1_1`
    case tls1_1 = 4
    
    /// CEF name: `SSL_CONNECTION_VERSION_TLS1_2`
    case tls1_2 = 5
    
    /// CEF name: `SSL_CONNECTION_VERSION_TLS1_3`
    case tls1_3 = 6
    
    /// CEF name: `SSL_CONNECTION_VERSION_QUIC`
    case quic = 7
}

extension CEFSSLVersion {
    static func fromCEF(_ value: cef_ssl_version_t) -> CEFSSLVersion {
        return CEFSSLVersion(rawValue: Int32(value.rawValue))!
    }
    
    func toCEF() -> cef_ssl_version_t {
        return cef_ssl_version_t(rawValue: UInt32(rawValue))
    }
}
