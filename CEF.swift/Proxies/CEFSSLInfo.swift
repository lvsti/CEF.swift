//
//  CEFSSLInfo.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 05..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

public extension CEFSSLInfo {

    /// Returns a bitmask containing any and all problems verifying the server
    /// certificate.
    /// CEF name: `GetCertStatus`
    public var certStatus: CEFCertStatus {
        let cefStatus = cefObject.get_cert_status(cefObjectPtr)
        return CEFCertStatus.fromCEF(cefStatus)
    }

    /// Returns the X.509 certificate.
    /// CEF name: `GetX509Certificate`
    public var x509Certificate: CEFX509Certificate {
        let cefCert = cefObject.get_x509certificate(cefObjectPtr)
        return CEFX509Certificate.fromCEF(cefCert)!
    }
    
}
