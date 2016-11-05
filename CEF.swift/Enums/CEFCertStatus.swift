//
//  CEFCertStatus.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2016. 11. 01..
//  Copyright © 2016. Tamas Lustyik. All rights reserved.
//

import Foundation

public extension CEFCertStatus {

    /// Returns true if the certificate status has any error, major or minor.
    /// CEF name: `IsCertStatusError`
    public var isError: Bool {
        return cef_is_cert_status_error(self.toCEF()) != 0
    }
    
    /// Returns true if the certificate status represents only minor errors
    /// (e.g. failure to verify certificate revocation).
    /// CEF name: `IsCertStatusMinorError`
    public var isMinorError: Bool {
        return cef_is_cert_status_minor_error(self.toCEF()) != 0
    }

}
