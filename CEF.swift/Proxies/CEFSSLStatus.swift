//
//  CEFSSLStatus.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2016. 11. 01..
//  Copyright © 2016. Tamas Lustyik. All rights reserved.
//

import Foundation

public extension CEFSSLStatus {
    
    /// Returns true if the status is related to a secure SSL/TLS connection.
    /// CEF name: `IsSecureConnection`
    public var isSecureConnection: Bool {
        return cefObject.is_secure_connection(cefObjectPtr) != 0
    }
    
    /// Returns a bitmask containing any and all problems verifying the server
    /// certificate.
    /// CEF name: `GetCertStatus`
    public var certStatus: CEFCertStatus {
        let cefStatus = cefObject.get_cert_status(cefObjectPtr)
        return CEFCertStatus.fromCEF(cefStatus)
    }
    
    /// Returns the SSL version used for the SSL connection.
    /// CEF name: `GetSSLVersion`
    public var sslVersion: CEFSSLVersion {
        let cefVersion = cefObject.get_sslversion(cefObjectPtr)
        return CEFSSLVersion.fromCEF(cefVersion)
    }
    
    /// Returns a bitmask containing the page security content status.
    /// CEF name: `GetContentStatus`
    public var contentStatus: CEFSSLContentStatus {
        let cefStatus = cefObject.get_content_status(cefObjectPtr)
        return CEFSSLContentStatus.fromCEF(cefStatus)
    }
    
    /// Returns the X.509 certificate.
    /// CEF name: `GetX509Certificate`
    public var x509Certificate: CEFX509Certificate {
        let cefCert = cefObject.get_x509certificate(cefObjectPtr)
        return CEFX509Certificate.fromCEF(cefCert)!
    }
    
}
