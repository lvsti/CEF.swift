//
//  CEFURLRequestFlags.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 01..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

public struct URLRequestFlags: OptionSetType {
    public let rawValue: UInt
    public init(rawValue: UInt) {
        self.rawValue = rawValue
    }
    
    public static let None = URLRequestFlags(rawValue: 0)
    public static let SkipCache = URLRequestFlags(rawValue: 1 << 0)
    public static let AllowCachedCredentials = URLRequestFlags(rawValue: 1 << 1)
    public static let ReportUploadProgress = URLRequestFlags(rawValue: 1 << 3)
    public static let ReportRawHeaders = URLRequestFlags(rawValue: 1 << 5)
    public static let NoDownloadData = URLRequestFlags(rawValue: 1 << 6)
    public static let NoRetryOn5XX = URLRequestFlags(rawValue: 1 << 7)
    
    static func fromCEF(value: cef_urlrequest_flags_t) -> URLRequestFlags {
        return URLRequestFlags(rawValue: UInt(value.rawValue))
    }
    
    func toCEF() -> cef_urlrequest_flags_t {
        return cef_urlrequest_flags_t(rawValue: UInt32(rawValue))
    }
}

