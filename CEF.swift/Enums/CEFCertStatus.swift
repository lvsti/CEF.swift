//
//  CEFCertStatus.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2016. 11. 01..
//  Copyright © 2016. Tamas Lustyik. All rights reserved.
//

import Foundation

public extension CEFCertStatus {

    /// Returns true if the certificate status represents an error.
    /// CEF name: `CefIsCertStatusError`
    public var isError: Bool {
        return cef_is_cert_status_error(self.toCEF()) != 0
    }
    
}
