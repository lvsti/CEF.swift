//
//  CEFSelectClientCertificateCallback.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2016. 11. 01..
//  Copyright © 2016. Tamas Lustyik. All rights reserved.
//

import Foundation

public extension CEFSelectClientCertificateCallback {
    
    /// Chooses the specified certificate for client certificate authentication.
    /// NULL value means that no client certificate should be used.
    /// CEF name: `Select`
    public func doSelect(certificate cert: CEFX509Certificate?) {
        cefObject.select(cefObjectPtr, cert?.toCEF())
    }
    
}
